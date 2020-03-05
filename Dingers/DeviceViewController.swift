//
//  DeviceViewController.swift
//  Dingers
//
//  Created by joshmac on 3/4/20.
//  Copyright © 2020 Floyd Hill Code Ltd. All rights reserved.
//

import UIKit
import RealityKit

/// main view controller shown on mobile device in AR
class DeviceViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        guard let boxAnchor = try? Baseball.loadScene() else { return }
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
}
