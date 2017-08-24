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
    var imgBusStyle: [UIImage] = [UIImage]()
    var resultBNum: String = ""
    
    @IBOutlet weak var tbNumResult: UITableView!
    
    @IBOutlet weak var lbBNum: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbNumResult.delegate = self
        tbNumResult.dataSource = self
        
        for i in 0..<6{
            var tempStr = "BusStyle0" + String(i+1) + ".jpg"
            imgBusStyle.append(UIImage(named: tempStr)!)
        }
        
        lbBNum.text = resultBNum
        
        //imgBStyle.image = busStyleDeff(busStyle: resultBNum)
        
        

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
        
        if(busNumSearch?.busInfoData[row].bustype == "일반버스"){
            cell.imgBStyle.image = imgBusStyle[0]
        }else if(busNumSearch?.busInfoData[row].bustype == "좌석버스"){
            cell.imgBStyle.image = imgBusStyle[1]
        }else if(busNumSearch?.busInfoData[row].bustype == "급행버스"){
            cell.imgBStyle.image = imgBusStyle[3]
        }else if(busNumSearch?.busInfoData[row].bustype == "심야버스"){
            cell.imgBStyle.image = imgBusStyle[4]
        }else if(busNumSearch?.busInfoData[row].bustype == "심야버스(급행)"){
            cell.imgBStyle.image = imgBusStyle[4]
        }else if(busNumSearch?.busInfoData[row].bustype == "마을버스"){
            cell.imgBStyle.image = imgBusStyle[2]
        }
        else{
            cell.imgBStyle.image = imgBusStyle[5]
        }
        
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
            busSelect.busInfo = (busNumSearch?.busInfoData[(indexPath?.row)!])!
            busSelect.routeId = (busNumSearch?.busInfoData[(indexPath?.row)!].lineId)!
        }
    }

    func busStyleDeff(busStyle: String) -> UIImage{
        
        var tempImg: UIImage
        
        if(busStyle == "일반버스"){
            tempImg = imgBusStyle[0]
        }else if(busStyle == "좌석버스"){
            tempImg = imgBusStyle[1]
        }else if(busStyle == "급행버스"){
            tempImg = imgBusStyle[3]
        }else if(busStyle == "심야버스"){
            tempImg = imgBusStyle[4]
        }else if(busStyle == "심야버스(급행)"){
            tempImg = imgBusStyle[4]
        }else if(busStyle == "마을버스"){
            tempImg = imgBusStyle[2]
        }
        else{
            tempImg = imgBusStyle[5]
        }
        return tempImg
    }
    
    
    @IBAction func BSearchViewReturned(segue: UIStoryboardSegue){
        
        
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
