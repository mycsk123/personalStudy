//
//  BusSeachViewController.swift
//  busProject
//
//  Created by kwon on 16/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class BusSeachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var busNumSearch : xmlBusInfo? = nil
    
    @IBOutlet weak var tbNumResult: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbNumResult.delegate = self
        tbNumResult.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (busNumSearch?.busInfoData.count)!
    }

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "busSeachResult", for: indexPath) as! BusSearchTableViewCell
        
        let row = indexPath.row
        
        cell.lbBusNum.text = busNumSearch?.busInfoData[row].buslinenum
        
        cell.lbBusPoint.text = (busNumSearch?.busInfoData[row].startpoint)! + "↔" + (busNumSearch?.busInfoData[row].endpoint)!
        
        //cell.lbBusEct
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            
        }
    }

    
    @IBAction func returned(segue: UIStoryboardSegue){
        
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
