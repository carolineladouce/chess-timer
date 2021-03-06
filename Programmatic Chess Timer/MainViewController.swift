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
                startPauseButton.setTitle("start", for: UIControl.State.normal)
                startPauseButton.setTitleColor(UIColor.darkGray, for: .normal)
                
                changeGradientBlockColors()
            }
            if newValue == .running {
                // Timers:
                gameTimer()
                textBackgroundChangeColor()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("pause", for: UIControl.State.normal)
                startPauseButton.setTitleColor(UIColor.darkGray, for: .normal)
                
                changeGradientBlockColors()
            }
            if newValue == .paused {
                // Timers:
                clearTimer()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("go", for: UIControl.State.normal)
                
                self.startPauseButton.setTitleColor(UIColor.systemPurple, for: .normal)
                
                changeGradientBlockColors()
            }
            
            if newValue == .ended {
                // Timers:
                clearTimer()
                
                // Start/Pause, Set Turns, and Reset buttons:
                startPauseButton.setTitle("end", for: UIControl.State.normal)
                startPauseButton.setTitleColor(UIColor.darkGray, for: .normal)
                
                changeGradientBlockColors()
            }
        }
    } // End gameState
    
    
    var player1timeout = DEFAULT_GAME_TIME
    var player2timeout = DEFAULT_GAME_TIME
    
    var timer: Timer?
    
    let startPauseButton = UIButton(type: .system)
    var startPauseButtonYAnchor: NSLayoutConstraint!
    var startPauseButtonLeading: NSLayoutConstraint!

    
    let setTurnButton = GradientButton()
    
    let resetButton = UIButton(type: .system)
    var resetButtonYAnchor: NSLayoutConstraint!
    var resetButtonTrailing: NSLayoutConstraint!
    
    var player1clock = UILabel()
    var player2clock = UILabel()
    
    // ------------------------------------------------------
    // Add gradient block:
    var gradientBlock: CAGradientLayer = {
        var layer = CAGradientLayer()
        layer.type = .axial

        layer.locations = [0, 1]

        return layer
    }()
    
    
    // ------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        //textBackgroundChangeColor()
        
        let marginsGuide = view.layoutMarginsGuide
        
        
        view.layer.addSublayer(gradientBlock)
        gradientBlock.frame = view.bounds

        
        // --------------------------------------------------
        // Create Middle Buttons:
        
        // Start/Pause Button:
        startPauseButton.setTitle("start", for: .normal)
        startPauseButton.setTitleColor(.darkGray, for: .normal)
