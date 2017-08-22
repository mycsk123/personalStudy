//
//  BusRouteid.swift
//  busProject
//
//  Created by 0000 on 16/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import Foundation
import UIKit

class xmlBusInfoByRouteid:NSObject, XMLParserDelegate{
    let endPoint: String
    var serviceKey: String
    
    var xmlBusRoute: String
    var parser: XMLParser?
    
    var isarsNo: Bool
    var isavgtm: Bool
    var isbstopIdx: Bool
    var isbstopnm: Bool
    var iscarNo: Bool
    var isdirection: Bool
    var isgpsTm: Bool
    var islat: Bool
    var islon: Bool
    var islineNo: Bool
    var islowplate: Bool
    var isnodeId: Bool
    var isnodeKn: Bool
    var isrpoint: Bool
    
    var busRouteidData: [BusInfoByRouteid]

    override init() {
        
        endPoint = "http://data.busan.go.kr/openBus/service/busanBIMS2/"
        serviceKey = "slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D"
        xmlBusRoute = ""
        
        parser = nil
        
        isarsNo = false
        isavgtm = false
        isbstopIdx = false
        isbstopnm = false
        iscarNo = false
        isdirection = false
        isgpsTm = false
        islat = false
        islon = false
        islineNo = false
        islowplate = false
        isnodeId = false
        isnodeKn = false
        isrpoint = false
        
        busRouteidData = [BusInfoByRouteid]()

    }
    
    //새로 파싱할때 클래스 배열은 초기화(.remove)할 것
    func initData(){
        busRouteidData.removeAll()
    }
    
    //버스노선도 검색
    func searchBusNum(routeId : String){
        
        xmlBusRoute = endPoint + "busInfoRoute?serviceKey=" + serviceKey + "&lineid=" + routeId
        
        let url = URL(string: xmlBusRoute)
        
        parser = XMLParser(contentsOf: url!)
        
        parser?.delegate = self
        
        parser?.parse()
        
    }
    
    //필요 태그값에 표시하기
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        
        if(elementName == "arsNo"){
            isarsNo = true
        }else if(elementName == "avgtm"){
            isavgtm = true
        }else if(elementName == "bstopIdx"){
            isbstopIdx = true
        }else if(elementName == "bstopnm"){
            isbstopnm = true
        }else if(elementName == "carNo"){
            iscarNo = true
        }else if(elementName == "direction"){
            isdirection = true
        }else if(elementName == "gpsTm"){
            isgpsTm = true
        }else if(elementName == "lat"){
            islat = true
        }else if(elementName == "lon"){
            islon = true
        }else if(elementName == "lineNo"){
            islineNo = true
        }else if(elementName == "lowplate"){
            islowplate = true
        }else if(elementName == "nodeId"){
            isnodeId = true
        }else if(elementName == "nodeKn"){
            isnodeKn = true
        }else if(elementName == "rpoint"){
            isrpoint = true
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "arsNo"){
            isarsNo = false
        }else if(elementName == "avgtm"){
            isavgtm = false
        }else if(elementName == "bstopIdx"){
            isbstopIdx = false
        }else if(elementName == "bstopnm"){
            isbstopnm = false
        }else if(elementName == "carNo"){
            iscarNo = false
        }else if(elementName == "direction"){
            isdirection = false
        }else if(elementName == "gpsTm"){
            isgpsTm = false
        }else if(elementName == "lat"){
            islat = false
        }else if(elementName == "lon"){
            islon = false
        }else if(elementName == "lineNo"){
            islineNo = false
        }else if(elementName == "lowplate"){
            islowplate = false
        }else if(elementName == "nodeId"){
            isnodeId = false
        }else if(elementName == "nodeKn"){
            isnodeKn = false
        }else if(elementName == "rpoint"){
            isrpoint = false
        }
    }
    
    //xml 데이터 값 중 '('가 들어있을 경우 오류가 생기는지 확인 필요
    //arsNo값이 없는 경우도 존재. 키값을 정할 것(데이터가 없어서 append로 생성하지 못해 범위를 넘어섬)
    var isAction: Bool = false
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        if isarsNo{
            isAction = true
            busRouteidData.append(BusInfoByRouteid())
            busRouteidData[busRouteidData.count - 1].arsNo = string
        }
        else if isavgtm{
            
            if(!isAction){
                busRouteidData.append(BusInfoByRouteid())
                print("isavgtm 값 : " + string)
            }
            //버스번호 203번호 검색 후 노선도까지 진행 시 멈춤 현상 발생(index out of range)
            busRouteidData[busRouteidData.count - 1].avgtm = string
            isAction = false
        }else if isbstopIdx{
            busRouteidData[busRouteidData.count - 1].bstopIdx = string
        }else if isbstopnm{
            busRouteidData[busRouteidData.count - 1].bstopnm = string
        }else if iscarNo{
            busRouteidData[busRouteidData.count - 1].carNo = string
        }else if isdirection{
            busRouteidData[busRouteidData.count - 1].direction = string
        }else if isgpsTm{
            busRouteidData[busRouteidData.count - 1].gpsTm = string
        }else if islat{
            busRouteidData[busRouteidData.count - 1].lat = string
        }else if islon{
            busRouteidData[busRouteidData.count - 1].lon = string
        }else if islineNo{
            busRouteidData[busRouteidData.count - 1].lineNo = string
        }else if islowplate{
            busRouteidData[busRouteidData.count - 1].lowplate = string
        }else if isnodeId{
            busRouteidData[busRouteidData.count - 1].nodeId = string
        }else if isnodeKn{
            busRouteidData[busRouteidData.count - 1].nodeKn = string
        }else if isrpoint{
            busRouteidData[busRouteidData.count - 1].rpoint = string
        }
        
    }
    
}

//노선 정류소 조회
class BusInfoByRouteid {
    var arsNo: String //정류소 번호
    var avgtm: String //평균시간
    var bstopIdx: String //노선 정류소 순번
    var bstopnm: String //정류소 이름
    var carNo: String //버스 차량번호
    var direction: String //버스 운행 방향
    var gpsTm: String //HH24:MI:SS형식
    var lat: String //버스GPS X좌표
    var lon: String //버스GPS Y좌표
    var lineNo: String //노선번호
    var lowplate: String //저상버스 0: 일반, 1: 저상
    var nodeId: String //노드ID
    var nodeKn: String //노드종류(0: 교차로, 3:정류소)
    var rpoint: String //0: 일반, 1: 회차지
    
    init() {
        arsNo = ""
        avgtm = ""
        bstopIdx = ""
        bstopnm = ""
        carNo = ""
        direction = ""
        gpsTm = ""
        lat = ""
        lon = ""
        lineNo = ""
        lowplate = ""
        nodeId = ""
        nodeKn = ""
        rpoint = ""
    }
}
