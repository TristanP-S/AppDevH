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
 */
import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {
    //MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    //MARK - Variables
    override var shouldAutorotate: Bool { // Locks screen into landscape
        return false
    }
    var phase: Int = 0 //phase 0 = start, 1 = turns, 2 = end, 3 = viewing
    var distance: Double = 0
    var locations: [CLLocationCoordinate2D] = []
    var annotations: [MKAnnotation] = [] //used because annotation.remove is bugged
    var distances: [Double] = [] //used for extra credit thing
    var reset = false
    var distView = false
    //MARK - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") //Locks screen into landscape mode
        self.mapView.delegate = self //sets up MKMapViewDelegate
    }
    //makes a basic alert with an ok button and presents it
    func makeAlert(message: String){
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
            self.distView = false
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
            self.distView = true
            self.makeAlert(message: msgString)
        }
        alertMessage.addAction(okayAction)
        if(!distView){ //if not already viewing individual distances
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
    func makePolyline(locations: [CLLocationCoordinate2D]){
        let polyline = MKPolyline(coordinates: locations, count: locations.count) //makes polyLine w/ coords given
        mapView.addOverlay(polyline)
    }
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
    //calculates distance between current points and adds it up
    func calcDistance(){
        distance = 0
        distances = []
        for i in 0...(annotations.count - 2){ //adds distance between one location except last point
            let cDistance = CLLocation(latitude: CLLocationDegrees(exactly: locations[i].latitude)!, longitude: CLLocationDegrees(exactly: locations[i].longitude)!).distance(from: CLLocation(latitude: CLLocationDegrees(exactly: locations[i+1].latitude)!, longitude: CLLocationDegrees(exactly: locations[i+1].longitude)!)) //cDistance = current
            distance += cDistance
            distances.append(cDistance)
        }
    }
    //Detects Tap (Beggining) TO ADD: check if touching "click Sprite"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let tapLocation = touch.location(in: mapView)
        if (annotations.count == 0) { //if nothing set (uses annotations.count so undo doesn't bug)
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "Start", pointCoords: coords)
            locations.append(coords)
            phase = 1
        } else if (phase == 1) { //if set start
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "Turn\(annotations.count)", pointCoords: coords)
            locations.append(coords)
        } else if (phase == 2) { //add turns here + redraw polyline
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "End", pointCoords: coords)
            locations.append(coords)
            //create polyline here
            makePolyline(locations: locations)
            mapView.showAnnotations(mapView.annotations, animated: true)
            calcDistance()
            distance /= 1609.34 //<- converts to miles
            distance = Double(round(100 * distance) / 100) //rounds it to 2 decimals
            makeAlert(message: "Distance of route: \(distance) Miles")
            phase = 3
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
            locations = []
            annotations = []
            reset = false
            resetBtn.setTitle("Confirm Turns", for: .normal)
        } else { //if confirming start + turns are done
            phase = 2
            resetBtn.setTitle("Reset Route", for: .normal)
        }
    }
    //undo button tapped
    @IBAction func undoTapped(_ sender: Any) {
        if(!reset && annotations.count > 0) { //checks if there are any annotations then removes last added one from map + if route isn't ended
            mapView.removeAnnotation(annotations[annotations.count - 1])
            annotations.remove(at: annotations.count - 1)
            locations.remove(at: locations.count - 1)
            reset = false
            resetBtn.setTitle("Confirm Turns", for: .normal)
        } else if (reset){ //removes ending + polyline
            mapView.removeAnnotation(annotations[annotations.count - 1])
            annotations.remove(at: annotations.count - 1)
            locations.remove(at: locations.count - 1)
            phase = 1
            removeOverlays()
            distances = []
            reset = false
            resetBtn.setTitle("Confirm Turns", for: .normal)
        } else {
            makeAlert(message: "Nothing left to undo!")
        }
    }
}
