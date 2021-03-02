//
//  MainViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 2/18/21.
//

import UIKit

var GAME_TIME = 5

class MainViewController: UIViewController {
    
    //    var model = Model()
    
    
    
    public var turn = 0
    
    public var isPaused = false
    
    public var gameEnded = false
    
    public enum GameState: Int {
        case stopped
        case running
        case paused
    }
    
    public var gameState: GameState = .stopped
    
    
    
    
    // remaining time for player 1
    var player1timeout = GAME_TIME
    
    // remaining time for player 2
    var player2timeout = GAME_TIME
    
    var savePreviousGameTime = 0
    
    var timer: Timer?
    // true if game is paused
    
    let startPauseButton = UIButton(type: .system)
    
    var player1clock = UILabel()
    var player2clock = UILabel()
    
    
    // --------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        let marginsGuide = view.layoutMarginsGuide
        
        // --------------------------------------------------
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
        
        // --------------------------------------------------
        // Create Start/Pause button:
        
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
        
        // --------------------------------------------------
        
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
        
        // --------------------------------------------------
        
        // Create Timer Labels:
        
        // Create Top Label/Player 1 clock:
        
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
        
        // Create Bottom Label:
        
        player2clock.text = "0"
        player2clock.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(player2clock)
        
        NSLayoutConstraint.activate([
            player2clock.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 125)
        ])
        
        player2clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view = view
        
        
        
        player1clock.text = formatTimer(time: TimeInterval(GAME_TIME))
        player2clock.text = formatTimer(time: TimeInterval(GAME_TIME))
        
        
    } // End viewDidLoad()
    // --------------------------------------------------
    
    // Format the timers:
    func formatTimer(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    // this code belongs to a function. find the proper function that it should go to
    //        player1clock.text = formatTimer(time: TimeInterval(GAME_TIME))
    //        player2clock.text = formatTimer(time: TimeInterval(GAME_TIME))
    //
    
    
    
    
    
    // Update timer/current player clock and label every second
    @objc
    func update() {
        
//        if self.isPaused == false && player1timeout <= 0 || player2timeout <= 0 {
//            timer = nil
//        }
        
        
        
        if self.isPaused == false {
            
            if player1timeout <= 0 || player2timeout <= 0 {
                timer = nil
            } else if player1timeout > 0 || player2timeout > 0 {
            if self.turn == 1 {
                self.player1timeout -= 1
                if player1timeout <= 0 {
                    endGame()
                }
                
            } else {
                player2timeout -= 1
                if player2timeout <= 0 {
                    endGame()
                }
            }
        }
        updateBothLabels()
    }
    }
    
    
    /// Game timer
    func gameTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    
    func gameRunning() {
        // Clock needs to countdown
        // Text background colors need to change according to turn
        gameTimer()
        textBackgroundChangeColor()
    }
    
    
    // Change player turns (when x button is pressed)
    func changeTurns() {
        turn = turn == 1 ? 2:1
    }
    
    
    // Change text background colors
    // Green when it's a players turn
    // Red when it is not a players turn
    func textBackgroundChangeColor() {
        if turn == 1 {
            player1clock.backgroundColor = UIColor.green
            player2clock.backgroundColor = UIColor.red
        } else if turn == 2 {
            player2clock.backgroundColor = UIColor.green
            player1clock.backgroundColor = UIColor.red
        }
        
    }
    
    
    func updateLabels(shouldChangeTurn: Bool) {
        if shouldChangeTurn == true {
            changeTurns()
        }
        textBackgroundChangeColor()
    }
    
    
    // When game is paused, turns do not change
    func XButtonGamePaused() {
        //clearTimer()
        // doNotChangeTurns()
        updateLabels(shouldChangeTurn: false)
    }
    
    
    func clearTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    // If there is not a timer, start a timer
    func startGameTimer() {
        //        if timer == nil
        //        {
        gameTimer()
        //        }
        
    }
    
    
    func startGame() {
        player1timeout = GAME_TIME
        player2timeout = GAME_TIME
        
        turn = 2
        self.gameEnded = false
        updateBothLabels()
    }
    
    
    func updateBothLabels() {
        //player1clock.text = "\(player1timeout)"
        //player2clock.text = "\(player2timeout)"
        
        player1clock.text = formatTimer(time: TimeInterval(player1timeout))
        player2clock.text = formatTimer(time: TimeInterval(player2timeout))
    }
    
    
    func endGame() {
        clearTimer()
        self.gameEnded = true
    }
    
    
    func ifTimeZeroThenEndGame() {
        if player1timeout == 0 {
            endGame()
            turn = 0
            
            self.gameState = GameState.stopped
        }
        if player2timeout == 0 {
            endGame()
            turn = 0
            
            self.gameState = GameState.stopped
        }
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Touch Handlers
    @objc
    func startPauseButtonAction(sender: UIButton!) {
        switch self.gameState {
        case  GameState.stopped:
            
            if player1timeout <= 0 || player2timeout <= 0 {
                clearTimer()
                if GAME_TIME <= 0
                {
                    timer = nil
                    self.gameState = GameState.stopped
                } else {
                    gameTimer()
                    self.gameState = GameState.running
                    
                    self.startPauseButton.setTitle("PAUSE", for: UIControl.State.normal)
                }
                
            } else {
                gameTimer()
                self.gameState = GameState.running
                startPauseButton.setTitle("PAUSE", for: UIControl.State.normal)
            }
            
        case GameState.running:
            self.isPaused = true
            clearTimer()
            updateLabels(shouldChangeTurn: false)
            self.gameState = GameState.paused
            
            startPauseButton.setTitle("CONTINUE", for: UIControl.State.normal)
            
        case GameState.paused:
            self.isPaused = false
            
            
            gameTimer()
            self.gameState = GameState.running
            startPauseButton.setTitle("PAUSE", for: UIControl.State.normal)
        }
        
        //self.startGame()
    } // End start/pause button
    
    
    @objc func setTurnButtonAction(sender: UIButton!) {
        switch self.gameState {
        case GameState.stopped:
            // When x is pressed when the game is in stopped, change timer and colors
            updateLabels(shouldChangeTurn: true)
            
        case GameState.running:
            // When the game is running and x is pressed,
            // current players timer pauses and players change turns
            // activePlayer = activePlayer == 1? 2: 1
            updateLabels(shouldChangeTurn: true)
            
            
        case GameState.paused:
            // When paused, x button doesn't do anything
            self.isPaused = true
        }
        
        // self.changeTurns()
    }
    
    
    @objc
    func resetButtonAction(sender: UIButton!) {
        clearTimer()
        player1timeout = savePreviousGameTime
        player2timeout = savePreviousGameTime
        
        player1clock.text = formatTimer(time: TimeInterval(player1timeout))
        player2clock.text = formatTimer(time: TimeInterval(player2timeout))
        
        startPauseButton.setTitle("START", for: UIControl.State.normal)
        gameState = GameState.stopped
    }
    
    
    
    
    
    
    
    
}
// End Class











// MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }


