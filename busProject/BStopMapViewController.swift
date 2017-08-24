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
    
    var busRouteid: xmlBusInfoByRouteid? = nil
    
    var bstopList: xmlBStopList = xmlBStopList()
    
    let locationManager = CLLocationManager()
    var bstopnm: String = "" //정류소 이름
    var arsno: String = "" //정류소 번호
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bstopList.searchBStop(bstopNum: (busRouteid?.busRouteidData)!)
        //bstopList.bStopData.
        
        bstopList.selectBStop(bstopnm: bstopnm, arsNo: arsno)
        var tGpsX: Double = Double(bstopList.bStopOneData.gpsX)!
        var tGpsY: Double = Double(bstopList.bStopOneData.gpsY)!
        
        setAnnotation(latitude: tGpsY, longitude: tGpsX, delta: 0.005, title: bstopnm, subtitle: arsno)
        
        
        
        lbBStopInfo.text = bstopnm + " | " + arsno
        
        
//        var bstopArsno: String //정류소번호
//        var bstopId: String //정류소아이디
//        var bstopNm: String //정류소명
//        var gpsX: String //GPS X좌표
//        var gpsY: String //GPS Y좌표
//        var stoptype: String //정류소구분 - 일반, 마을
        
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
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
