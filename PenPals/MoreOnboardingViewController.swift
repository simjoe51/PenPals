//
//  MoreOnboardingViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/9/21.
//

import UIKit

class MoreOnboardingViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageUpButton: UIButton!
    @IBOutlet weak var ageDownButton: UIButton!
    
    //MARK: Variables
    var similar:Bool = false
    var fullName:String = ""
    var phoneNumber:String = ""
    
    //actually used in controller
    var age:Int = 16
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //hide nav bar
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func ageUpButton(_ sender: UIButton) {
        age += 1
        ageLabel.text = "Age: \(String(age))"
        ageDownButton.isEnabled = true
        if age == 17 {
            ageUpButton.isEnabled = false
        }
    }
    
    @IBAction func ageDownButton(_ sender: UIButton) {
        age -= 1
        ageLabel.text = "Age: \(String(age))"
        ageUpButton.isEnabled = true
        if age == 13 {
            ageDownButton.isEnabled = false
        }
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
