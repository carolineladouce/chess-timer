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

   
    
    var buttonOuterLayer: CALayer?
    var buttonInnerLayer: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buttonOuterLayer = createButtonOuterLayer()
        self.buttonInnerLayer = createButtonInnerLayer()
        
        layer.addSublayer(buttonOuterLayer!)
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
        
        
        if let btn = buttonOuterLayer {
            btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            btn.cornerRadius = btn.frame.width / 2
        }
        
        
        if let bto = buttonInnerLayer {
            bto.frame = CGRect(
                x: innerLayerMargin,
                y: innerLayerMargin,
                width: self.bounds.width - innerLayerMargin * 2,
                height: self.bounds.height - innerLayerMargin * 2)
        }

    } // End
    
    
    private var innerLayerMargin: CGFloat = 2.0
    private var outerLayer: CALayer!
    private var innerLayer: CALayer!
    
    
    // Outer Layer:
    private func createButtonOuterLayer()  -> CALayer {
        let buttonOuterLayer = CALayer()
        buttonOuterLayer.opacity = 0.5
        buttonOuterLayer.backgroundColor = UIColor.white.cgColor
        return buttonOuterLayer
    } // End function
    
    
    // Inner Layer:
    private func createButtonInnerLayer() -> CALayer {
        let buttonInnerLayer = CAGradientLayer()
        buttonInnerLayer.colors = [UIColor.gray.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
        buttonInnerLayer.locations = [NSNumber(0), NSNumber(0.4), NSNumber(0.5)]
        
        return buttonInnerLayer
    } // End function



} // End ckass
