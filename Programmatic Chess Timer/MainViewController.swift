//
//  MainViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 2/18/21.
//

import UIKit

class MainViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
