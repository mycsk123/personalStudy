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
    
    var busRouteid: xmlBusInfoByRouteid? = nil
    
    var bstopList: xmlBStopList = xmlBStopList()
    
    let locationManager = CLLocationManager()
    var bstopnm: String = "" //정류소 이름
    var arsno: String = "" //정류소 번호
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bstopList.searchBStop(bstopNum: (busRouteid?.busRouteidData)!)
        //bstopList.bStopData.
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
