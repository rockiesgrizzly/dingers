//
//  DeviceVC+BaseballGameControllerDelegate.swift
//  Dingers
//
//  Created by joshmac on 6/17/20.
//  Copyright © 2020 Floyd Hill Code Ltd. All rights reserved.
//

import ARKit
import Foundation
import RealityKit

extension DeviceViewController: BaseballGameControllerDelegate {
    func gameContentIsLoaded(for gameController: Baseball.GameController) {
        // might need to remove ball here?
        deviceArView.scene.anchors.removeAll()
        guard let game = gameController.baseballSceneAnchor else { return }
        
        // not currently using multiplayer, so this saves memory
        game.passThroughChildren { $0.synchronization = nil }
        
        disablePhysicsForContentLoad(in: game)
        displayGuideForGamePlacement(in: game)
        // enablePhysicsForContentLoad(in: game)
    }
    
    // TODO: study m41-43, SCNNode
    private func displayGuideForGamePlacement(in game: Baseball.Scene) {
        guard let hitTestResult = usableHitTestResult() else { return }
        let worldTransform = SCNMatrix4(hitTestResult.worldTransform)
        gamePosition = SCNVector3Make(worldTransform.m41,
                                           worldTransform.m42,
                                           worldTransform.m43)
        if visibleNode == nil {
            let visiblePlane = SCNPlane(width: 0.3, height: 0.3)
            visiblePlane.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "target")
            visibleNode = SCNNode(geometry: visiblePlane)
            visibleNode.eulerAngles.x = .pi * -0.5
            // sceneView.scene.rootNode.addChildNode(visNode)
            
        }
        visibleNode.position = gamePosition
    }
    
    // TODO: study andchor extents
    private func usableHitTestResult() -> ARHitTestResult? {
        let displayCenter = CGPoint(x: deviceArView.frame.midX,
                                    y: deviceArView.frame.midY)
        let arViewHitTestResults =  deviceArView.hitTest(displayCenter,
                                                        types: .existingPlaneUsingExtent)
        return arViewHitTestResults.first { result -> Bool in
            // catch distances too close or far
            guard (result.distance > 0.5
                && result.distance < 2.0)
                || coachingOverlayView.isActive else { return false }
            
            // catch non-reasonable extent for horizontal plane in real world
            guard let planeAnchor = result.anchor as? ARPlaneAnchor,
                planeAnchor.alignment == .horizontal else { return false}
            
            let extent = simd_length(planeAnchor.extent)
            guard extent > 1 && extent < 2 else { return false }
            
            return true
        }
    }
    
    private func setupGestureRecognizers() {
        
    }
    
    private func setupGameAnchors() {
        
    }
    
    /// allow RealityKit to place scene before physics activate
    private func disablePhysicsForContentLoad(in game: Baseball.Scene) {
        game.passThroughChildren { entity in
            guard let physicsEntity = entity as? Entity & HasPhysics else { return }
            defaultPhysicsMode[entity] = physicsEntity.physicsBody?.mode
            physicsEntity.physicsBody?.mode = .static
        }
    }
    
    /// enable physics after RK places scene
    private func enablePhysicsForContentLoad(in game: Baseball.Scene) {
        DispatchQueue.main.async {
            game.passThroughChildren { [weak self] entity in
                guard let self = self,
                    let physicsEntity = entity as? Entity & HasPhysics,
                    let defaultMode = self.defaultPhysicsMode[entity] else { return }
                physicsEntity.physicsBody?.mode = defaultMode
            }
        }
    }
    
    func playerInteractionIsReady(in gameController: Baseball.GameController) {
        //
    }
    
    func gameIsReadyForContentPlacement(in gameController: Baseball.GameController) {
        // need idle timer here or no?
        showCoachingOverlayView()
    }
    
    func gameIsReadyForPlayerPitch(via gameController: Baseball.GameController) {
        //
    }
    
    func playerCompletedPitch(via gameController: Baseball.GameController) {
        //
    }
    
}
