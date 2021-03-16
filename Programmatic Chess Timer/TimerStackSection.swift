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
        setTitleColor(.white, for: .normal)
        backgroundColor = .lightGray
        titleLabel?.font = UIFont(name: "TITLE", size: 24)
        layer.cornerRadius = 10
    }
}
