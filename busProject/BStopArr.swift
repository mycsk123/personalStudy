//
//  BStopArr.swift
//  busProject
//
//  Created by 0000 on 25/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import Foundation

class xmlBStopBList:NSObject, XMLParserDelegate {
    
    let endPoint: String
    var serviceKey: String
    
    var xmlBStopABus: String
    var parser: XMLParser?
    
    var bStopArrBus: BStopArrBus
    
    var isarsNo: Bool
    var isbstopId: Bool
    var isnodeNm: Bool
    var isgpsX: Bool
    var isgpsY: Bool
    var isbustype: Bool
    var islineNo: Bool
    var islineid: Bool
    var isbstopidx: Bool
    var iscarNo1: Bool
    var ismin1: Bool
    var isstation1: Bool
    var islowplate1: Bool
    var iscarNo2: Bool
    var ismin2: Bool
    var isstation2: Bool
    var islowplate2: Bool
    
    override init(){
        endPoint = "http://data.busan.go.kr/openBus/service/busanBIMS2/"
        serviceKey = "slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D"

        
        xmlBStopABus = ""
        
        parser = nil
        
        
        isarsNo = false
        isbstopId = false
        isnodeNm = false
        isgpsX = false
        isgpsY = false
        isbustype = false
        islineNo = false
        islineid = false
        isbstopidx = false
        iscarNo1 = false
        ismin1 = false
        isstation1 = false
        islowplate1 = false
        iscarNo2 = false
        ismin2 = false
        isstation2 = false
        islowplate2 = false
        
        bStopArrBus = BStopArrBus()
    }
    
    func searchBStopArrBus(bstopId: String, lineId: String){
        
        xmlBStopABus = endPoint + "busStopArr?serviceKey=" + serviceKey + "&bstopid=" + bstopId + "&lineid=" + lineId
        
        let url = URL(string: xmlBStopABus)
        
        parser = XMLParser(contentsOf: url!)
        
        parser?.delegate = self
        
        parser?.parse()

    }
    
    //새로고침
    func bBStopArrBusReload(bstopId: String, lineId: String){
        xmlBStopABus = endPoint + "busStopArr?serviceKey=" + serviceKey + "&bstopid=" + bstopId + "&lineid=" + lineId
        
        let url = URL(string: xmlBStopABus)
        
        DispatchQueue.global(qos: .default).async {
            
            self.parser = XMLParser(contentsOf: url!)
            
            DispatchQueue.main.async {
                self.parser?.delegate = self
                self.parser?.parse()
                
                //uiLB.reloadInputViews()
                
            }
            
        }

        
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if(elementName == "arsNo"){
            isarsNo = true
        }else if(elementName == "bstopId"){
            isbstopId = true
        }else if(elementName == "nodeNm"){
            isnodeNm = true
        }else if(elementName == "gpsX"){
            isgpsX = true
        }else if(elementName == "gpsY"){
            isgpsY = true
        }else if(elementName == "bustype"){
            isbustype = true
        }else if(elementName == "lineNo"){
            islineNo = true
        }else if(elementName == "lineid"){
            islineid = true
        }else if(elementName == "bstopidx"){
            isbstopidx = true
        }else if(elementName == "carNo1"){
            iscarNo1 = true
        }else if(elementName == "min1"){
            ismin1 = true
        }else if(elementName == "station1"){
            isstation1 = true
        }else if(elementName == "lowplate1"){
            islowplate1 = true
        }else if(elementName == "carNo2"){
            iscarNo2 = true
        }else if(elementName == "min2"){
            ismin2 = true
        }else if(elementName == "station2"){
            isstation2 = true
        }else if(elementName == "lowplate2"){
            islowplate2 = true
        }

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "arsNo"){
            isarsNo = false
        }else if(elementName == "bstopId"){
            isbstopId = false
        }else if(elementName == "nodeNm"){
            isnodeNm = false
        }else if(elementName == "gpsX"){
            isgpsX = false
        }else if(elementName == "gpsY"){
            isgpsY = false
        }else if(elementName == "bustype"){
            isbustype = false
        }else if(elementName == "lineNo"){
            islineNo = false
        }else if(elementName == "lineid"){
            islineid = false
        }else if(elementName == "bstopidx"){
            isbstopidx = false
        }else if(elementName == "carNo1"){
            iscarNo1 = false
        }else if(elementName == "min1"){
            ismin1 = false
        }else if(elementName == "station1"){
            isstation1 = false
        }else if(elementName == "lowplate1"){
            islowplate1 = false
        }else if(elementName == "carNo2"){
            iscarNo2 = false
        }else if(elementName == "min2"){
            ismin2 = false
        }else if(elementName == "station2"){
            isstation2 = false
        }else if(elementName == "lowplate2"){
            islowplate2 = false
        }
    }
    
    //arsNo값이 없는 경우도 존재. 키값을 정할 것(데이터가 없어서 append로 생성하지 못해 범위를 넘어섬)

    func parser(_ parser: XMLParser, foundCharacters string: String){

        if(isarsNo){
            bStopArrBus.arsNo = string
        }else if(isbstopId){
            bStopArrBus.bstopId = string
        }else if(isnodeNm){
            bStopArrBus.nodeNm = string
        }else if(isgpsX){
            bStopArrBus.gpsX = string
        }else if(isgpsY){
            bStopArrBus.gpsY = string
        }else if(isbustype){
            bStopArrBus.bustype = string
        }else if(islineNo){
            bStopArrBus.lineNo = string
        }else if(islineid){
            bStopArrBus.lineid = string
        }else if(isbstopidx){
            bStopArrBus.bstopidx = string
        }else if(iscarNo1){
            bStopArrBus.carNo1 = string
        }else if(ismin1){
            bStopArrBus.min1 = string
        }else if(isstation1){
            bStopArrBus.station1 = string
        }else if(islowplate1){
            bStopArrBus.lowplate1 = string
        }else if(iscarNo2){
            bStopArrBus.lowplate2 = string
        }else if(ismin2){
            bStopArrBus.min2 = string
        }else if(isstation2){
            bStopArrBus.station2 = string
        }else if(islowplate2){
            bStopArrBus.lowplate2 = string
        }

    }

    
    
    
    
}


class BStopArrBus {
    var arsNo: String //정류소 번호
    var bstopId: String //정류소ID
    var nodeNm: String //정류소명
    var gpsX: String //정류소GPS X좌표
    var gpsY: String //정류소GPS Y좌표
    var bustype: String //버스 종류
    var lineNo: String //버스 번호
    var lineid: String //노선ID
    var bstopidx: String //노선 정류소 순번
    var carNo1: String //차량번호(4자리)
    var min1: String // 남은 도착시간(분)
    var station1: String //남은 정류소 숫자
    var lowplate1: String //0: 일반, 1: 저상
    var carNo2: String //차량번호(4자리)
    var min2: String //남은 도착시간(분)
    var station2: String //남은 정류소 숫자
    var lowplate2: String //0: 일반, 1: 저상

    init(){
        arsNo = ""
        bstopId = ""
        nodeNm = ""
        gpsX = ""
        gpsY = ""
        bustype = ""
        lineNo = ""
        lineid = ""
        bstopidx = ""
        carNo1 = ""
        min1 = ""
        station1 = ""
        lowplate1 = ""
        carNo2 = ""
        min2 = ""
        station2 = ""
        lowplate2 = ""
    }

}
