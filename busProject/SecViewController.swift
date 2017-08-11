//
//  SecViewController.swift
//  busProject
//
//  Created by kwon on 11/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {
    
    @IBOutlet weak var lbText: UILabel!
    
    var tempStr: String = ""
    var busSec : xmlBusInfo? = nil

    override func viewDidLoad() {
        super.viewDidLoad()


        for i in 0..<busSec!.busInfoData.count {
            tempStr += busSec!.busInfoData[i].buslinenum + "\n"
            tempStr += busSec!.busInfoData[i].bustype + "\n"
            tempStr += busSec!.busInfoData[i].lineId + "\n"
            
            lbText.numberOfLines += 3
        }

        lbText.text = tempStr
        
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
