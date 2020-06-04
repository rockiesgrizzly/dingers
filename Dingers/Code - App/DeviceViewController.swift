//
//  DeviceViewController.swift
//  Dingers
//
//  Created by joshmac on 3/4/20.
//  Copyright © 2020 Floyd Hill Code Ltd. All rights reserved.
//

import ARKit
import AVKit
import Foundation
import RealityKit

/// main view controller shown on mobile device in AR
class DeviceViewController: UIViewController {
    // MARK: - Variables
    var baseballScene: Baseball.Scene?
    // var gameController: Baseball.GameController?
    
    // objects in scene
    var baseball: Entity?
    var homeBase: Entity?
    var dingerBat: Entity?
    
    // Progress Trackers
    //var deviceFoundSurface = false
    var gameStarted = false
    
    var coachingOverlayView: ARCoachingOverlayView?
    
    // MARK: - IBOutlets
    /// root AR view
    @IBOutlet var deviceArView: ARView!
    
    @IBOutlet weak var startLabel: UILabel!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         if cameraUsageIsEnabled() {
            // need to allow time upon first usage
             showCoachingOverlayView()
         } else {
            // add handling for permission enabling
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deviceArView.session.pause()
    }
    
    // MARK: - Setup
    func cameraUsageIsEnabled() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: return true
        default: return false
        }
    }
    
    
    /// triggered when coaching overlay is dismissed (surface found)
    func respondToDeviceSurfaceFound() {
        setupBaseballScene()
        startLabel.isHidden = false
    }
    
    private func configureSession() {
        let arTrackingConfig = ARWorldTrackingConfiguration()
        arTrackingConfig.planeDetection = .horizontal
        setupArViewDebugOptions()
        
        deviceArView.session.run(arTrackingConfig)
    }
    
    private func setupArViewDebugOptions() {
        deviceArView.debugOptions = [.showFeaturePoints,
                                     .showWorldOrigin]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            userTouchedAfterGameStart()
        } else {
            userTouchedFirstTime()
        }
    }
    
    private func userTouchedFirstTime() {
        startLabel.isHidden = true
        addSwipeGestureToArView()
        // start game
    }
    
    private func userTouchedAfterGameStart() {
        // game is running, so respond
    }
    
    private func setupBaseballScene() {
        guard let loadedScene = try? Baseball.loadScene()
            else { return assertionFailure("missing Baseball RC Scene")}
        
        baseballScene = loadedScene
        baseball = baseballScene?.baseball
        homeBase = baseballScene?.homeBase
        dingerBat = baseballScene?.dingerBat
        
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0, -0.1])
        deviceArView.scene.addAnchor(anchor)
        deviceArView.scene.anchors.append(loadedScene)
    }
    
    private func addSwipeGestureToArView() {
        let swipeGesture = UISwipeGestureRecognizer(target: self,
                                                    action:#selector(onSwipeReceived))
        deviceArView.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func onSwipeReceived() {
        print("made it")
    }
    
}


