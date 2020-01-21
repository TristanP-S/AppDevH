//
//  ViewController.swift
//  GlobalGuesserPS
//
//  Created by Tristan Pudell-Spatscheck on 1/7/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//
/*
NOTES/BUGS:
-None Atm
 */
import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {
    //MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resetButton: UIButton!
    //MARK - Variables
    override var shouldAutorotate: Bool { // Locks screen into landscape
        return false
    }
    var phase = 0 //phase 0 = start, 1 = end, 2 = viewing route
    var locations: [CLLocationCoordinate2D] = []
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
        }
        alertMessage.addAction(okayAction)
        present(alertMessage, animated: true)
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
    //creates a polyline with the given coords
    func makePolyline(locations: [CLLocationCoordinate2D]){
        let polyline = MKPolyline(coordinates: locations, count: locations.count) //makes polyLine w/ coords given
        mapView.addOverlay(polyline)
        print("polyline attempted, size: \(locations.count), coords: \(locations)")
    }
    //actually makes the polyline render
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //sets rendering properties for polyline
        if(overlay is MKPolyline){
            print("polyline draw attempted")
            let polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor(ciColor: .red)
            polylineRender.lineWidth = 5
            return polylineRender
        }
        return MKPolylineRenderer()//stops the render if not polyline
    }
    //Detects Tap (Beggining) TO ADD: check if touching "click Sprite"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let tapLocation = touch.location(in: mapView)
        if(phase == 0){ //if nothing set
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "Start", pointCoords: coords)
            locations.append(coords)
            phase = 1
        } else if (phase == 1){ //if set start
            let coords = mapView.convert(tapLocation,toCoordinateFrom: mapView)
            print("Tapped at lat: \(coords.latitude) long: \(coords.longitude)")
            makeAnnotation(givenTitle: "End", pointCoords: coords)
            locations.append(coords)
            phase = 2
            //create polyline here
            makePolyline(locations: locations)
        } else { //add turns here + redraw polyline
            
        }
    }
    //resets start and end of map
    @IBAction func resetTapped(_ sender: Any) {
        removeAnnotations()
        phase = 0
        locations = []
    }
}
