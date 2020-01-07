//
//  ViewController.swift
//  GlobalGuesserPS
//
//  Created by Tristan Pudell-Spatscheck on 1/7/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//
/* LOCATIONS
 1.)40.7865206,-111.7167087
 2.)68.7928111,-93.4407461
 3.)57.998549,102.6518604
 4.)-55.065834,110.0088882
 5.)-69.0089998,39.5768748
 6.)-34.9214678,-57.9552406
 7.)-41.445569,147.1199944
 8.)35.5375206,46.1419802
 9.)41.7440516,-91.5599823
 10.)-17.8258324,31.0033495
 */
import UIKit
import MapKit
struct Location{
    var image: UIImage
    var lat: CGFloat
    var long: CGFloat
}
var locations: [Location] = []
var latLong: [CGPoint] = [CGPoint(x: 40.7865206, y: -111.7167087), CGPoint(x: 68.7928111, y: -93.4407461), CGPoint(x: 57.998549, y: 102.6518604), CGPoint(x: -55.065834, y: 110.0088882), CGPoint(x: -69.0089998, y: 39.5768748), CGPoint(x: -34.9214678, y: -57.9552406), CGPoint(x: -41.445569, y: 147.1199944), CGPoint(x: 35.5375206, y: 46.1419802), CGPoint(x: 41.7440516, y: -91.5599823), CGPoint(x: -17.8258324, y: 31.0033495)]
class ViewController: UIViewController {
    //MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locImage: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    //MARK - Variables
    override var shouldAutorotate: Bool {
        return true
    }
    //MARK - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") //Locks screen into landscape mode
        for i in 1...10{ //adds the 10 images into an array of locations
            locations.append(Location(image: UIImage(named: "Location\(i)")!, lat: latLong[i-1].x , long: latLong[i-1].y))
        }
        locImage.image = locations[0].image
        print("Load")
    }
    @IBAction func startClicked(_ sender: Any) {
        startBtn.isHidden = true
        locImage.isHidden = true
        print("Click")
    }
}
