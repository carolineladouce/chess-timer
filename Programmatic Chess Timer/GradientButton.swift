//
//  GradientButton.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 4/23/21.
//

import UIKit

class GradientButton: UIView {

    
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//
//
//    }
    
//    let gradientBlock: CAGradientLayer = {
//        let layer = CAGradientLayer()
//        layer.colors = [
//            UIColor.purple.cgColor,
//            UIColor.systemTeal.cgColor
//        ]
//        return layer
//    }()

   
    
    var buttonOuterLayer: CALayer?
    var buttonInnerLayer: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // self.buttonOuterLayer = createButtonOuterLayer()
        self.buttonInnerLayer = createButtonInnerLayer()
        
       // layer.addSublayer(buttonOuterLayer!)
        layer.addSublayer(buttonInnerLayer!)
        
        
        
        
        
//        self.buttonOuterLayer = buttonOuterLayer
//        self.buttonInnerLayer = buttonInnerLayer
    } // End

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    } // End

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
//        gradientBlock.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.size.height / 1.85)
        
//        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY
//                            , width: 200, height: 100)
        
//        self.backgroundColor = UIColor.systemPink
        
//        if let btn = buttonOuterLayer {
//            btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//
//            btn.cornerRadius = btn.frame.width / 2
//
//        }
        
        
        if let bto = buttonInnerLayer {
            bto.frame = CGRect(
                x: 25/2,
                y: 25/2,
                width: 75,
                height: 75)
            
                bto.cornerRadius = bto.frame.width / 2
        }
        
        print("Frame of GradientButton is \(self.frame)")

    } // End
    
    
    private var innerLayerMargin: CGFloat = 2.0
//    private var outerLayer: CALayer!
    private var innerLayer: CALayer!
    
    
//    // Outer Layer:
//    private func createButtonOuterLayer()  -> CALayer {
//        let buttonOuterLayer = CALayer()
////        buttonOuterLayer.opacity = 0.5
//        buttonOuterLayer.backgroundColor = UIColor.orange.cgColor
//        return buttonOuterLayer
//    } // End function
    
    
    // Inner Layer:
    private func createButtonInnerLayer() -> CALayer {
        let buttonInnerLayer = CAGradientLayer()
        buttonInnerLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor]
        buttonInnerLayer.locations = [NSNumber(0), NSNumber(0.9)]
        
        buttonInnerLayer.shadowColor = UIColor.gray.cgColor
        //buttonInnerLayer.shadowOffset = CGSize(width: 5, height: 5)
        buttonInnerLayer.shadowRadius = 5
        buttonInnerLayer.shadowOpacity = 5
        
        
        
        return buttonInnerLayer
    } // End function



} // End ckass
