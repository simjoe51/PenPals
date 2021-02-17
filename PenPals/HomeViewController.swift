//
//  HomeViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/21/21.
//

import UIKit
import Alamofire
import CoreData

class HomeViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var greetingLabel: UILabel!
    
    //MARK: Variables
    var nameString: String = ""
    //debug
    var idString: UUID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Account")
        //fetchRequest.predicate = NSPredicate()
        //MARK: Predicates?
        do {
           let accounts = try managedContext.fetch(fetchRequest)
            nameString = accounts[0].value(forKeyPath: "fullName") as! String
          //  idString = accounts[0].value(forKeyPath: "id") as! UUID
            print(idString)
        } catch let error as NSError {
            print("Could not fetch :( \(error), \(error.userInfo)")
        }
        
        
        
        //Set the greeting label depending on time
        let hour = Calendar.current.component(.hour, from: Date())
        let nameStringFormatted: String! = nameString.components(separatedBy: " ").first
        if hour >= 0 && hour < 12 {
            greetingLabel.text = "Good Night, \(nameStringFormatted ?? "Fetch failure")"
        } else if hour >= 12 && hour < 17 {
            greetingLabel.text = "Good Night, \(nameStringFormatted ?? "Fetch failure")"
        } else if hour >= 17 && hour < 20 {
            greetingLabel.text = "Good Night, \(nameStringFormatted ?? "Fetch failure")"
        } else if hour >= 20 && hour <= 24 {
            greetingLabel.text = "Good Night, \(nameStringFormatted ?? "Fetch failure")"
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
        AF.request("\(addressVariable)getnew", method: .post, parameters: ["forUUID": defaults.data(forKey: "UUID")], encoder: JSONParameterEncoder.default).response { response in
            
        }
    }
    
    //MARK: Check for PenPal
    func checkPartner() {
        print("Checking for new assigned partners")
        AF.request("\(addressVariable)checkpartner", method: .post, parameters: ["forUUID": defaults.data(forKey: "UUID")], encoder: JSONParameterEncoder.default).response { response in
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
