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
import CoreData

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
            print("NOTIFICATIONS ENABLED")
            //MARK: Create account with notification preferences
            //make sure to add a method when the user changes preferences to selectively remove or add this column from a user's account file
            AF.request("http://192.168.1.14:8080/createaccountnotifs", method: .post, parameters: ["fullName": fullName, "phoneNumber": phoneNumber, "age": String(age), "publicKey": publicKey.rawRepresentation.base64EncodedString(), "deviceToken": defaults.string(forKey: "token")], encoder: JSONParameterEncoder.default).response { [self] response in
                
                if response.data == nil {
                    print("Request to vapor returned nil unexpectedly. Internet error?")
                    //MARK: ADD alert here
                } else {
                    print("Reached server. Returned reponse: ", String(data: response.data!, encoding: String.Encoding.utf8)!)
                    
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                        return
                    }
                    let managedContext = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "Account", in: managedContext)
                    let account = NSManagedObject(entity: entity!, insertInto: managedContext)
                    
                    //MARK: Add a selection statement to check whether or not the response was an error. If not, continue to the home screen
                    //create codable struct to decode UUID from response
                    struct ID: Codable {
                        let id: UUID
                        
                        func getID() -> UUID {
                            return id
                        }
                    }
                    //set persistent values for profile data for use later
                    account.setValue(fullName, forKeyPath: "fullName")
                    account.setValue(phoneNumber, forKeyPath: "phoneNumber")
                    account.setValue(age, forKeyPath: "age")
                    account.setValue(UUID(uuidString: String(data: response.data!, encoding: .utf8)!), forKeyPath: "id")
                    defaults.set(response.data, forKey: "UUID")
                    defaults.set(true, forKey: "isSetup")
                    
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    
                    //MARK: Create CKRecord with UUID to sign in
                    
                    performSegue(withIdentifier: "setupToMain", sender: self)
                }
            }

        } else {
            //MARK: Create account without notification privileges
            AF.request("\(addressVariable)createaccount", method: .post, parameters: ["fullName": fullName, "phoneNumber": phoneNumber, "age": String(age), "publicKey": publicKey.rawRepresentation.base64EncodedString()], encoder: JSONParameterEncoder.default).response { [self] response in
                
                if response.data == nil {
                    print("Request to vapor returned nil unexpectedly. Internet error?")
                    //MARK: ADD alert here
                } else {
                    print("Reached server. Returned reponse: ", String(data: response.data!, encoding: String.Encoding.utf8)!)
                    //MARK: Add a selection statement to check whether or not the response was an error. If not, continue to the home screen
                    //set persistent values for profile data for use later
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                        return
                    }
                    let managedContext = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "Account", in: managedContext)
                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    
                    person.setValue(fullName, forKeyPath: "fullName")
                    person.setValue(phoneNumber, forKeyPath: "phoneNumber")
                    person.setValue(age, forKeyPath: "age")
                    person.setValue(UUID(uuidString: String(data: response.data!, encoding: .utf8)!), forKeyPath: "id")
                    defaults.set(response.data, forKey: "UUID")
                    defaults.set(true, forKey: "isSetup")
                    
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    
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
