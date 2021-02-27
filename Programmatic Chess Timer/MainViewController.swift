//
//  MainViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 2/18/21.
//

import UIKit

class MainViewController: UIViewController {
    
    var model = Model()

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
        
        
        
        
        // Create Timer Labels:
        
        // Create Top Label:
        let topLabel = UILabel()
        topLabel.text = "00:00"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
      
        view.addSubview(topLabel)
        
        NSLayoutConstraint.activate([
            topLabel.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -125),
        ])
        
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view = view
        
        
        // Create Bottom Label:
        let bottomLabel = UILabel()
        bottomLabel.text = "00:00"
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 125)
        ])
        
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view = view
        
        
        
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
    

