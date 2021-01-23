//
//  InitialViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/9/21.
//

import UIKit
import CloudKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check whether or not the app is already set up
        if defaults.bool(forKey: "isSetup") {
            //Check for an alert and then send the user to their homepage
            checkForAlert()
        } else {
        //send the user to setup
            performSegue(withIdentifier: "setupSegue", sender: self)
        }
    }
    
    func checkForAlert() {
        //Check for an alert. If one exists, display it.
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "alert", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["title", "body"]
        operation.resultsLimit = 1
        operation.qualityOfService = .userInitiated
        operation.queuePriority = .veryHigh
        
        operation.recordFetchedBlock = { record in
            print(record)
            let ac = UIAlertController(title: record["title"], message: record["body"], preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    //if no error, send the user home
                    self.performSegue(withIdentifier: "homeSegue", sender: self)
                } else {
                    let ac = UIAlertController(title: "Hmmm...", message: "There seems to be an issue connecting to one of my cloud services: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(ac, animated: true)
                    
                    self.performSegue(withIdentifier: "homeSegue", sender: self)
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
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
