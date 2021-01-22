//
//  HomeViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/21/21.
//

import UIKit

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

        // Do any additional setup after loading the view.
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
