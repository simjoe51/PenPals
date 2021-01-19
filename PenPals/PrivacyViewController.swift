//
//  PrivacyViewController.swift
//  PenPals
//
//  Created by Joseph Simeone on 1/9/21.
//

import UIKit

class PrivacyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //show nav bar
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        generator.notificationOccurred(.success)
        navigationController?.popToRootViewController(animated: true)
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
