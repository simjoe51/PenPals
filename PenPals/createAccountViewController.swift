//
//  createAccountViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/11/21.
//

import UIKit
import CloudKit
import Alamofire

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
        //make sure this matches the address of the server in testing. Need to change to an outward facing address later on
        print("Creating dissimilar account now")
        AF.request("http://192.168.1.7:8080/createaccount", method: .post, parameters: ["fullName": fullName, "phoneNumber": phoneNumber, "age": String(age)], encoder: JSONParameterEncoder.default).response { response in
            print("Reached server. Returned reponse: ", String(data: response.data!, encoding: String.Encoding.utf8)!)
        }
    }
    
    //create an account and upload matching data to the server
    func createMatchedAccount() {
        //nothing here yet :(
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
