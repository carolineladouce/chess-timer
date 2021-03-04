//
//  SetClockTimeViewController.swift
//  Programmatic Chess Timer
//
//  Created by Caroline LaDouce on 3/2/21.
//

import UIKit

class SetClockTimeViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        let setClockTime = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        setClockTime.center = CGPoint(x: 160, y: 175)
        setClockTime.textAlignment = .center
        setClockTime.text = "Input Timer Time"
        
        let timeInput = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        timeInput.center = CGPoint(x: 160, y: 225)
        timeInput.textAlignment = .center
        timeInput.placeholder = "set time here"
        timeInput.keyboardType = UIKeyboardType.default
        timeInput.returnKeyType = UIReturnKeyType.done
        timeInput.clearButtonMode = UITextField.ViewMode.whileEditing;

        timeInput.delegate = self
    
        view.addSubview(setClockTime)
        view.addSubview(timeInput)
    }
    
    var defaultTime = 600
    
    var onValueSet: ((_ value: Int) -> Void)?
    
    func textFieldShouldReturn(_ timeInput: UITextField) -> Bool {
        timeInput.resignFirstResponder()
        
        let textFieldString = timeInput.text ?? "0"
        
        var textFieldInt = Int(textFieldString) ?? 0
        
        if textFieldInt == 0 {
            textFieldInt = defaultTime
        }
        
        self.onValueSet?(textFieldInt)
        
        GAME_TIME = textFieldInt
        
        dismiss(animated: true, completion: nil)
        
        return true
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
