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
    var busInfo: BusInfos = BusInfos()
    var busRouteid: xmlBusInfoByRouteid = xmlBusInfoByRouteid()
    var imgBusStyle: [UIImage] = [UIImage]()
    
    var imgBusOn: [UIImage] = [UIImage]()
    
    @IBOutlet weak var tbRouteResult: UITableView!
    
    @IBOutlet weak var imgBStyle: UIImageView!
    
    
    @IBOutlet weak var lbBNum: UILabel!
    
    @IBOutlet weak var lbBInfo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbRouteResult.delegate = self
        tbRouteResult.dataSource = self
        
        lbBNum.textColor = UIColor.blue
        lbBNum.text = busInfo.buslinenum
        lbBInfo.text = busInfo.startpoint + "↔" + busInfo.endpoint
        
        for i in 0..<2{
            var tempStr = "Line0" + String(i+1) + ".png"
            imgBusOn.append(UIImage(named: tempStr)!)
        }
        imgBusOn.append(UIImage(named: "BusNum.jpg")!)
        
        for i in 0..<6{
            var tempStr = "BusStyle0" + String(i+1) + ".jpg"
            imgBusStyle.append(UIImage(named: tempStr)!)
        }
        imgBStyle.image = busStyleDeff(busStyle: busInfo.bustype)
        
        
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
        
        if((busRouteid.busRouteidData[row].carNo == nil) || (busRouteid.busRouteidData[row].carNo == "")){
            cell.imgLine.image = self.imgBusOn[0]
            
        }else{
            cell.imgLine.image = self.imgBusOn[1]
            //아래 잔상이 남음 해결해 볼 것
            //cell.imgBusNum.image = self.imgBusOn[2]
        }
        
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
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
