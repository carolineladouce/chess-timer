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
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let buttonOuterLayer = createButtonOuterLayer()
        let buttonInnerLayer = createButtonInnerLayer()
        
        layer.addSublayer(buttonOuterLayer)
        layer.addSublayer(buttonInnerLayer)
        
        self.buttonOuterLayer = buttonOuterLayer
        self.buttonInnerLayer = buttonInnerLayer
    } // End

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    } // End

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonOuterLayer.frame = self.bounds
        buttonOuterLayer.cornerRadius = buttonOuterLayer.frame.width / 2
        
        buttonInnerLayer.frame = CGRect(
        innerLayerMargin, // top
            innerLayerMargin, // left
            self.bounds.width - innerLayerMargin * 2,
            self.bounds.height - innerLayerMargin * 2)
        
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
