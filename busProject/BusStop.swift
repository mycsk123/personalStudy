//
//  BusStop.swift
//  busProject
//
//  Created by 0000 on 18/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import Foundation
import UIKit

class xmlBStopList:NSObject, XMLParserDelegate {
    let endPoint: String
    var serviceKey: String
    
    var xmlBusInfo: String
    var parser: XMLParser?
    
    var isbstopArsno: Bool
    var isbstopId: Bool
    var isbstopNm: Bool
    var isgpsX: Bool
    var isgpsY: Bool
    var isstoptype: Bool
    
    var bStopData: [BStopInfo]
    
    override init(){
        endPoint = "http://data.busan.go.kr/openBus/service/busanBIMS2/"
        serviceKey = "slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D"
        xmlBusInfo = ""
        
        parser = nil
        
        isbstopArsno = false
        isbstopId = false
        isbstopNm = false
        isgpsX = false
        isgpsY = false
        isstoptype = false
        
        bStopData = [BStopInfo]()
    }

    //정류소 번호로 검색(정류소 번호 배열로 받고, 정류소 정보 클래스 배열로 리턴)
    func searchBStop(bstopNum: [BusInfoByRouteid]){
        
        for i in 0..<bstopNum.count {
            
            //bstopArsno 값이 없는 경우도 존재. 그러므로 키값으로 부적합. 다른 방안 생각해 볼것
            xmlBusInfo = endPoint + "busStop?serviceKey=" + serviceKey + "&arsno=" + bstopNum[i].arsNo
            
            let url = URL(string: xmlBusInfo)
            
            parser = XMLParser(contentsOf: url!)
            
            parser?.delegate = self
            
            parser?.parse()
        }

    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if(elementName == "bstopArsno"){
            isbstopArsno = true
        }else if(elementName == "bstopId"){
            isbstopId = true
        }else if(elementName == "bstopNm"){
            isbstopNm = true
        }else if(elementName == "gpsX"){
            isgpsX = true
        }else if(elementName == "gpsY"){
            isgpsY = true
        }else if(elementName == "stoptype"){
            isstoptype = true
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "bstopArsno"){
            isbstopArsno = false
        }else if(elementName == "bstopId"){
            isbstopId = false
        }else if(elementName == "bstopNm"){
            isbstopNm = false
        }else if(elementName == "gpsX"){
            isgpsX = false
        }else if(elementName == "gpsY"){
            isgpsY = false
        }else if(elementName == "stoptype"){
            isstoptype = false
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isbstopArsno{
            
        }else if isbstopId{
            
        }else if isbstopNm{
            
        }else if isgpsX{
            
        }else if isgpsY{
            
        }else if isstoptype{
            
        }

    }
    
    
}

class BStopInfo{
    var bstopArsno: String //정류소번호
    var bstopId: String //정류소아이디
    var bstopNm: String //정류소명
    var gpsX: String //GPS X좌표
    var gpsY: String //GPS Y좌표
    var stoptype: String //정류소구분 - 일반, 마을
    
    init() {
        bstopArsno = ""
        bstopId = ""
        bstopNm = ""
        gpsX = ""
        gpsY = ""
        stoptype = ""
    }
    
    
}
