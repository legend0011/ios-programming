//
//  ViewController.swift
//  WorldTrotter
//
//  Created by jack zhang on 2022/8/10.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        //
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let tv = textField.text, let v = Double(tv) {
            fahrenheitValue = Measurement(value: v, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        print("tap gesture received")
    }
    
    let backgroundView: UIView = {
        let gv = UIView()
        gv.backgroundColor = .clear
        gv.clipsToBounds = true
        return gv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //view.addSubview(<#T##view: UIView##UIView#>)
        print("viewWillLayoutSubviews did called!!")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        let bgc = [UIColor.orange, UIColor.red, UIColor.lightGray, UIColor.magenta, UIColor.brown].randomElement()
        self.view.backgroundColor = bgc
        print("viewWillAppear did called!! \(String(describing: bgc))")
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "xxx"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // implement textField() in UITextFieldDelegate
    // return NO if don't want change textField text
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
//        let replacementTextHasDecimalSeparator = string.range(of: ".")
//
//        if existingTextHasDecimalSeparator != nil,
//           replacementTextHasDecimalSeparator != nil {
//            return false
//        } else {
//            return true
//        }
        let next = (textField.text ?? "") + string
        if let d = Double(next) {
            return true
        }
        return false
    }
}
