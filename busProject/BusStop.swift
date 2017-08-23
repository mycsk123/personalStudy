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
    
    var xmlBStop: String
    var parser: XMLParser?
    
    var isbstopArsno: Bool
    var isbstopId: Bool
    var isbstopNm: Bool
    var isgpsX: Bool
    var isgpsY: Bool
    var isstoptype: Bool
    
    var bStopData: [BStopInfo]
    var parserUrl: [URL]
    
    var parserIndex: Int
    
    override init(){
        endPoint = "http://data.busan.go.kr/openBus/service/busanBIMS2/"
        serviceKey = "slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D"
        xmlBStop = ""
        
        parser = nil
        
        isbstopArsno = false
        isbstopId = false
        isbstopNm = false
        isgpsX = false
        isgpsY = false
        isstoptype = false
        
        bStopData = [BStopInfo]()
        parserUrl = [URL]()
        parserIndex = 0
    }

    //정류소 번호로 검색(정류소 번호 배열로 받고, 정류소 정보 클래스 배열로 리턴)
    func searchBStop(bstopNum: [BusInfoByRouteid]){
                
        //bstopArsno 값이 없는 경우도 존재. 그러므로 키값으로 부적합. 다른 방안 생각해 볼것
        
        //url을 모두 생성하여 비동기적으로 파서 진행
        for i in 0..<bstopNum.count {
            
            //bStopData.append(BStopInfo())
            
            print("값 : " + bstopNum[i].arsNo)
            
            if((bstopNum[i].arsNo == nil) || (bstopNum[i].arsNo == "")){
                //arsNo이 없을 경우 대비 - 값이 없을 땐 배열생성만 하고... 차후 방법 적용
                print("\(i)번째에는 값이 없음")
                let url = URL(string: "")
                parserUrl.append(url!)

            }else{
                //정확도를 위해 정류소 명과 번호를 동시 입력 검사(1가지만 검색 시 다중 결과 출력)
                //addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) <- 한글은 nil값을 반환하기 때문에 추가
                
                xmlBStop = endPoint + "busStop?serviceKey=" + serviceKey + "&bstopnm=" + bstopNum[i].bstopnm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&arsno=" + bstopNum[i].arsNo
                
                let url = URL(string: xmlBStop)
                
                parserUrl.append(url!)
            }
            
                
//                //정확도를 위해 정류소 명과 번호를 동시 입력 검사(1가지만 검색 시 다중 결과 출력)
//                //addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) <- 한글은 nil값을 반환하기 때문에 추가
//                xmlBStop = endPoint + "busStop?serviceKey=" + serviceKey + "&bstopnm=" + bstopNum[i].bstopnm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&arsno=" + bstopNum[i].arsNo
//                
//                let url = URL(string: xmlBStop)
//                
//                parser = XMLParser(contentsOf: url!)
//                
//                parser?.delegate = self
//                
//                parser?.parse()

  
        }
        
        //dispatch
        //파서 비동기 작성
        
        var parserArr : [XMLParser?] = [XMLParser?]()
        DispatchQueue.global().async {
            
            for i in 0..<self.parserUrl.count{
               // DispatchQueue.main.async {
                    print(String(i) + "번째 parser")
                    
                    if(self.parserUrl == nil){
                        
                    }else{
                       // parserArr.append(XMLParser(contentsOf: self.parserUrl[i]))
                       // parserArr[i]?.delegate = self
                        //parserArr[i]?.parse()
                    }
                //}
            }
            
            DispatchQueue.main.sync {
                for i in 0..<self.parserUrl.count{
                    parserArr[i]?.parse()
                }
            }
            
//            DispatchQueue.main.async {
//    
//                for i in 0..<self.parserUrl.count{
//                    //self.bStopData.append(BStopInfo())
//                    print("parser")
//                    
//                    if(self.parserUrl == nil){
//                        
//                    }else{
//                        self.parser = XMLParser(contentsOf: self.parserUrl[i])
//                        self.parser?.delegate = self
//                        self.parser?.parse()
//                    }
//
//                }
//                
//            }
        
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
    
    //arsNo값이 없는 경우도 존재. 키값을 정할 것(데이터가 없어서 append로 생성하지 못해 범위를 넘어섬)
    var isAction: Bool = false
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isbstopArsno{
            //bStopData[bStopData.count - 1].bstopArsno = string
            
            isAction = true
            bStopData.append(BStopInfo())
            bStopData[bStopData.count - 1].bstopArsno = string
            
        }else if isbstopId{
            if(!isAction){
                bStopData.append(BStopInfo())
            }
            bStopData[bStopData.count - 1].bstopId = string
            isAction = false
        }else if isbstopNm{
            bStopData[bStopData.count - 1].bstopNm = string
            
        }else if isgpsX{
            bStopData[bStopData.count - 1].gpsX = string
        }else if isgpsY{
            bStopData[bStopData.count - 1].gpsY = string
        }else if isstoptype{
            bStopData[bStopData.count - 1].stoptype = string
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
