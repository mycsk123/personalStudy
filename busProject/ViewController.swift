//
//  ViewController.swift
//  busProject
//
//  Created by kwon on 02/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    
    var bus: xmlBusInfo = xmlBusInfo()

    @IBOutlet weak var tfBusNum: UITextField!
    @IBOutlet weak var tfBusStop: UITextField!
    
    @IBOutlet weak var lbText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfBusNum.placeholder = "버스번호(숫자)를 입력해 주세요"
        tfBusStop.placeholder = "정류장 명칭을 입력해 주세요"

        // Do any additional setup after loading the view, typically from a nib.
    }

    //뷰 컨트롤러가 화면에 나타나기 직전에 실행
    override func viewWillAppear(_ animated: Bool) {
        bus.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //버스번호 검색 버튼
    @IBAction func btnBusNum(_ sender: UIButton) {
        
        //숫자외 데이터 입력 시 예외 처리 필요
        
        bus.searchBusNum(busNum: tfBusNum.text!)

    }
    
    @IBAction func btnBusStop(_ sender: UIButton) {
    }
    
    //버스번호 검색 시 데이터 전송
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destin = segue.destination as! BusSeachViewController
        
        destin.busNumSearch = bus
        
    }
    
    @IBAction func returned(segue: UIStoryboardSegue){
        
    }
    

}

