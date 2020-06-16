//
//  Baseball+GameController.swift
//  Dingers
//
//  Created by joshmac on 6/16/20.
//  Copyright © 2020 Floyd Hill Code Ltd. All rights reserved.
//

import Foundation
import RealityKit

protocol BaseballGameControllerDelegate: class {
    /// following successful gameAnchor content load
    func gameContentIsLoaded(for gameController: Baseball.GameController)
    func playerInteractionIsReady(in gameController: Baseball.GameController)
    func gameIsReadyForContentPlacement(in gameController: Baseball.GameController)
    func gameIsReadyForPlayerPitch(via gameController: Baseball.GameController)
    func playerCompletedPitch(via gameController: Baseball.GameController)
}

extension Baseball {
    struct AnchorInfo {
        var uuid : UUID?
        var transform: Transform?
    }
    
    indirect enum GameState: Equatable {
        case initializing
        case startingArSetup
        case displayingCoachingOverlay
        case placingContent
        /// Game content is loading and the app is waiting for the load to complete before transitioning to the next state.
        case waitingForContent(nextState: GameState)
        case readyToPitch
        case ballIsMoving
        case ballFinishedMoving
        case arFrameCompleted(strikeDetected: Bool)
    }
    
    class GameController {
        // MARK: - Private Vars
        private var currentGameState: GameState = .initializing
        private weak var delegate: BaseballGameControllerDelegate?
        
        // MARK: - Internal Vars
        var anchorInfo: AnchorInfo?
        var baseballSceneAnchor: Baseball.Scene!
        
        // MARK: - Computed Vars
        var baseball: (Entity & HasPhysics)? {
            baseballSceneAnchor?.baseball as? Entity & HasPhysics
        }
        
        var dingerBat: (Entity & HasPhysics)? {
            baseballSceneAnchor?.baseball as? Entity & HasPhysics
        }
        
        var homeBase: (Entity & HasPhysics)? {
            baseballSceneAnchor?.homeBase as? Entity & HasPhysics
        }
        
        // MARK: - Lifecycle
        init(with delegate: BaseballGameControllerDelegate) {
            self.delegate = delegate
        }
        
        // MARK: - GameState Handling
        func initialize() {
            transition(to: .startingArSetup)
        }
        
        private func transition(to gameState: GameState) {
            
        }
    }
}
