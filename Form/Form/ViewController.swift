//
//  ViewController.swift
//  Form
//
//  Created by Vansh Dubey on 25/04/23.
//

import UIKit

//MARK: - Values for text fields
let objFieldValues: [FieldValues] = [
    FieldValues(fields: "Unit Number", placeholders: "Enter Unit Number"),
    FieldValues(fields: "Gate Pass For", placeholders: "Enter Gate Pass For"),
    FieldValues(fields: "Asset Group", placeholders: "Enter Asset Group"),
    FieldValues(fields: "Issue to", placeholders: "Enter Issue to"),
]

var data : Input = Input()

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var keyboardContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        self.myTableView.separatorColor = UIColor.clear
        
        
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
    }
    
    
    deinit {
         NotificationCenter.default.removeObserver(self)
       }
//MARK: - keyboard scroll
       @objc func keyboardNotification(notification: NSNotification) {
         guard let userInfo = notification.userInfo else { return }

         let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
         let endFrameY = endFrame?.origin.y ?? 0
         let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
         let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
         let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
         let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

         if endFrameY >= UIScreen.main.bounds.size.height {
           self.keyboardContraint?.constant = 0.0
         } else {
           self.keyboardContraint?.constant = endFrame?.size.height ?? 0.0
         }

         UIView.animate(
           withDuration: duration,
           delay: TimeInterval(0),
           options: animationCurve,
           animations: { self.view.layoutIfNeeded() },
           completion: nil)
       }
    
    @IBAction func submitBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Response Submitted", message: "You have submitted your response", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



//MARK: - TableView Delegate
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


//MARK: - TableView Data Source
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFieldValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.selectionStyle = .none
        cell.titleLbl.text = objFieldValues[indexPath.row].fields
        cell.textField.placeholder = objFieldValues[indexPath.row].placeholders
        cell.textField.tag = indexPath.row
        return cell
    }
}


