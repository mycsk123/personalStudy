//
//  PopUpViewController.swift
//  busProject
//
//  Created by kwon on 25/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    var temp: String = ""
    
    @IBOutlet weak var PopUpBusInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnPopUpClose(_ sender: UIButton) {
        PopUpBusInfo.removeFromSuperview()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
