//
//  DeviceVC+CoachingOverlay.swift
//  Dingers
//
//  Created by joshmac on 6/4/20.
//  Copyright © 2020 Floyd Hill Code Ltd. All rights reserved.
//

import ARKit

extension DeviceViewController: ARCoachingOverlayViewDelegate {
    func showCoachingOverlayView() {
        let newcoachingOverlayView = ARCoachingOverlayView()
        
        newcoachingOverlayView.delegate = self
        newcoachingOverlayView.session = deviceArView.session
        view.addSubview(newcoachingOverlayView)
        setupConstraintAnchors(for: newcoachingOverlayView)
    }
    
    private func setupConstraintAnchors(for childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: deviceArView.topAnchor, constant: 0),
            childView.leadingAnchor.constraint(equalTo: deviceArView.leadingAnchor, constant: 0),
            childView.trailingAnchor.constraint(equalTo: deviceArView.trailingAnchor, constant: 0),
            childView.bottomAnchor.constraint(equalTo: deviceArView.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - ARCoachingOverlayViewDelegate
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        respondToDeviceSurfaceFound()
    }
    
}
