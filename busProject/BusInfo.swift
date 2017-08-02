//
//  BusInfo.swift
//  busProject
//
//  Created by kwon on 02/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import Foundation

class BusInfo: NSObject, XMLParserDelegate {
    let endPoint: String
    let serviceKey: String
    var xmlBusInfo: String
    var parser: XMLParser?
    
    var buslinenum: String //버스 번호
    var bustype: String //일반, 마을, 급행
    var companyid : String //회사
    var lineId: String //노선아이디
    var startpoint: String //출발점
    var endpoint: String //종착점
    var firsttime: String //첫차 시간
    var endtime: String //막차 시간
    var headway: String //배차간격
    var headwayHoli: String //배차간격(휴일)
    var headwayNorm: String //배차간격(일반)
    var headwayPeak: String //배차간격(출퇴근)
    
    var isbuslinenum: Bool
    var isbustype: Bool
    var iscompanyid : Bool
    var islineId: Bool
    var isstartpoint: Bool
    var isendpoint: Bool
    var isfirsttime: Bool
    var isendtime: Bool
    var isheadway: Bool
    var isheadwayHoli: Bool
    var isheadwayNorm: Bool
    var isheadwayPeak: Bool
    
    override init(){
        endPoint = "http://data.busan.go.kr/openBus/service/busanBIMS2"
        serviceKey = "slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D"
        xmlBusInfo = ""
        
        parser = nil
        
        buslinenum = ""
        bustype = ""
        companyid = ""
        lineId = ""
        startpoint = ""
        endpoint = ""
        firsttime = ""
        endtime = ""
        headway = ""
        headwayHoli = ""
        headwayNorm = ""
        headwayPeak = ""
        
        isbuslinenum = false
        isbustype = false
        iscompanyid = false
        islineId = false
        isstartpoint = false
        isendpoint = false
        isfirsttime = false
        isendtime = false
        isheadway = false
        isheadwayHoli = false
        isheadwayNorm = false
        isheadwayPeak = false
    }
    
    //버스번호로 검색
    func searchBusNum(busNum: String) {
        xmlBusInfo = endPoint + "busInfo?serviceKey=" + serviceKey + "&lineno=" + busNum
        let url = URL(string: xmlBusInfo)
        
        parser = XMLParser(contentsOf: url!)
        
        parser?.delegate = self
        
    }
    
    func getBuslinenum()->String{
        return buslinenum
    }
    func getBustype()->String{
        return bustype
    }
    func getCompanyid()->String{
        return companyid
    }
    func getLineId()->String{
        return lineId
    }
    func getStartpoint()->String{
        return startpoint
    }
    func getEndpoint()->String{
        return endpoint
    }
    func getFirsttime()->String{
        return firsttime
    }
    func getEndtime()->String{
        return endtime
    }
    func getHeadway()->String{
        return headway
    }
    func getHeadwayHoli()->String{
        return headwayHoli
    }
    func getHeadwayNorm()->String{
        return headwayNorm
    }
    func getHeadwayPeak()->String{
        return headwayPeak
    }


    
    //필요 태그값에 표시하기
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if(elementName == "buslinenum"){
            isbuslinenum = true
        }else if(elementName == "bstopNm"){
            isbustype = true
        }else if(elementName == "companyid"){
            iscompanyid = true
        }else if(elementName == "lineId"){
            islineId = true
        }else if(elementName == "startpoint"){
            isstartpoint = true
        }else if(elementName == "endpoint"){
            isendpoint = true
        }else if(elementName == "firsttime"){
            isfirsttime = true
        }else if(elementName == "endtime"){
            isendtime = true
        }else if(elementName == "headway"){
            isheadway = true
        }else if(elementName == "headwayHoli"){
            isheadwayHoli = true
        }else if(elementName == "headwayNorm"){
            isheadwayNorm = true
        }else if(elementName == "headwayPeak"){
            isheadwayPeak = true
        }

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "buslinenum"){
            isbuslinenum = false
        }else if(elementName == "bstopNm"){
            isbustype = false
        }else if(elementName == "companyid"){
            iscompanyid = false
        }else if(elementName == "lineId"){
            islineId = false
        }else if(elementName == "startpoint"){
            isstartpoint = false
        }else if(elementName == "endpoint"){
            isendpoint = false
        }else if(elementName == "firsttime"){
            isfirsttime = false
        }else if(elementName == "endtime"){
            isendtime = false
        }else if(elementName == "headway"){
            isheadway = false
        }else if(elementName == "headwayHoli"){
            isheadwayHoli = false
        }else if(elementName == "headwayNorm"){
            isheadwayNorm = false
        }else if(elementName == "headwayPeak"){
            isheadwayPeak = false
        }

    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        if isbuslinenum{
            buslinenum = string
        }else if isbustype{
            bustype = string
        }else if iscompanyid{
            companyid = string
        }else if islineId{
            lineId = string
        }else if isstartpoint{
            startpoint = string
        }else if isendpoint{
            endpoint = string
        }else if isfirsttime{
            firsttime = string
        }else if isendtime{
            endtime = string
        }else if isheadway{
            headway = string
        }else if isheadwayHoli{
            headwayHoli = string
        }else if isheadwayNorm{
            headwayNorm = string
        }else if isheadwayPeak{
            headwayPeak = string
        }

    }


}


