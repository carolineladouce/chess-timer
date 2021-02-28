//
//  MainViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 2/18/21.
//

import UIKit

var GAME_TIME = 0

class MainViewController: UIViewController {
    
    var model = Model()
    
    
    // remaining time for player 1
    var player1timeout = GAME_TIME
    
    // remaining time for player 2
    var player2timeout = GAME_TIME
    
    var timer: Timer?

    // true if game is paused
    var isPaused = false
    
    var gameEnded = false
    
    enum GameState: Int {
        case stopped
        case running
        case paused
    }
    
    var gameState: GameState = .stopped
    
    
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView()
        view.backgroundColor = UIColor.white
        
        let marginsGuide = view.layoutMarginsGuide
        
        
        // Create Middle Buttons:
        
        // Create switch-turns button:
        let setTurnButton = UIButton(type: .system)
        setTurnButton.setTitle("Change Turns", for: .normal)
        setTurnButton.backgroundColor = .black
    
        view.addSubview(setTurnButton)

        // Add button action:
        setTurnButton.addTarget(self, action: #selector(setTurnButtonAction), for: .touchDown)
        
        // Set button constraints:
        setTurnButton.translatesAutoresizingMaskIntoConstraints = false
        setTurnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setTurnButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        self.view = view
        
        
        // Create Start/Pause button:
        let startPauseButton = UIButton(type: .system)
        startPauseButton.setTitle("Start/Pause", for: .normal)
        startPauseButton.backgroundColor = .lightGray
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(startPauseButton)
        
        // Add button action:
        startPauseButton.addTarget(self, action: #selector(startPauseButtonAction), for: .touchDown)
        
        NSLayoutConstraint.activate([
            startPauseButton.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
        ])
        
        startPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view = view
        
        
        // Create Reset Button
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.backgroundColor = .orange
        
        view.addSubview(resetButton)
        
        // Add button action:
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchDown)
        
        NSLayoutConstraint.activate([
        resetButton.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor)
        ])
        
        resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view = view
        
        
        //---------------------
        
        // Create Timer Labels:
      
        // Create Top Label/Player 1 clock:
        var player1clock = UILabel()
        player1clock.text = "0"
        player1clock.translatesAutoresizingMaskIntoConstraints = false
      
        view.addSubview(player1clock)
        
        NSLayoutConstraint.activate([
            player1clock.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -125),
        ])
        
        player1clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        player1clock.transform = CGAffineTransform(rotationAngle: .pi)
        
        self.view = view
        
        
        // Create Bottom Label:
        var player2clock = UILabel()
        player2clock.text = "0"
        player2clock.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(player2clock)
        
        NSLayoutConstraint.activate([
            player2clock.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 125)
        ])
        
        player2clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view = view
        
        
        
        // Format the timers:
        func formatTimer(time: TimeInterval) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format: "%02i:%02i", minutes, seconds)
        }
        
        player1clock.text = formatTimer(time: TimeInterval(GAME_TIME))
        player2clock.text = formatTimer(time: TimeInterval(GAME_TIME))
        
        
        
        
        
        
        
        
        
        
        
    }
    
    // MARK: - Touch Handlers
    
    @objc func startPauseButtonAction(sender: UIButton!) {
        self.model.startPauseGame()
    }
    
    @objc func setTurnButtonAction(sender: UIButton!) {
        self.model.changeTurn()
    }
    
    @objc func resetButtonAction(sender: UIButton!) {
        self.model.resetGame()
    }
    
    
    
    
    
    // End Class
}
    

    
    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

