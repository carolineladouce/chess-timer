//
//  SetClockTimeViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 3/2/21.
//

import UIKit

class TimerButtonTapGestureRecognizer: UITapGestureRecognizer {
    var time: Int?
}


class SetClockTimeViewController: UIViewController {
   public var mainViewController: MainViewController?
    
    /// in seconds
    let times: [Int] = [1,2,3,5,10]
    var butttons: [TimerStackSection] = []

    var stackView = UIStackView()
    var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTitleLabel()
        configureStackView()
    }
    

    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addButtonsToStackView()
        
        // constraints
        setstackViewConstraints()
    }
    
    
//    func formatTimer(time: TimeInterval) -> String {
//        let minutes = Int(time) / 60 % 60
//        let seconds = Int(time) % 60
//        return String(format: "%02i:%02i", minutes, seconds)
//    }
    
    
    func addButtonsToStackView() {
        for i in times {
            let button = TimerStackSection()
            // do proper formatting
            
            let gr = TimerButtonTapGestureRecognizer(target: self, action: #selector(buttonTapped))
            gr.time = i
            
            
            
            button.setTitle("\(i)", for: .normal)
//            button.setTitle(formatTimer(time: TimeInterval(i)), for: .normal)
            
            button.isUserInteractionEnabled = true
            button.addGestureRecognizer(gr)
            stackView.addArrangedSubview(button)
            self.butttons.append(button)
        }
    }
    
    
    func setstackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Set Timer:"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    
    @objc
    func buttonTapped(sender: Any) {
        
        if let gr  = sender as? TimerButtonTapGestureRecognizer {
            if let time = gr.time {
                // TODO: Add a functiomn in main view controller that does all of this
                self.mainViewController?.player1timeout = time
                self.mainViewController?.player2timeout = time
                self.mainViewController?.updateBothLabels()
            }
            
            dismiss(animated: true, completion: {})
        }
    }
    
    
    
    
    
} // End of Class