//        startPauseButton.setTitleColor(UIColor(red: 87/255, green: 84/255, blue: 255/255, alpha: 1), for: .highlighted)
        startPauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(startPauseButton)
        
        // Add button action:
        startPauseButton.addTarget(self, action: #selector(startPauseButtonAction), for: .touchDown)
        
        let turn1StartPauseButtonYAnchor = startPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        let turn2StartPauseButtonYAnchor = startPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30)
            
        let startPauseButtonLeadingAnchor = startPauseButton.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20)
        
        
        startPauseButtonLeading = startPauseButtonLeadingAnchor
        
        if turn == 1 {
            startPauseButtonYAnchor = turn1StartPauseButtonYAnchor
        } else {
            startPauseButtonYAnchor = turn2StartPauseButtonYAnchor
        }
        
       
        
        // Constraints:
        NSLayoutConstraint.activate([
            startPauseButtonYAnchor,
            startPauseButtonLeading
        ])
        

        self.view = view
        
        
        // --------------------------------------------------
        // Switch-turns button:

        view.addSubview(setTurnButton)
    
        // Constraints:
        setTurnButton.translatesAutoresizingMaskIntoConstraints = false
        setTurnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setTurnButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        setTurnButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        setTurnButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view = view
        
        self.setupChangeTurnsButtonTap()
        
        
        // --------------------------------------------------
        // Reset Button:
        resetButton.setTitle("reset", for: .normal)
        resetButton.setTitleColor(.darkGray, for: .normal)
        resetButton.setTitleColor(.purple, for: .highlighted)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(resetButton)
        
        // Add button action:
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchDown)
        
        
        
        let turn1resetButtonYAnchor = resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        let turn2resetButtonYAnchor = resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30)
        
        
        let resetButtonTrailingAnchor = resetButton.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -20)
        
        resetButtonTrailing = resetButtonTrailingAnchor
        
        if turn == 1 {
            resetButtonYAnchor = turn1resetButtonYAnchor
        } else {
            resetButtonYAnchor = turn2resetButtonYAnchor
        }
        
        
        
        
        // Constraints:
        NSLayoutConstraint.activate([
            resetButtonYAnchor,
            resetButtonTrailing
        ])
        
        
        
        self.view = view
        
        
        // --------------------------------------------------
        // Create Timer Labels:
        
        // Top Label/ player1clock:
        player1clock.text = "0"
        player1clock.textColor = .lightGray
        player1clock.font = UIFont.boldSystemFont(ofSize: 96)
        player1clock.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(player1clock)
        
        NSLayoutConstraint.activate([
            player1clock.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -175),
        ])
        
        player1clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        player1clock.transform = CGAffineTransform(rotationAngle: .pi)
        
        self.view = view
        
        
        // --------------------------------------------------
        // Create Bottom Label/ player2clock:
        player2clock.text = "0"
        player2clock.textColor = .white
        player2clock.font = UIFont.boldSystemFont(ofSize: 96)
        player2clock.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        view.addSubview(player2clock)
        
//        if turn == 1 {
//            player2clock.layer.shadowColor = UIColor.darkGray.cgColor
//            player2clock.layer.shadowRadius = 5
//            player2clock.layer.shadowOpacity = 0
//        } else {
//            player2clock.layer.shadowColor = UIColor.darkGray.cgColor
//            player2clock.layer.shadowRadius = 5
//            player2clock.layer.shadowOpacity = 0.5
//        }
        
        
        NSLayoutConstraint.activate([
            player2clock.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 175)
        ])
        
        player2clock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view = view
        
        
        
        
        
        player1clock.text = formatTimer(time: TimeInterval(player1timeout))
        player2clock.text = formatTimer(time: TimeInterval(player2timeout))
        
        
        
        self.setupLabelTap()
        
    }
    // End viewDidLoad()
    
    
    // ------------------------------------------------------
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        if turn == 2 {
            self.gradientBlock.frame = CGRect(x: 25, y: self.view.frame.size.height / 2, width: self.view.frame.width - 50, height: self.view.frame.size.height / 2)
            
            
            
            gradientBlock.colors = [
                UIColor(red: 87/255, green: 84/255, blue: 255/255, alpha: 1).cgColor,
                UIColor(red: 255/255, green: 139/255, blue: 118/255, alpha: 1).cgColor
                
                
            ]
            
            
        } else {
            self.gradientBlock.frame = CGRect(x: 25, y: 0, width: self.view.frame.width - 50, height: self.view.frame.size.height / 2)
            
            gradientBlock.colors = [
                UIColor(red: 255/255, green: 139/255, blue: 118/255, alpha: 1).cgColor,
                UIColor(red: 87/255, green: 84/255, blue: 255/255, alpha: 1).cgColor
                
                
            ]
           
        }
        
   
        gradientBlock.shadowColor = UIColor.darkGray.cgColor
