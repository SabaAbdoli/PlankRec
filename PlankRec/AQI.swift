//
//  Networking.swift
//  PlankRec
//
//  Created by Apple on 4/18/23.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreLocation

class AQI {
    var delegate :AQIDelagate!
    var aqi :Int!
    
    let weatherURL =  "https://air-quality-api.open-meteo.com/v1/air-quality?"

    
    func getAQI(_ lat:String,_ lon:String){
        
        let parameters : [String:String] = [
            "latitude":lat,
            "longitude":lon,
            "hourly": "us_aqi",
        ]
        
        Alamofire.request(weatherURL,method: .get, parameters: parameters).responseJSON { [self] response in
            if response.result.isSuccess{
                let jsonObj : JSON = JSON(response.result.value!)
                aqi = jsonObj["hourly"]["us_aqi"][23].int!
                delegate.getAqi(aqi)
               
            }else{
                aqi = 0
            }
        }
      
    }
    
    
}

protocol AQIDelagate {
    func getAqi(_ aqi:Int)
}
