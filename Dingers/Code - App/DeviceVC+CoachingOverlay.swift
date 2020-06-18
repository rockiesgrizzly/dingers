//
//  DeviceVC+CoachingOverlay.swift
//  Dingers
//
//  Created by joshmac on 6/4/20.
//  Copyright © 2020 Floyd Hill Code Ltd. All rights reserved.
//

import ARKit

extension DeviceViewController {
    func showCoachingOverlayView() {
        coachingOverlayView.session = deviceArView.session
        coachingOverlayView.goal = .horizontalPlane
        coachingOverlayView.delegate = self
        coachingOverlayView.activatesAutomatically = false
        coachingOverlayView.setActive(true, animated: true)
    }
    
    func removeCoachingOverlayView() {
        coachingOverlayView.setActive(false, animated: false)
        coachingOverlayView.removeFromSuperview()
    }
    
}

extension DeviceViewController: ARCoachingOverlayViewDelegate {
    
}

//extension DeviceViewController: ARSessionDelegate, ARSCNViewDelegate {
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
////        let screenCenter = CGPoint(x: deviceArView.frame.midX,
////                                   y: deviceArView.frame.midY)
////        guard let results = deviceArView.hitTest(screenCenter, types: [.existingPlaneUsingExtent]) else { return }
//
//        // startLabel.isHidden = false
//        
//        if !gameStarted {
//            respondToDeviceSurfaceFound()
//            removeCoachingOverlayView()
//            gameStarted = true
//        }
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        guard !gameStarted else { return }
//        setupTargetMarker()
//    }
//
//    private func setupTargetMarker() {
//        // set up marker so user knows where game will set up in AR world
//        let screenCenter = CGPoint(x: deviceArView.frame.midX,
//                                   y: deviceArView.frame.midY)
//        let hitTest = deviceArView.hitTest(screenCenter, types: [.existingPlane,
//                                                                 .featurePoint,
//                                                                 .estimatedHorizontalPlane])
//        guard let result = hitTest.first(where: { result -> Bool in
//            // ignore too close or far away
//            guard result.distance > 0.5 && result.distance < 2.0
//                || coachingOverlayView.isActive else { return false }
//
//            // make sure anchor is horizontal place w/ reasonable extent
//
//            return true
//        }) else { return }
//
//    }
//}
