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
        
        //MARK: DEV ADDRESS
        //make sure this matches the address of the server in testing. Need to change to an outward facing address later on
        print("Creating dissimilar account now")
        AF.request("http://192.168.1.7:8080/createaccount", method: .post, parameters: ["fullName": fullName, "phoneNumber": phoneNumber, "age": String(age), "publicKey": publicKey.rawRepresentation.base64EncodedString()], encoder: JSONParameterEncoder.default).response { [self] response in
            
            if response.data == nil {
                print("Request to vapor returned nil unexpectedly. Internet error?")
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
    }
    
    //create an account and upload matching data to the server
    func createMatchedAccount() {
        //nothing here yet :(
    }
}
