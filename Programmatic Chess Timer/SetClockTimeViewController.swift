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
    
    
//    var gradientLayer: CAGradientLayer = {
//        var layer = CAGradientLayer()
//        layer.type = .axial
//
//        layer.colors = [
//            UIColor(red: 228/255, green: 227/255, blue: 227/255, alpha: 1).cgColor,
//            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
//        ]
//
//        layer.locations = [0, 0.75]
//
//
//
//        return layer
//    }()
    
    
    /// in seconds
    let times: [Int] = [1,2,3,5,10]
    var buttons: [TimerStackSection] = []

    var stackView = UIStackView()
    var titleLabel = UILabel()
    
//    var titleGradient: CAGradientLayer = {
//        var gradientLayer = CAGradientLayer()
//        gradientLayer.type = .axial
//
//        gradientLayer.colors = [
//            UIColor(red: 82/255, green: 0/255, blue: 255/255, alpha: 1).cgColor,
//            UIColor(red: 210/255, green: 116/255, blue: 254/255, alpha: 1).cgColor
//        ]
//
//        gradientLayer.locations = [0, 0.5]
//
//        return gradientLayer
//
//    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 244/255, green: 243/255, blue: 243/255, alpha: 1)

//        view.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = view.bounds
    
        configureTitleLabel()
        configureStackView()
        
//        view.layer.addSublayer(titleGradient)
//        titleGradient.frame = view.bounds
//        view.mask = titleLabel
    
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
    
    
    func addButtonsToStackView() {
        for i in times {
            let button = TimerStackSection()
         
            let gr = TimerButtonTapGestureRecognizer(target: self, action: #selector(buttonTapped))
            gr.time = i*60
            
            button.setTitle("\(i)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 54)
            
            button.isUserInteractionEnabled = true
            button.addGestureRecognizer(gr)
            stackView.addArrangedSubview(button)
            self.buttons.append(button)
        }
    }
    
    
    func setstackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -75).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Set timer ⏱"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
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
                self.mainViewController?.timeSelected(time: time)
            }
    
            
            
            dismiss(animated: true, completion: {})
        }
    }
    
    

    
} // End of Class
