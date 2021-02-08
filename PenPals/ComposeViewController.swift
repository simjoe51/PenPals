//
//  ComposeViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/21/21.
//

import UIKit
import CryptoKit
import Alamofire

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var editingField: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        editingField.resignFirstResponder()
    }
    
    @IBAction func sendLetter(_ sender: UIButton) {
        //let recipientPublicKey = Curve25519.KeyAgreement.PublicKey(rawRepresentation: <#T##ContiguousBytes#>)
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
