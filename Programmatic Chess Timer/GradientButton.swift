//
//  GradientButton.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 4/23/21.
//

import UIKit

class GradientButton: UIView {

    var buttonOuterLayer: CALayer?
    var buttonInnerLayer: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // self.buttonOuterLayer = createButtonOuterLayer()
        self.buttonInnerLayer = createButtonInnerLayer()
        
       // layer.addSublayer(buttonOuterLayer!)
        layer.addSublayer(buttonInnerLayer!)

    } // End

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    } // End

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
    private var innerLayer: CALayer!

    // Inner Layer:
    private func createButtonInnerLayer() -> CALayer {
        let buttonInnerLayer = CAGradientLayer()
        buttonInnerLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor]
        buttonInnerLayer.locations = [NSNumber(0), NSNumber(0.9)]
        
        buttonInnerLayer.shadowColor = UIColor.gray.cgColor
        buttonInnerLayer.shadowRadius = 5
        buttonInnerLayer.shadowOpacity = 5
        
        return buttonInnerLayer
    } // End function



} // End class
