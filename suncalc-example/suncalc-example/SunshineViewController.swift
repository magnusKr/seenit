//
//  OverlayViewController.swift
//  suncalc-example
//
//  Created by Magnus Kraepelien on 01/05/16.
//  Copyright © 2016 Chimani, LLC. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import AVFoundation
import MobileCoreServices

class SunshineViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager : CLLocationManager!
    var motionManager: CMMotionManager!
    var displayLink : CADisplayLink!
    var heading: Double!
    
    
    var snapX: CGFloat = 40.0
    var treshold: CGFloat = 5.0
    var selectedView: UIView?
    var shouldDragY = false
    var shouldDragX = true
    
    
    var viewModel: SunshineViewModel!
    
    var circleMonth:MonthCircle!

  
    @IBOutlet weak var sunImage: UIImageView!
    
    @IBOutlet weak var centerConstSun: NSLayoutConstraint!

    @IBOutlet weak var topConstSun: NSLayoutConstraint!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupLocationManager()
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        
        setupMotionManager()
        displayLink = CADisplayLink(target: self, selector: (#selector(self.updateMotionData)))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        
     
        
        let circlePOint: CGPoint = CGPoint(x: (self.view.frame.size.width)/4, y: self.view.center.y)
        
        circleMonth = MonthCircle()
        
        circleMonth.setX(-250)
        circleMonth.setY(450)
        
        self.view.addSubview(circleMonth)

        setupGestures()
        
        
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(SunshineViewController.rotate(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    func rotate(_ rec:UIPanGestureRecognizer) {
        let touchpoint: CGPoint = rec.location(in: self.view)
        var zeropoint:CGPoint = CGPoint.zero

        
        switch rec.state {
        case .began:
            selectedView = view.hitTest(touchpoint, with: nil)!
        case .changed:
            if let subview = selectedView{
                zeropoint = subview.center
              //  var distance = sqrt(pow(p.x - center.x, 2))
                let distance = (touchpoint.x - zeropoint.x)
                
                var degrees: Double = Double(distance)/2
                degrees = (degrees*M_PI)/180
                
                
               
                
                
                //räkna ut grader här distance / 360 
                
                
                if subview is MonthCircle{
                    //if distance > treshold{
                        if shouldDragX {
                            //distance = (distance % snapX)/10
                            print(distance)
                            self.circleMonth.transform = CGAffineTransform(rotationAngle: CGFloat(degrees))
                           // subview.center.x = p.x - (p.x % snapX)
                            
                        }
                 //  }
                
                
                }
            }
            
        case .ended:
            selectedView = nil
        default:
            break
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.headingFilter = 1
    }
    
    fileprivate func setupMotionManager() {
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 1.0 / 30.0
        motionManager.startDeviceMotionUpdates()
    }
    
    func updateMotionData() {
        
        if let attit = motionManager.deviceMotion?.attitude {
            
            let pitchValue:Double = attit.pitch*(180/M_PI)
            let yawValue:Double = attit.yaw
            
            
            //Altitude
            //  pitchLabel.text = String(format: "%1.0f", pitchValue*(180/M_PI))
            
            //azimuth
            //  yawLabel.text = String(format: "%1.0f",yawValue)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location:CLLocation = locations[locations.count-1] as CLLocation{
            
            setupViewModel(location)
        }
        
    }
    
    func setupViewModel(_ location:CLLocation) {
        
        let lattitude = Double(location.coordinate.latitude)
        let longitude = Double(location.coordinate.longitude)
        
        let width: Int = Int(self.view.frame.size.width)
        let height: Int = Int(self.view.frame.size.height)
        
        viewModel = SunshineViewModel(userLongitude: longitude, userLattitude: lattitude, userDate: Date(), screenWidth: width, screenHeight: height)
        
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "GMT+1")
        
        sunriseLabel.text = formatter.string(from: viewModel.sunRise as Date)
        sunsetLabel.text = formatter.string(from: viewModel.sunSet as Date)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        

        updateSunElement(newHeading)
        
        
        
        //    compass.text = String(format: "%1.0f", (newHeading.magneticHeading))
        //   magneticHeading.text = String(format: "%1.0f", (newHeading.trueHeading))
    }
    
    fileprivate func updateSunElement(_ headingValue: CLHeading)
    {
        if let userDegree:Double? = Double(headingValue.trueHeading){
            let xpositionSun:Double = viewModel.getXposition(userDegree!)
            
            centerConstSun.constant = CGFloat(xpositionSun)
            
            //print("Heading: \(centerConstSun.constant)")
            
        }
    }
}
