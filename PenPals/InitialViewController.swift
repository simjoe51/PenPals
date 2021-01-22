//
//  InitialViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/9/21.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check whether or not the app is already set up
       // if defaults.bool(forKey: "isSetup") {
            //send the user to the main screen when it is set up.
            performSegue(withIdentifier: "homeSegue", sender: self)
       // } else {
            performSegue(withIdentifier: "setupSegue", sender: self)
       // }
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
