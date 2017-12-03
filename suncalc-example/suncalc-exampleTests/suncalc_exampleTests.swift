//
//  suncalc_exampleTests.swift
//  suncalc-exampleTests
//
//  Created by Shaun Meredith on 10/2/14.
//  Copyright (c) 2014 Chimani, LLC. All rights reserved.
//

import UIKit
import XCTest

let NEARNESS = 1e-9

class suncalc_exampleTests: XCTestCase {
	var date:Date = Date()
	var LAT:Double = 50.5
	var LNG:Double = 30.5
	
	override func setUp() {
		super.setUp()
		var calendar:Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
		calendar.timeZone = TimeZone(abbreviation: "GMT")!
		var components:DateComponents = DateComponents()
		components.year = 2013
		components.month = 3
		components.day = 5
		
		self.date = calendar.date(from: components)!
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func test_sun_getTimes() {
		let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: LAT, longitude: LNG)
		
		let formatter:DateFormatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		formatter.timeZone = TimeZone(abbreviation: "GMT")
		
		XCTAssertEqual(formatter.string(from: sunCalc.solarNoon as Date),						"2013-03-05T10:10:57Z")
		XCTAssertEqual(formatter.string(from: sunCalc.nadir as Date),								"2013-03-04T22:10:57Z")
		XCTAssertEqual(formatter.string(from: sunCalc.sunrise as Date),							"2013-03-05T04:34:57Z")
		XCTAssertEqual(formatter.string(from: sunCalc.sunset as Date),								"2013-03-05T15:46:56Z")
		XCTAssertEqual(formatter.string(from: sunCalc.sunriseEnd as Date),						"2013-03-05T04:38:19Z")
		XCTAssertEqual(formatter.string(from: sunCalc.sunsetStart as Date),					"2013-03-05T15:43:34Z")
		XCTAssertEqual(formatter.string(from: sunCalc.dawn as Date),									"2013-03-05T04:02:17Z")
		XCTAssertEqual(formatter.string(from: sunCalc.dusk as Date),									"2013-03-05T16:19:36Z")
		XCTAssertEqual(formatter.string(from: sunCalc.nauticalDawn as Date),					"2013-03-05T03:24:31Z")
		XCTAssertEqual(formatter.string(from: sunCalc.nauticalDusk as Date),					"2013-03-05T16:57:22Z")
		XCTAssertEqual(formatter.string(from: sunCalc.nightEnd as Date),							"2013-03-05T02:46:17Z")
		XCTAssertEqual(formatter.string(from: sunCalc.night as Date),								"2013-03-05T17:35:36Z")
		XCTAssertEqual(formatter.string(from: sunCalc.goldenHourEnd as Date),				"2013-03-05T05:19:01Z")
		XCTAssertEqual(formatter.string(from: sunCalc.goldenHour as Date),						"2013-03-05T15:02:52Z")
	}
	
	func test_sun_getPosition() {
		let sunPos:SunPosition = SunCalc.getSunPosition(date, latitude: LAT, longitude: LNG)
		XCTAssertEqualWithAccuracy(sunPos.azimuth, -2.5003175907168385, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(sunPos.altitude, -0.7000406838781611, accuracy: NEARNESS)
	}
	
	func test_getMoonPosition() {
		let moonPos:MoonPosition = SunCalc.getMoonPosition(date, latitude: LAT, longitude: LNG)
		XCTAssertEqualWithAccuracy(moonPos.azimuth, -0.9783999522438226, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonPos.altitude, 0.006969727754891917, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonPos.distance, 364121.37256256294, accuracy: NEARNESS)
	}
	
	func test_getMoonIllumination() {
		let moonIllum:MoonIllumination = SunCalc.getMoonIllumination(date)
		XCTAssertEqualWithAccuracy(moonIllum.fraction, 0.4848068202456373, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonIllum.phase, 0.7548368838538762, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonIllum.angle, 1.6732942678578346, accuracy: NEARNESS)
	}
	
	func test_README_example() {
		let date:Date = Date()
		let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: 51.5, longitude: -0.1)
		
		let formatter:DateFormatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		formatter.timeZone = TimeZone(abbreviation: "GMT")
		let sunriseString:String = formatter.string(from: sunCalc.sunrise as Date)
		print("sunrise is at \(sunriseString)")
		
		let sunPos:SunPosition = SunCalc.getSunPosition(date, latitude: 51.5, longitude: -0.1)
		
		let sunriseAzimuth:Double = sunPos.azimuth * 180 / Constants.PI()
		print("sunrise azimuth: \(sunriseAzimuth)")
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
