//
//  BusI.swift
//  busProject
//
//  Created by kwon on 02/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import Foundation
import UIKit

class xmlBusInfo:NSObject, XMLParserDelegate{
    
    let endPoint: String
    let serviceKey: String
    var xmlBusInfo: String
    var parser: XMLParser?
    
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
    
    var isResultCode: Bool
    
    //리턴값이 "00"일 경우에만 정상 출력(But 값이 00이라도 값이 제대로 들어오지 않는 경우 발생)
    var xmlErrCode: String
    
    var busInfoData: [BusInfos]
    
    override init() {

        endPoint = "http://data.busan.go.kr/openBus/service/busanBIMS2/"
        serviceKey = "slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D"
        xmlBusInfo = ""
        
        parser = nil
        
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
        
        isResultCode = false
        
        busInfoData = [BusInfos]()
        xmlErrCode = ""
    }
    
    //새로 파싱할때 클래스 배열은 초기화(.remove)할 것
    
    //init 초기화를 그대로 받는 방법은?
//    init(temp: String){
//        
//        serviceKey = temp
//    }
    
    func searchBusNum(busNum : String){
        
        xmlBusInfo = endPoint + "busInfo?serviceKey=" + serviceKey + "&lineno=" + busNum
        
        let url = URL(string: xmlBusInfo)
        
        parser = XMLParser(contentsOf: url!)
        
        parser?.delegate = self
        
        parser?.parse()

    }
   
    //필요 태그값에 표시하기
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if(elementName == "resultCode"){
            isResultCode = true
        }
        
        if(elementName == "buslinenum"){
            isbuslinenum = true
        }
        else if(elementName == "bustype"){
            isbustype = true
        }
        else if(elementName == "companyid"){
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
        
        if(elementName == "resultCode"){
            isResultCode = false
        }
        
        if(elementName == "buslinenum"){
            isbuslinenum = false
            busInfoTemp.removeAll()
        }
        else if(elementName == "bustype"){
            isbustype = false
        }
        else if(elementName == "companyid"){
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
    
    //xml 데이터 값 중 '('가 들어있을 경우 오류처리를 위한 임시값
    var busInfoTemp : [String] = [String]()
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        if isResultCode{
            xmlErrCode = string
        }
        
        //xml 데이터 중 숫자 뒤에 (가 들어오면 2번에 걸쳐 데이터가 완성되므로 예외처리 필요
        //매번 데이터가 들어올때마다 busInfoData 추가
        
        if isbuslinenum{
            
            busInfoTemp.append(string)
            if(busInfoTemp.count == 1) {
                busInfoData.append(BusInfos())
                busInfoData[busInfoData.count - 1].buslinenum = string
            } else {
                
                //이전 busInfoData배열에 수정값 넣기
                var lineStr : String = ""
                for i in 0..<busInfoTemp.count {
                    lineStr += busInfoTemp[i]
                }
                busInfoData[busInfoData.count - 1].buslinenum = lineStr
            }
        }
        else if isbustype{
            busInfoData[busInfoData.count - 1].bustype = string
        }
        else if iscompanyid{
            busInfoData[busInfoData.count - 1].companyid = string
        }else if islineId{
            busInfoData[busInfoData.count - 1].lineId = string
        }else if isstartpoint{
            busInfoData[busInfoData.count - 1].startpoint = string
        }else if isendpoint{
            busInfoData[busInfoData.count - 1].endpoint = string
        }else if isfirsttime{
            busInfoData[busInfoData.count - 1].firsttime = string
        }else if isendtime{
            busInfoData[busInfoData.count - 1].endtime = string
        }else if isheadway{
            busInfoData[busInfoData.count - 1].headway = string
        }else if isheadwayHoli{
            busInfoData[busInfoData.count - 1].headwayHoli = string
        }else if isheadwayNorm{
            busInfoData[busInfoData.count - 1].headwayNorm = string
        }else if isheadwayPeak{
            busInfoData[busInfoData.count - 1].headwayPeak = string
        }
    
    }

}

class BusInfos{
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
    
    init(){
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
    }
    
}
