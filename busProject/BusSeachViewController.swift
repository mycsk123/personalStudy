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

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "busSeachResult", for: indexPath) as! BusSearchTableViewCell
        
        let row = indexPath.row
        
        //정보전달을 위해 각 텍스트 색상 및 크기 수정 필요
        cell.lbBusNum.textColor = UIColor.blue
        cell.lbBusNum.text = busNumSearch?.busInfoData[row].buslinenum
        
        cell.lbBusPoint.text = (busNumSearch?.busInfoData[row].startpoint)! + "↔" + (busNumSearch?.busInfoData[row].endpoint)!
        
        var tempStr1: String = "첫차 " + (busNumSearch?.busInfoData[row].firsttime)! + ", 막차 " + (busNumSearch?.busInfoData[row].endtime)!
        var tempStr2: String = " | 배차간격 " + (busNumSearch?.busInfoData[row].headway)! + "분"
        
        cell.lbBusEct.text = tempStr1 + tempStr2
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sgDetail" {
            let cell = sender as! BusSearchTableViewCell
            let indexPath = self.tbNumResult.indexPath(for: cell)
            
            let busSelect = segue.destination as! BusRouteidViewController
            busSelect.routeId = (busNumSearch?.busInfoData[(indexPath?.row)!].lineId)!
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
