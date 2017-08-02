//
//  ViewController.swift
//  busProject
//
//  Created by kwon on 02/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var busInfo: BusInfo = BusInfo()

    @IBOutlet weak var tfBusNum: UITextField!
    @IBOutlet weak var tfBusStop: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnBusNum(_ sender: UIButton) {
        //getXmlInfo()
    }
    
    @IBAction func btnBusStop(_ sender: UIButton) {
    }
    


}

