//
//  HomeViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/21/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var greetingLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the greeting label depending on time
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 0 && hour < 12 {
            greetingLabel.text = "Good Morning, \(String(describing: defaults.string(forKey: "fullName")?.components(separatedBy: " ").first))"
        } else if hour >= 12 && hour < 17 {
            greetingLabel.text = "Good Afternoon, \(String(describing: defaults.string(forKey: "fullName")?.components(separatedBy: " ").first))"
        } else if hour >= 17 && hour < 20 {
            greetingLabel.text = "Good Evening, \(String(describing: defaults.string(forKey: "fullName")?.components(separatedBy: " ").first))"
        } else if hour >= 20 && hour <= 24 {
            greetingLabel.text = "Good Night, \(String(describing: defaults.string(forKey: "fullName")?.components(separatedBy: " ").first))"
        }
        
        //check for new letters when the app opens and every time this screen is returned to
        
    }
    
    //When compose button pressed, send the user to the new view controller
    @IBAction func composeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "composeSegue", sender: self)
    }
    
    
    //MARK:Check For New Letters
    func checkForLetters() {
        print("Checking for new letters...")
        AF.request("http://192.168.1.7:8080/getnew", method: .post, parameters: ["forUUID": defaults.data(forKey: "UUID")], encoder: JSONParameterEncoder.default).response { response in
            
        }
    }
    
    //MARK: Check for PenPal
    func checkPartner() {
        print("Checking for new assigned partners")
        AF.request("http://192.168.1.7:8080/checkPartner", method: .post, parameters: ["forUUID": defaults.data(forKey: "UUID")], encoder: JSONParameterEncoder.default).response { response in
            
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
