//
//  OnboardingViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/8/21.
//

import UIKit

let defaults = UserDefaults.standard
let generator = UINotificationFeedbackGenerator()

class OnboardingViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var yepButton: UIButton!
    @IBOutlet weak var idcButton: UIButton!
    
    //age stack
    @IBOutlet weak var ageDownButton: UIButton!
    @IBOutlet weak var ageUpButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    //MARK: Variables
    var yepSelected:Bool = false
    var idcSelected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Text field delegates and such
        fullNameField.delegate = self
        phoneNumberField.delegate = self
        
        //hide nav bar
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        generator.notificationOccurred(.success)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    //Selection buttons. React based on whether one is already selected
    @IBAction func yepSelected(_ sender: UIButton) {
        if yepSelected == false && idcSelected == false {
            yepSelected = true
            yepButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else if yepSelected == false && idcSelected == true {
            yepSelected = true
            idcSelected = false
            yepButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            idcButton.setImage(UIImage(systemName: "square"), for: .normal)
        } else if yepSelected == true && idcSelected == false {
            yepSelected = false
            yepButton.setImage(UIImage(systemName: "square"), for: .normal)
            
        }
        //Tap the user for some feedback
        generator.notificationOccurred(.success)
    }
    
    @IBAction func idcSelected(_ sender: UIButton) {
        if idcSelected == false && yepSelected == false {
            idcSelected = true
            idcButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else if idcSelected == false && yepSelected == true {
            idcSelected = true
            yepSelected = false
            idcButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            yepButton.setImage(UIImage(systemName: "square"), for: .normal)
        } else if idcSelected == true && yepSelected == false {
            idcSelected = false
            idcButton.setImage(UIImage(systemName: "square"), for: .normal)
            
        }
        //Tap the user for some feedback
        generator.notificationOccurred(.success)
    }
    
    @IBAction func privacyButton(_ sender: UIButton) {
        performSegue(withIdentifier: "privacySegue", sender: self)
        generator.notificationOccurred(.success)
    }
    
    //When this button pressed, check that fields are full and send data along to next storyboard
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        //check fields
        if fullNameField.text != "" && fullNameField.text != "full name" && phoneNumberField.text != "" && phoneNumberField.text != "phone number" {
            if yepSelected {
                //everything is good. Continue with signup
                performSegue(withIdentifier: "nextSegue", sender: self)
            } else if idcSelected {
                //user has selected that they don't care who they are matched with. Prompt for confirmation and then continue to que.
                let ac = UIAlertController(title: "Are you sure?", message: "You told us you don't mind who you are matched with. Would you like to continue with that option selected?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler:{(alert: UIAlertAction!) in self.continueWithoutMatching()}))
                ac.addAction(UIAlertAction(title: "Nope", style: .default))
                self.present(ac, animated: true)
            } else { //Similarity checkbox is not selected
                let ac = UIAlertController(title: "Oop", message: "You need to select at least one of the checkboxes.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Alrighty", style: .default))
                self.present(ac, animated: true)
            }
        } else { //user has not filled out either their name or phone number
            let ac = UIAlertController(title: "Oop", message: "Please fill out both information fields before continuing...", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    //handle age buttons
    var age:Int = 16
    
    @IBAction func ageDownButton(_ sender: UIButton) {
        age -= 1
        ageLabel.text = "Age: \(String(age))"
        ageUpButton.isEnabled = true
        if age == 13 {
            ageDownButton.isEnabled = false
        }
    }
    
    @IBAction func ageUpButton(_ sender: UIButton) {
        age += 1
        ageLabel.text = "Age: \(String(age))"
        ageDownButton.isEnabled = true
        if age == 99 {
            ageUpButton.isEnabled = false
        }
    }
    
    //user has selected and confirmed that they wish to continue without making use of advanced matching. This will bypass information collection and match them with the first person that matches age requirements for safety.
    @objc func continueWithoutMatching() {
        performSegue(withIdentifier: "continueWithoutMatching", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MoreOnboardingViewController {
            let vc = segue.destination as? MoreOnboardingViewController
            vc?.fullName = fullNameField.text!
            vc?.phoneNumber = phoneNumberField.text!
            vc?.similar = true
            vc?.age = age
        } else if segue.destination is createAccountViewController {
            let vc = segue.destination as? createAccountViewController
            vc?.fullName = fullNameField.text!
            vc?.phoneNumber = phoneNumberField.text!
            vc?.age = age
        }
    }

}
