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
        
        //모든 노선을 파싱하기 때문에 일일트래픽을 넘어서는 상황 발생.
        //bStopList.searchBStop(bstopNum: busRouteid.busRouteidData)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgBStopMap" {
            
            let cell = sender as! BusRouteidTableViewCell
            let indexPath = self.tbRouteResult.indexPath(for: cell)
            
            let temp: Int = (indexPath?.row)!
            print(temp)
            
            let busStopSelect = segue.destination as! BStopMapViewController
            busStopSelect.arsno = busRouteid.busRouteidData[(indexPath?.row)!].arsNo
            busStopSelect.bstopnm = busRouteid.busRouteidData[(indexPath?.row)!].bstopnm
            
        }
    }
    
    
    @IBAction func btnPrev(_ sender: UIButton) {
        //bStopList.isThreadStop = false
    }
    
    @IBAction func BRouteidViewReturned(segue: UIStoryboardSegue){

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
