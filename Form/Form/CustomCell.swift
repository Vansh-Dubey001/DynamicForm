//
//  CustomCell.swift
//  Form
//
//  Created by Vansh Dubey on 25/04/23.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
    }
}

extension CustomCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if textField.tag == objFieldValues.count-1 {
                textField.resignFirstResponder()
            }  else {
                let nextRespond = self.superview!.viewWithTag(nextTag) as? UITextField
                nextRespond?.becomeFirstResponder()
            }
            return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            data.unitNumber = textField.text!
        case 1:
            data.gatePass = textField.text!
        case 2:
            data.assestGroup = textField.text!
        case 3:
            data.issuePerson = textField.text!
        default:
            return
        }
        
    }
}
