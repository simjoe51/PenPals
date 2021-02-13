//
//  createAccountViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/11/21.
//

import UIKit
import CloudKit
import Alamofire
import CryptoKit

class createAccountViewController: UIViewController {

    //MARK: Variables
    var similar:Bool = false
    var fullName:String = ""
    var phoneNumber:String = ""
    var age:Int = 16
    
    //insert variables for all of the other things here
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if similar {
            createMatchedAccount()
        } else {
            createDissimilarAccount()
        }
    }
    
    func createDissimilarAccount() {
        
        //MARK: Create Private/Public Keypair
        let privateKey = Curve25519.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey
        defaults.set(privateKey.rawRepresentation, forKey: "private") //make sure this is secure as it's pretty important...
        defaults.set(publicKey.rawRepresentation, forKey: "public")
        
        print("Creating dissimilar account now")
        //check whether or not the user has consented to notifications
        //MARK: Notifs?
        if defaults.bool(forKey: "notifications") {
            //MARK: Create account with notification preferences
            //make sure to add a method when the user changes preferences to selectively remove or add this column from a user's account file
            AF.request("\(addressVariable)createaccountnotifs", method: .post, parameters: ["fullName": fullName, "phoneNumber": phoneNumber, "age": String(age), "publicKey": publicKey.rawRepresentation.base64EncodedString()], encoder: JSONParameterEncoder.default).response { [self] response in
                
                if response.data == nil {
                    print("Request to vapor returned nil unexpectedly. Internet error?")
                    //MARK: ADD alert here
                } else {
                    print("Reached server. Returned reponse: ", String(data: response.data!, encoding: String.Encoding.utf8)!)
                    //MARK: Add a selection statement to check whether or not the response was an error. If not, continue to the home screen
                    //set persistent values for profile data for use later
                    defaults.set(fullName, forKey: "fullName")
                    defaults.set(phoneNumber, forKey: "phoneNumber")
                    defaults.set(age, forKey: "age")
                    defaults.set(response.data, forKey: "UUID")
                    defaults.set(true, forKey: "isSetup")
                    
                    //MARK: Create CKRecord with UUID to sign in
                    
                    performSegue(withIdentifier: "setupToMain", sender: self)
                }
            }

        } else {
            AF.request("\(addressVariable)createaccount", method: .post, parameters: ["fullName": fullName, "phoneNumber": phoneNumber, "age": String(age), "publicKey": publicKey.rawRepresentation.base64EncodedString()], encoder: JSONParameterEncoder.default).response { [self] response in
                
                if response.data == nil {
                    print("Request to vapor returned nil unexpectedly. Internet error?")
                    //MARK: ADD alert here
                } else {
                    print("Reached server. Returned reponse: ", String(data: response.data!, encoding: String.Encoding.utf8)!)
                    //MARK: Add a selection statement to check whether or not the response was an error. If not, continue to the home screen
                    //set persistent values for profile data for use later
                    defaults.set(fullName, forKey: "fullName")
                    defaults.set(phoneNumber, forKey: "phoneNumber")
                    defaults.set(age, forKey: "age")
                    defaults.set(response.data, forKey: "UUID")
                    defaults.set(true, forKey: "isSetup")
                    
                    //MARK: Create CKRecord with UUID to sign in
                    
                    performSegue(withIdentifier: "setupToMain", sender: self)
                }
            }

        } //end else
            }
    
    //create an account and upload matching data to the server
    func createMatchedAccount() {
        //nothing here yet :(
    }
}
