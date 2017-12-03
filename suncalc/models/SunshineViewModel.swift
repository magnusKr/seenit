//
//  SunViewModel.swift
//  suncalc-example
//
//  Created by Magnus Kraepelien on 02/05/16.
//  Copyright © 2016 Chimani, LLC. All rights reserved.
//

import Foundation

struct SunshineViewModel {
    
    fileprivate var sunPos:SunPosition!
    fileprivate var longitude: Double!
    fileprivate var lattitude: Double!
    fileprivate var date:Date!
    fileprivate let screenWidth: Int!
    fileprivate let screenHeight: Int!
    
    fileprivate let sunTimes:SunCalc!
    fileprivate let sunPosition: SunPosition!
    
    var sunSet: Date{
        get{
          return sunTimes.sunset as Date
        }
    }
    
    var sunRise: Date{
        get {
            return sunTimes.sunrise as Date
        }
    }
    

    
    init(userLongitude longitude:Double, userLattitude lattitude:Double, userDate date:Date, screenWidth width:Int, screenHeight height:Int)
    {
        self.longitude = longitude
        self.lattitude = lattitude
        self.date = date
        self.screenWidth = width
        self.screenHeight = height
        
        sunTimes = SunCalc(date: date, latitude: lattitude, longitude: longitude)
        sunPosition = SunCalc.getSunPosition(date, latitude: lattitude, longitude: longitude)
        
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "GMT+1")
        
        
        
        print("Sunshineviewmodel initialized with longitude: : \(self.longitude) Lattitude : \(self.lattitude) Date: \(self.date)")
        print("Sunshineviewmodel initialized with width: : \(self.screenWidth) Height : \(self.screenHeight)")
        print("Sunrise = \(formatter.string(from: sunTimes.sunrise as Date)) Sunset : \(formatter.string(from: sunTimes.sunset as Date))")
        print("Sunposition: Altitude = \(sunPosition.altitude) Azimuth : \(sunPosition.azimuth)")
    }
    
    func getXposition(_ heading: Double) -> Double {
        
        let sunAzimuth: Double = (sunPosition.azimuth*(180/M_PI)+180)
      
        return 5*(sunAzimuth-heading)
    }
    
    
    
}


