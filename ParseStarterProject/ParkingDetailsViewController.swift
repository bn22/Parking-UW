//
//  ParkingDetailsViewController.swift
//  ParkingUW
//
//  Created by iGuest on 12/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class ParkingDetailsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var GarageName: UILabel!
    @IBOutlet weak var openSpot: UILabel!
    @IBOutlet weak var totalSpot: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    var myRoute : MKRoute?
    var point1 = MKPointAnnotation()
    var point2 = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    var data = [PFObject]()
    var eventData = [PFObject]()
    var array = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(array)
        GarageName.text = array[0] as? String
        openSpot.text = array[2] as? String
        totalSpot.text = array[3] as? String
        rate.text = array[4] as? String
        address.text = array[5] as? String
        
        point1.coordinate = CLLocationCoordinate2DMake((array[6] as? Double)!, (array[7] as? Double)!)
        point1.title = array[0] as? String
        map.addAnnotation(point1)
        map.centerCoordinate = point1.coordinate
        map.setRegion(MKCoordinateRegionMake(point1.coordinate, MKCoordinateSpanMake(0.003, 0.003)), animated: true)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue : CLLocationCoordinate2D = manager.location!.coordinate
        point2.coordinate = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
    }

    @IBAction func navigate(sender: AnyObject) {
        var directionsRequest = MKDirectionsRequest()
        
        let markCurrent = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
        let markDestination = MKPlacemark(coordinate: CLLocationCoordinate2DMake((array[6] as? Double)!, (array[7] as? Double)!), addressDictionary: nil)
        
        let source = MKMapItem(placemark: markCurrent)
        source.name = "Current Location"
        directionsRequest.source = source
        let destination = MKMapItem(placemark: markDestination)
        destination.name = array[5] as? String
        directionsRequest.destination = destination
        directionsRequest.transportType = MKDirectionsTransportType.Automobile
        directionsRequest.requestsAlternateRoutes = true
        
        var directions = MKDirections(request: directionsRequest)
        directions.calculateDirectionsWithCompletionHandler{
            response, error in
            
            guard let response = response else {
                //handle the error here
                return
            }
            
            let launchOptions = [
                MKLaunchOptionsDirectionsModeKey:
                MKLaunchOptionsDirectionsModeDriving]
            
            MKMapItem.openMapsWithItems(
                [response.source, response.destination],
                launchOptions: launchOptions)
        }

    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        var renderLine = MKPolylineRenderer(polyline: (myRoute?.polyline)!)
        renderLine.strokeColor = UIColor.redColor()
        renderLine.lineWidth = 2
        return renderLine
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let view = segue.destinationViewController as! ParkingViewController
        view.data = self.data
        view.eventData = self.eventData
        
        
    }
    

}
