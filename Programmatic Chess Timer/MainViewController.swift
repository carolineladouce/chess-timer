//
//  MainViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 2/18/21.
//

import UIKit

let DEFAULT_GAME_TIME = 10*60

class MainViewController: UIViewController {
    
    var game_time = DEFAULT_GAME_TIME
    
    public var turn = 2
    
    public enum GameState: Int {
        case stopped
        case running
        case paused
        case ended
    }
    
    public var gameState: GameState = .stopped {
        willSet {
            if newValue == .stopped {
                // Timers:
                clearTimer()
                player1timeout = game_time
                player2timeout = game_time
                updateBothLabels()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("START", for: UIControl.State.normal)
            }
            if newValue == .running {
                // Timers:
                gameTimer()
                textBackgroundChangeColor()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("PAUSE", for: UIControl.State.normal)
            }
            if newValue == .paused {
                // Timers:
                clearTimer()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("CONTINUE", for: UIControl.State.normal)
            }
            if newValue == .ended {
                // Timers:
                clearTimer()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("GAME ENDED", for: UIControl.State.normal)
            }
        }
    } // End gameState
    
    
    var player1timeout = DEFAULT_GAME_TIME
    var player2timeout = DEFAULT_GAME_TIME
    
    var timer: Timer?
    
    let startPauseButton = UIButton(type: .system)
    let setTurnButton = UIButton(type: .system)
    let resetButton = UIButton(type: .system)
    
    var player1clock = UILabel()
    var player2clock = UILabel()
    
    
    // ------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        textBackgroundChangeColor()
        
        let marginsGuide = view.layoutMarginsGuide
        
        // --------------------------------------------------
        // Create Middle Buttons:
        
        // Start/Pause Button:
        startPauseButton.setTitle("START", for: .normal)
        startPauseButton.backgroundColor = .lightGray
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(startPauseButton)
        
        // Add button action:
        startPauseButton.addTarget(self, action: #selector(startPauseButtonAction), for: .touchDown)
        
        // Constraints:
        NSLayoutConstraint.activate([
            startPauseButton.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
        ])
        startPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view = view
        
        
        // --------------------------------------------------
        // Switch-turns button:
        setTurnButton.setTitle("CHANGE TURNS", for: .normal)
        setTurnButton.backgroundColor = .systemPink
        
        view.addSubview(setTurnButton)
        
        // Add button action:
        setTurnButton.addTarget(self, action: #selector(setTurnButtonAction), for: .touchDown)
        
        // Constraints:
        setTurnButton.translatesAutoresizingMaskIntoConstraints = false
        setTurnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setTurnButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view = view
        
        
        // --------------------------------------------------
        // Reset Button:
        resetButton.setTitle("RESET", for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.backgroundColor = .orange
        
        view.addSubview(resetButton)
        
        // Add button action:
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchDown)
        
        // Constraints:
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor)
        ])
        resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view = view
        
        
        // --------------------------------------------------
        // Create Timer Labels:
        
        // Top Label/ player1clock:
        player1clock.text = "0"
        player1clock.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(player1clock)
        
        NSLayoutConstraint.activate([
            player1clock.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -125),
        ])
        
        player1clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        player1clock.transform = CGAffineTransform(rotationAngle: .pi)
        
        self.view = view
        
        
        // --------------------------------------------------
        // Create Bottom Label/ player2clock:
        player2clock.text = "0"
        player2clock.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(player2clock)
        
        NSLayoutConstraint.activate([
            player2clock.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 125)
        ])
        
        player2clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view = view
        
        player1clock.text = formatTimer(time: TimeInterval(player1timeout))
        player2clock.text = formatTimer(time: TimeInterval(player2timeout))
        
        self.setupLabelTap()
        
    }
    // End viewDidLoad()
    
    
    // ------------------------------------------------------
    
    // Timer:
    // Format the timers:
    func formatTimer(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    
    // Update timer/current player clock and label every second (while game .running)
    @objc func update() {
        if player1timeout <= 0 || player2timeout <= 0 {
            timer = nil
        } else if player1timeout > 0 || player2timeout > 0 {
            if self.turn == 1 {
                self.player1timeout -= 1
                if player1timeout <= 0 {
                    gameState = GameState.ended
                }
            } else {
                player2timeout -= 1
                if player2timeout <= 0 {
                    gameState = GameState.ended
                }
            }
        }
        updateBothLabels()
    }
    
    
    func gameTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    
    func clearTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func updateBothLabels() {
        player1clock.text = formatTimer(time: TimeInterval(player1timeout))
        player2clock.text = formatTimer(time: TimeInterval(player2timeout))
    }
    
    
    func ifTimeZeroThenEndGame() {
        if player1timeout == 0 {
            gameState = GameState.ended
        }
        if player2timeout == 0 {
            gameState = GameState.ended
        }
    }
    
    
    // ------------------------------------------------------
    
    func changeTurns() {
        turn = turn == 1 ? 2:1
    }
    
    
    func textBackgroundChangeColor() {
        if turn == 1 {
            player1clock.backgroundColor = UIColor.green
            player1clock.textColor = UIColor.black
            
            player2clock.backgroundColor = UIColor.black
            player2clock.textColor = UIColor.white
        } else if turn == 2 {
            player2clock.backgroundColor = UIColor.green
            player2clock.textColor = UIColor.black
            
            player1clock.backgroundColor = UIColor.black
            player1clock.textColor = UIColor.white
        }
    }
    

    
    // ------------------------------------------------------
    
    
    func showSetClockTime() {
        let setClockTime = SetClockTimeViewController()
        setClockTime.mainViewController = self
        self.present(setClockTime, animated: true, completion: {
            print("Completion of Presentation")
        })
    }
    
    
    @objc func LabelTapped(_ sender: UITapGestureRecognizer) {
        print("Label Tapped")
        self.showSetClockTime()
    }
    
    
    func setupLabelTap() {
        let player1clock = UITapGestureRecognizer(target: self, action: #selector(self.LabelTapped(_:)))
        self.player1clock.isUserInteractionEnabled = true
        self.player1clock.addGestureRecognizer(player1clock)
        
        let player2clock = UITapGestureRecognizer(target: self, action: #selector(self.LabelTapped(_:)))
        self.player2clock.isUserInteractionEnabled = true
        self.player2clock.addGestureRecognizer(player2clock)
    }
    
    
    
    func timeSelected(time: Int) {
        game_time = time
        player1timeout = time
        player2timeout = time
        
        updateBothLabels()
    }
    
    
    
    
// MARK: - Touch Handlers
    @objc func startPauseButtonAction(sender: UIButton!) {
        if gameState == GameState.stopped || gameState == MainViewController.GameState.paused {
            gameState = GameState.running
        } else if gameState == GameState.running {
            gameState = GameState.paused
        } else if gameState == GameState.ended {
            startPauseButton.setTitle("CLICK RESET", for: .normal)
        }
    }
    
    
    @objc func setTurnButtonAction(sender: UIButton!) {
        changeTurns()
        textBackgroundChangeColor()
    }
    
    
    @objc
    func resetButtonAction(sender: UIButton!) {
        gameState = GameState.stopped
    }
    
}
// End Class








