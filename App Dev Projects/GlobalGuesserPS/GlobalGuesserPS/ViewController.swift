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
NOTES/BUGS:
 -Both points are shown on screen once location is confirmed, sometimes you need to zoom into see them if they are close to the target
 -It randomly picks 1 the 10 locations given each time, so it is possible to get 2 of the same in a row
 -It has a default location if you don't pick anything
 -Map can scroll all the way over (there are no "borders" to it)
 */
import UIKit
import MapKit
struct Location{
    var image: UIImage
    var coordinates: CLLocationCoordinate2D
}
class ViewController: UIViewController {
    //MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locImage: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    //MARK - Variables
    override var shouldAutorotate: Bool { // Locks screen into landscape
        return true
    }
    var locations: [Location] = []
    var latLong: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 40.7865206, longitude: -111.7167087), CLLocationCoordinate2D(latitude: 68.7928111, longitude: -93.4407461), CLLocationCoordinate2D(latitude: 57.998549, longitude: 102.6518604), CLLocationCoordinate2D(latitude: -55.065834, longitude: 110.0088882), CLLocationCoordinate2D(latitude: -69.0089998, longitude: 39.5768748), CLLocationCoordinate2D(latitude: -34.9214678, longitude: -57.9552406), CLLocationCoordinate2D(latitude: -41.445569, longitude: 147.1199944), CLLocationCoordinate2D(latitude: 35.5375206, longitude: 46.1419802), CLLocationCoordinate2D(latitude: 41.7440516, longitude: -91.5599823), CLLocationCoordinate2D(latitude: -17.8258324, longitude: 31.0033495)]
    var guessing: Bool = false
    var points: Int = 0
    var distance: Double = 0
    var currentPlace: Int = 0
    var storedCoords: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    //MARK - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") //Locks screen into landscape mode
        for i in 1...10{ //adds the 10 images into an array of locations
            locations.append(Location(image: UIImage(named: "Location\(i)")!, coordinates: latLong[i-1]))
        }
        //sets up current place
        currentPlace = Int.random(in: 0...locations.count - 1) //sets to a random location
        locImage.image = locations[currentPlace].image
    }
    //makes a basic alert with an ok button and presents it
    func makeAlert(message: String){
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
        }
        alertMessage.addAction(okayAction)
        present(alertMessage, animated: true)
    }
    @IBAction func startClicked(_ sender: Any) {
        if(!guessing){ //start/restart
            makeAnnotation(givenTitle: "Guess", pointCoords: storedCoords) //shows the default guess
            currentPlace = Int.random(in: 0...locations.count - 1) //sets to a random location
            locImage.image = locations[currentPlace].image
            removeAnnotations()
            mapView.removeOverlays(mapView.overlays)
            startBtn.setTitle("Confirm Guess", for: .normal)
            guessing = true
        } else { //confirming guess
            startBtn.setTitle("Restart", for: .normal)
            makeAnnotation(givenTitle: "Target", pointCoords: locations[currentPlace].coordinates)
            distance = CLLocation(latitude: CLLocationDegrees(exactly: storedCoords.latitude)!, longitude: CLLocationDegrees(exactly: storedCoords.longitude)!).distance(from: CLLocation(latitude: CLLocationDegrees(exactly: locations[currentPlace].coordinates.latitude)!, longitude: CLLocationDegrees(exactly: locations[currentPlace].coordinates.longitude)!))
            distance /= 1609.34 //<- converts to miles
            distance = Double(round(100 * distance) / 100) //rounds it to 2 decimals
            points = Int(24901.461 / distance) //circumphrence of earth in miles / distance away -> points
            
            makeAlert(message: "You got \(points) points for being \(distance) miles away!")
            guessing = false
        }
    }
    //make sannotation with given coordinates and title (target + guess)
    func makeAnnotation(givenTitle: String, pointCoords: (CLLocationCoordinate2D)){
        let annotation = MKPointAnnotation()
        annotation.title = givenTitle
        annotation.coordinate = pointCoords
        mapView.addAnnotation(annotation)
    }
    //removes all annotations on the map
    func removeAnnotations(){
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
    }
    //Detects Tap (Beggining) TO ADD: check if touching "click Sprite"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let tapLocation = touch.location(in: mapView)
        if(guessing){
            storedCoords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(storedCoords.latitude) long: \(storedCoords.longitude)")
            removeAnnotations()
            makeAnnotation(givenTitle: "Guess", pointCoords: storedCoords)
        }
    }
}
