//
//  SunViewModel.swift
//  suncalc-example
//
//  Created by Magnus Kraepelien on 02/05/16.
//  Copyright © 2016 Chimani, LLC. All rights reserved.
//

import Foundation

struct SunshineViewModel {
    
    private var sunPos:SunPosition!
    private var longitude: Double!
    private var lattitude: Double!
    private var date:NSDate!
    private let screenWidth: Int!
    private let screenHeight: Int!
    
    private let sunTimes:SunCalc!
    private let sunPosition: SunPosition!
    
    var sunSet: NSDate{
        get{
          return sunTimes.sunset
        }
    }
    
    var sunRise: NSDate{
        get {
            return sunTimes.sunrise
        }
    }
    

    
    init(userLongitude longitude:Double, userLattitude lattitude:Double, userDate date:NSDate, screenWidth width:Int, screenHeight height:Int)
    {
        self.longitude = longitude
        self.lattitude = lattitude
        self.date = date
        self.screenWidth = width
        self.screenHeight = height
        
        sunTimes = SunCalc(date: date, latitude: lattitude, longitude: longitude)
        sunPosition = SunCalc.getSunPosition(date, latitude: lattitude, longitude: longitude)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+1")
        
        
        
        print("Sunshineviewmodel initialized with longitude: : \(self.longitude) Lattitude : \(self.lattitude) Date: \(self.date)")
        print("Sunshineviewmodel initialized with width: : \(self.screenWidth) Height : \(self.screenHeight)")
        print("Sunrise = \(formatter.stringFromDate(sunTimes.sunrise)) Sunset : \(formatter.stringFromDate(sunTimes.sunset))")
        print("Sunposition: Altitude = \(sunPosition.altitude) Azimuth : \(sunPosition.azimuth)")
    }
    
    func getXposition(heading: Double) -> Double {
        
        let sunAzimuth: Double = (sunPosition.azimuth*(180/M_PI)+180)
      
        return 5*(sunAzimuth-heading)
    }
    
    
    
}