//        gradientBlock.shadowOffset = CGSize(width: 5, height: 5)
        gradientBlock.shadowRadius = 8
        gradientBlock.shadowOpacity = 1
        gradientBlock.cornerRadius = 10
        
        
    }
    
    // ------------------------------------------------------
    
    
    // Timer:
    // Format the timers:
    func formatTimer(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if minutes < 10 {
            return String(format: "%i:%02i", minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
        
        
    } // End formatTimer
    
    
     
    
    
    
    
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
        if turn == 2 {
            //player1clock.backgroundColor = UIColor.green
            player1clock.textColor = UIColor.lightGray
            
//            player1clock.layer.shadowColor = UIColor.darkGray.cgColor
//            player1clock.layer.shadowRadius = 5
//            player1clock.layer.shadowOpacity = 0
            
            
            //player2clock.backgroundColor = UIColor.black
            player2clock.textColor = UIColor.white
            
//            player2clock.layer.shadowColor = UIColor.darkGray.cgColor
//            player2clock.layer.shadowRadius = 5
//            player2clock.layer.shadowOpacity = 0.5
            
        } else {
            //player2clock.backgroundColor = UIColor.green
            player2clock.textColor = UIColor.lightGray
            
//            player2clock.layer.shadowColor = UIColor.darkGray.cgColor
//            player2clock.layer.shadowRadius = 5
//            player2clock.layer.shadowOpacity = 0
            
            
            //player1clock.backgroundColor = UIColor.black
            player1clock.textColor = UIColor.white
            
//            player1clock.layer.shadowColor = UIColor.darkGray.cgColor
//            player1clock.layer.shadowRadius = 5
//            player1clock.layer.shadowOpacity = 0.5
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
        gameState = .stopped
        changeGradientBlockColors()
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
    

    
    
    
    
    
    
    
    
    @objc func changeTurnsButtonTapped( sender: UITapGestureRecognizer) {
        changeTurns()
        textBackgroundChangeColor()
        print("turn is: \(turn)")
        
        UIView.animate(withDuration: 0.3) { [self] in
            self.setTurnButton.transform = CGAffineTransform(rotationAngle: self.turn == 1 ? CGFloat.pi : 0)
 
        } // End UIView.animate
        
        
        // Alter the start/pause and reset button constraints:
        
        NSLayoutConstraint.deactivate([
            startPauseButtonYAnchor,
            resetButtonYAnchor
        ])
        
        var altStartPauseButtonYAnchor: NSLayoutConstraint
        var altResetButtonYAnchor: NSLayoutConstraint
        
        if startPauseButtonYAnchor.constant == 30 && resetButtonYAnchor.constant == 30 {
            altStartPauseButtonYAnchor = startPauseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -35)
            altResetButtonYAnchor = resetButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -35)
        } else {
            altStartPauseButtonYAnchor = startPauseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30)
            altResetButtonYAnchor = resetButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30)
        }
        
        
        NSLayoutConstraint.activate([
            altStartPauseButtonYAnchor,
            altResetButtonYAnchor
        ])
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.65, initialSpringVelocity: 0) {
            self.view.layoutIfNeeded()
            self.startPauseButtonYAnchor = altStartPauseButtonYAnchor
            self.resetButtonYAnchor = altResetButtonYAnchor
        }
        
        
        let animateStartButton = startPauseButton
        let animateResetButton = resetButton
        
        if turn == 2 {
            print("Block should be on bottom")
            
            UIView.animate(withDuration: 0.5) {
                animateStartButton.alpha = 0
                animateResetButton.alpha = 0
            }
            
            self.gradientBlock.frame = CGRect(x: 25, y: self.view.frame.size.height / 2, width: self.view.frame.width - 50, height: self.view.frame.size.height / 2)
            
            
            
            self.startPauseButton.transform = CGAffineTransform(rotationAngle: 0)
            self.resetButton.transform = CGAffineTransform(rotationAngle: 0)
            
            UIView.animate(withDuration: 0.5) {
                animateStartButton.alpha = 10
                animateResetButton.alpha = 10
            }
            
        } else {
            print("Block should be on top")
            
            UIView.animate(withDuration: 0.5) {
                animateStartButton.alpha = 0
                animateResetButton.alpha = 0
            }

            self.gradientBlock.frame = CGRect(x: 25, y: 0, width: self.view.frame.width - 50, height: self.view.frame.size.height / 2)
            
            self.startPauseButton.transform = CGAffineTransform(rotationAngle: .pi)
            self.resetButton.transform = CGAffineTransform(rotationAngle: .pi)
            
            UIView.animate(withDuration: 0.5) {
                animateStartButton.alpha = 10
                animateResetButton.alpha = 10
            }
            
            
        }
        
        
        changeGradientBlockColors()
        
        
    } // End func changeTurnsButtonTapped
    
    
    
    func changeGradientBlockColors() {
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 1
        
        switch gameState {
        case .stopped:
            if self.turn == 1 {
                gradientChangeAnimation.toValue = [
                    UIColor(red: 255/255, green: 139/255, blue: 118/255, alpha: 1).cgColor,
                    UIColor(red: 87/255, green: 84/255, blue: 255/255, alpha: 1).cgColor
                ]
            } else {
                gradientChangeAnimation.toValue = [
                    UIColor(red: 87/255, green: 84/255, blue: 255/255, alpha: 1).cgColor,
                    UIColor(red: 255/255, green: 139/255, blue: 118/255, alpha: 1).cgColor
                ]
            }

        case .running:
            
            if self.turn == 1 {
                    gradientChangeAnimation.toValue = [
                        UIColor(red: 255/255, green: 198/255, blue: 114/255, alpha: 1).cgColor,
                        UIColor(red: 255/255, green: 142/255, blue: 169/255, alpha: 1).cgColor
                    ]
                } else {
                    gradientChangeAnimation.toValue = [
                        UIColor(red: 255/255, green: 142/255, blue: 169/255, alpha: 1).cgColor,
                        UIColor(red: 255/255, green: 198/255, blue: 114/255, alpha: 1).cgColor
                    ]
                }
            
            
        case .paused:
            if self.turn == 1 {
                gradientChangeAnimation.toValue = [
                    UIColor(red: 141/255, green: 71/255, blue: 255/255, alpha: 1).cgColor,
                    UIColor(red: 79/255, green: 117/255, blue: 255/255, alpha: 1).cgColor
                    
                ]
            } else {
                gradientChangeAnimation.toValue = [
                    UIColor(red: 79/255, green: 117/255, blue: 255/255, alpha: 1).cgColor,
                    UIColor(red: 141/255, green: 71/255, blue: 255/255, alpha: 1).cgColor
                    
                ]
            }
            
            
        case .ended:
            if self.turn == 1 {
                gradientChangeAnimation.toValue = [
                    UIColor(red: 210/255, green: 116/255, blue: 254/255, alpha: 1).cgColor,
                    UIColor(red: 82/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
                ]
            } else {
                gradientChangeAnimation.toValue = [
                    UIColor(red: 82/255, green: 0/255, blue: 255/255, alpha: 1).cgColor,
                    UIColor(red: 210/255, green: 116/255, blue: 254/255, alpha: 1).cgColor
                ]
            }
        
        }
        
        
        
                gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
                gradientChangeAnimation.isRemovedOnCompletion = false
                gradientBlock.add(gradientChangeAnimation, forKey: "colorChange")
        
        
    }
    
    
    
    
    
    
    
        

    
    
    func setupChangeTurnsButtonTap() {
        let setTurnButton = UITapGestureRecognizer(target: self, action: #selector(self.changeTurnsButtonTapped(sender: )))
        self.setTurnButton.isUserInteractionEnabled = true
        self.setTurnButton.addGestureRecognizer(setTurnButton)
        
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
        
        changeGradientBlockColors()
    }
    
    
    @objc func setTurnButtonAction(sender: UIButton!) {
        changeTurns()
        textBackgroundChangeColor()
    }
    
    
    @objc func resetButtonAction(sender: UIButton!) {
        gameState = GameState.stopped
        
        changeGradientBlockColors()
        
    }
    
}
// End Class








