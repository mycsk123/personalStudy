//
//  busRouteidViewController.swift
//  busProject
//
//  Created by 0000 on 16/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class BusRouteidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var routeId: String = ""
    var busRouteid: xmlBusInfoByRouteid = xmlBusInfoByRouteid()
    
    @IBOutlet weak var tbRouteResult: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbRouteResult.delegate = self
        tbRouteResult.dataSource = self
        
        busRouteid.searchBusNum(routeId: routeId)
        print(busRouteid.busRouteidData.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return busRouteid.busRouteidData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bstopRoutedResult", for: indexPath) as! BusRouteidTableViewCell
        
        let row = indexPath.row
        
        cell.lbCarNo.text = busRouteid.busRouteidData[row].carNo
        cell.lbBstopnm.text = busRouteid.busRouteidData[row].bstopnm
        
        return cell
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
