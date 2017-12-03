//
//  ViewController.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//  Copyright (c) 2014 Chimani, LLC. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import AVFoundation
import MobileCoreServices




class ViewController: UIViewController,CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var azimutLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var timeLabelUp: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var yawLabel: UILabel!
    @IBOutlet weak var compass: UILabel!
    
    @IBOutlet weak var magneticHeading: UILabel!
   
    
    @IBOutlet weak var camerView: UIImageView!

    
    
    var sunPos:SunPosition!

   
    var sunShineViewController: SunshineViewController!
    
    let imagePicker = UIImagePickerController()
    


	override func viewDidLoad() {
		super.viewDidLoad()
        
        imagePicker.delegate = self
        
        setupCamera()
    
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    }
    
    func setupCamera() {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        let screenSize:CGSize = UIScreen.main.bounds.size
        
        let ratio:CGFloat = 4.0 / 3.0
        let cameraHeight: CGFloat = screenSize.width * ratio
        let scale:CGFloat = screenSize.height / cameraHeight
        
        imagePicker.cameraViewTransform = CGAffineTransform(translationX: 0, y: (screenSize.height - cameraHeight) / 2.0)
        imagePicker.cameraViewTransform = imagePicker.cameraViewTransform.scaledBy(x: scale, y: scale)
        
        self.sunShineViewController = SunshineViewController(nibName: "SunshineView", bundle: nil)

        sunShineViewController.view.frame = self.imagePicker.view.frame
        
        imagePicker.modalPresentationStyle = .overFullScreen
        imagePicker.showsCameraControls = false
        
        present(imagePicker, animated: true) {
            self.imagePicker.cameraOverlayView = self.sunShineViewController.view
        }
    }
    
}

