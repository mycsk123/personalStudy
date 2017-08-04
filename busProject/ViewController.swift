//
//  ViewController.swift
//  busProject
//
//  Created by kwon on 02/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    
    var bus: xmlBusInfo = xmlBusInfo()

    @IBOutlet weak var tfBusNum: UITextField!
    @IBOutlet weak var tfBusStop: UITextField!
    
    @IBOutlet weak var lbText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnBusNum(_ sender: UIButton) {
        
        bus.searchBusNum(busNum: tfBusNum.text!)
        
        var tempStr: String = ""
        
        for i in 0..<bus.busInfoData.count{
            tempStr += " [ " + bus.busInfoData[i].buslinenum + ", " + bus.busInfoData[i].bustype + " ] "
            
            lbText.numberOfLines += 1

        }
        
        lbText.text = tempStr


    }
    
    @IBAction func btnBusStop(_ sender: UIButton) {
    }
    


}
