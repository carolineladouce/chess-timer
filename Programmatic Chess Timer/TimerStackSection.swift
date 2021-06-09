//
//  TimerStackSection.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 3/9/21.
//

import UIKit

class TimerStackSection: UIButton {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    
    
    func setupButton() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor =  .clear
        titleLabel?.font = UIFont(name: "TITLE", size: 32)
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.white.cgColor
//        layer.shadowColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1).cgColor
//        layer.shadowOffset = CGSize(width: 2, height: 5)
//        layer.shadowRadius = 5
//        layer.shadowOpacity = 1.0
//
    }
}


//gradientBlock.shadowColor = UIColor.black.cgColor
////buttonInnerLayer.shadowOffset = CGSize(width: 5, height: 5)
//gradientBlock.shadowRadius = 10
//gradientBlock.shadowOpacity = 1.0
