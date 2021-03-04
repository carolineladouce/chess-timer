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
        
        //setClockTime.text = "Hello"
       
        view.backgroundColor = .white
    
        
        
        let setClockTime = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        setClockTime.center = CGPoint(x: 160, y: 175)
        setClockTime.textAlignment = .center
        setClockTime.text = "Input Timer Time"
        //self.view.addSubview(label)
        
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
        

        // Do any additional setup after loading the view.
    }
    
    
    var onValueSet: ((_ value: Int) -> Void)?
    
    func textFieldShouldReturn(_ timeInput: UITextField) -> Bool {
        timeInput.resignFirstResponder()
        
//        getTextFieldValue()
        
        //let myInt2 = Int(myString) ?? 0
        let textFieldString = timeInput.text ?? "0"
        
        let textFieldInt = Int(textFieldString) ?? 0
        
        
//        func timeString(time:TimeInterval) -> String {
//        let hours = Int(time) / 3600
//        let minutes = Int(time) / 60 % 60
//        let seconds = Int(time) % 60
//        return String(format:”%02i:%02i:%02i”, hours, minutes, seconds)
//        }
        
        
        self.onValueSet?(textFieldInt)
        
        
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
