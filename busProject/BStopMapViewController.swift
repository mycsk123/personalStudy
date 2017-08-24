//
//  BStopMapViewController.swift
//  busProject
//
//  Created by 0000 on 18/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit
import MapKit

class BStopMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var BStopMap: MKMapView!
    
    @IBOutlet weak var lbBStopInfo: UILabel!

    @IBOutlet weak var lbArrBusTime: UILabel!
    
    var busRouteid: xmlBusInfoByRouteid? = nil
    
    var bstopList: xmlBStopList = xmlBStopList()
    
    let locationManager = CLLocationManager()
    var bstopnm: String = "" //정류소 이름
    var arsno: String = "" //정류소 번호
    var lineId: String = ""//버스노선 아이디
    var tempBstopId: String = ""
    
    var bStopBList: xmlBStopBList = xmlBStopBList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //bstopList.searchBStop(bstopNum: (busRouteid?.busRouteidData)!)
        //bstopList.bStopData.
        
        bstopList.selectBStop(bstopnm: bstopnm, arsNo: arsno)
        
        if((arsno != nil) || (arsno != "")){
            var tGpsX: Double = Double(bstopList.bStopOneData.gpsX)!
            var tGpsY: Double = Double(bstopList.bStopOneData.gpsY)!
            
            setAnnotation(latitude: tGpsY, longitude: tGpsX, delta: 0.005, title: bstopnm, subtitle: arsno)

            lbBStopInfo.text = bstopnm + " | " + arsno
        }else{
            //arsNo값이 없을 경우 1번에 정류장의 좌표를 찾을 수 없음
            lbBStopInfo.text = "죄송합니다. 공사중입니다."
        }
        
        tempBstopId = bstopList.bStopOneData.bstopId
        
        
        bStopBList.searchBStopArrBus(bstopId: tempBstopId, lineId: lineId)
        var temp1stBus = bStopBList.bStopArrBus.min1
        var temp2stBus = bStopBList.bStopArrBus.min2
        
        lbArrBusTime.textColor = UIColor.red
        lbArrBusTime.text = temp1stBus + "분 전 | " + temp2stBus + "분 전"

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        BStopMap.showsUserLocation = true 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let sapnValue = MKCoordinateSpanMake(span, span)
        let pRegion = MKCoordinateRegionMake(pLocation, sapnValue)
        BStopMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        BStopMap.addAnnotation(annotation)
        
    }
 
    
    @IBAction func btnReload(_ sender: UIButton) {
        bStopBList.bBStopArrBusReload(bstopId: tempBstopId, lineId: lineId, uiLB: lbArrBusTime as! UILabel)
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
