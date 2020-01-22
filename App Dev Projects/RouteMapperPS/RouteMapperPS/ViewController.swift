//
//  ViewController.swift
//  GlobalGuesserPS
//
//  Created by Tristan Pudell-Spatscheck on 1/7/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//
/*
NOTES/BUGS:
-Undo Button Added for Extra Credit
-Gives Option to Show individual route distances for Extra Credit
^ 2 "Fun/Interesting" extensions were added
-ALL Taps add an annotation (hold tap function isn't supported by MapKit), can be "fixed" by the user hitting undo repeatedly once they find their location.
-"Start" isn't connected in polyline <- not sure what causes that, likely to be due to User Location
 */
import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    //MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    //MARK - Variables
    override var shouldAutorotate: Bool { // Locks screen into landscape
        return false
    }
    var phase: Int = 0 //phase 0 = turns, 1 = end, 2 = viewing
    var distance: Double = 0
    var userCoords: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var turnLocations: [CLLocationCoordinate2D] = []
    var annotations: [MKAnnotation] = [] //used because annotation.remove is bugged
    var distances: [Double] = [] //used for extra credit thing
    var reset = false
    var locationManager = CLLocationManager() // used to track user location
    //MARK - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") //Locks screen into landscape mode
        self.mapView.delegate = self //sets up MKMapViewDelegate
        if (CLLocationManager.locationServicesEnabled() == true){
            if(CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined){
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = 1.0 //makes user location accurate
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            if(turnLocations.count < 1){ //if start isn't there already, it creates it
                makeAnnotation(givenTitle: "Start", pointCoords: userCoords)
                turnLocations.append(userCoords)
                let region = MKCoordinateRegion(center: userCoords, latitudinalMeters: 100, longitudinalMeters: 100)
                mapView.setRegion(region, animated: true)
            }
        } else {
            makeAlert(message: "Please Turn on Locaiton Services", viewEnabled: false)
        }
    }
    //makes a basic alert with an ok button and presents it
    func makeAlert(message: String, viewEnabled: Bool){
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
        }
        let viewAction = UIAlertAction(title: "View Individual Distances", style: .default) { action in
            //call any needed functions here
            var msgString:String = ""
            for i in 0...self.distances.count - 1{
                var cDistance = self.distances[i] //currently added distance
                cDistance /= 1609.34 //<- converts to miles
                cDistance = Double(round(100 * cDistance) / 100) //rounds it to 2 decimals
                msgString = "\(msgString) \n Route \(i + 1): \(cDistance) Miles"
            }
            self.makeAlert(message: msgString, viewEnabled: false)
        }
        alertMessage.addAction(okayAction)
        if(viewEnabled){ //if not already viewing individual distances
            alertMessage.addAction(viewAction)
        }
        present(alertMessage, animated: true)
    }
    //make sannotation with given coordinates and title (target + guess)
    func makeAnnotation(givenTitle: String, pointCoords: (CLLocationCoordinate2D)){
        let annotation = MKPointAnnotation()
        annotation.title = givenTitle
        annotation.coordinate = pointCoords
        annotations.append(annotation)
        mapView.addAnnotation(annotation)
    }
    //removes all annotations and overlays on the map
    func removeAnnotations(){
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
    }
    func removeOverlays(){
        for overlay in mapView.overlays{
            mapView.removeOverlay(overlay)
        }
    }
    //creates a polyline with the given coords
    func makePolyline(turnLocations: [CLLocationCoordinate2D]){
        let polyline = MKPolyline(coordinates: turnLocations, count: turnLocations.count) //makes polyLine w/ coords given
        mapView.addOverlay(polyline)
    }
    //MARK - mapView Funcs
    //overrides overlay rendering functions
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //sets rendering properties for polyline
        if(overlay is MKPolyline){
            let polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor(ciColor: .red)
            polylineRender.lineWidth = 5
            return polylineRender
        }
        return MKPolylineRenderer()//stops the render if not polyline
    }
    //called when user location is updated
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //sets user location
        userCoords = mapView.userLocation.coordinate
        if(turnLocations.count < 1){ //if start isn't there already
            self.mapView.showAnnotations(mapView.annotations, animated: true) //zooms in to show all annotations
        }
    }
    //MARK - LocationManager funcs
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        makeAlert(message: "Can't get your current location", viewEnabled: false)
    }
    //calculates distance between current points and adds it up
    func calcDistance(){
        distance = 0
        distances = []
        for i in 0...(annotations.count - 2){ //adds distance between one location except last point
            let cDistance = CLLocation(latitude: CLLocationDegrees(exactly: turnLocations[i].latitude)!, longitude: CLLocationDegrees(exactly: turnLocations[i].longitude)!).distance(from: CLLocation(latitude: CLLocationDegrees(exactly: turnLocations[i+1].latitude)!, longitude: CLLocationDegrees(exactly: turnLocations[i+1].longitude)!)) //cDistance = current
            distance += cDistance
            distances.append(cDistance)
        }
    }
    //Detects Tap (Beggining) TO ADD: check if touching "click Sprite"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let tapLocation = touch.location(in: mapView)
        if (phase == 0) { //if set start
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "Turn\(annotations.count)", pointCoords: coords)
            turnLocations.append(coords)
        } else if (phase == 1) { //add turns here + redraw polyline
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "End", pointCoords: coords)
            turnLocations.append(coords)
            //create polyline here
            makePolyline(turnLocations: turnLocations)
            mapView.showAnnotations(mapView.annotations, animated: true) //zooms in to show all annotations
            calcDistance()
            distance /= 1609.34 //<- converts to miles
            distance = Double(round(100 * distance) / 100) //rounds it to 2 decimals
            makeAlert(message: "Distance of route: \(distance) Miles", viewEnabled: true)
            phase = 2
            reset = true
        } else {
            print("Extra Tap") //just so nothing else is called when user taps while scrolling around map
        }
    }
    //resets start and end of map
    @IBAction func resetTapped(_ sender: Any) {
        if(reset){ //if actually resetting
            removeAnnotations()
            removeOverlays()
            phase = 0
            turnLocations = []
            annotations = []
            reset = false
            if(turnLocations.count < 1){ //if start isn't there already, it creates it
                makeAnnotation(givenTitle: "Start", pointCoords: userCoords)
                turnLocations.append(userCoords)
                let region = MKCoordinateRegion(center: userCoords, latitudinalMeters: 100, longitudinalMeters: 100)
                mapView.setRegion(region, animated: true)
            }
            resetBtn.setTitle("Confirm Turns", for: .normal)
        } else if (annotations.count >= 1){ //if confirming start + turns are done
            phase = 1
            resetBtn.setTitle("Reset Route", for: .normal)
        } else {
            makeAlert(message: "Must Create A Starting Point", viewEnabled: false)
        }
    }
    //undo button tapped
    @IBAction func undoTapped(_ sender: Any) {
        if(!reset && annotations.count > 1) { //checks if there are any annotations then removes last added one from map + if route isn't ended, except starting annotation (as that is user location)
            mapView.removeAnnotation(annotations[annotations.count - 1])
            annotations.remove(at: annotations.count - 1)
            turnLocations.remove(at: turnLocations.count - 1)
            reset = false
            resetBtn.setTitle("Confirm Turns", for: .normal)
        } else if (reset && annotations.count > 1){ //removes ending + polyline if at ending
            mapView.removeAnnotation(annotations[annotations.count - 1])
            annotations.remove(at: annotations.count - 1)
            turnLocations.remove(at: turnLocations.count - 1)
            phase = 0
            removeOverlays()
            distances = []
            reset = false
            resetBtn.setTitle("Confirm Turns", for: .normal)
        } else {
            makeAlert(message: "Nothing Left to Undo!", viewEnabled:  false)
        }
    }
}
