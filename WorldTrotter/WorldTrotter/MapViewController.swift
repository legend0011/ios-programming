//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by jack zhang on 2022/8/11.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        locationManager = CLLocationManager()
        
        mapView = MKMapView()
        mapView.pointOfInterestFilter = .excludingAll
        self.view = mapView
        
        let segmentedControl = addSegmentedControl()
        
        let pl = addPinOfInterestBelow(ui: segmentedControl)
        
        let _ = addPinOfInterestToggleBelow(ui: pl)
        
    }
    
    fileprivate func addSegmentedControl() -> UIView {
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString
        = NSLocalizedString("Satellite", comment: "Satellite map view")
        
        let segmentedControl
        = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        addConstrains(for: segmentedControl, top: view.safeAreaLayoutGuide.topAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor)
        
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        return segmentedControl
    }
    
    fileprivate func addPinOfInterestBelow(ui: UIView) -> UIView {
        let interestLabel = UILabel()
        interestLabel.text = "Interesting points"
        interestLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(interestLabel)
        addConstrains(for: interestLabel, top: ui.bottomAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor)
        return interestLabel
    }
    
    fileprivate func addPinOfInterestToggleBelow(ui: UIView) -> UIView {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toggle)
        addConstrains(for: toggle, top: ui.bottomAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor)
        
        toggle.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        return toggle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
        locationManager.requestWhenInUseAuthorization()
        
        print("requested location Auth!")
        mapView.pointOfInterestFilter = .includingAll
        let currentLocationCord = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: CLLocationDegrees(39.928889), longitude: CLLocationDegrees(116.588333))
        var span = MKCoordinateSpan()
        span.latitudeDelta = CLLocationDegrees(0.01)
        span.longitudeDelta = CLLocationDegrees(0.01)
        let region = MKCoordinateRegion.init(center: currentLocationCord, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func addConstrains(for uiview: UIView, top: NSLayoutAnchor<NSLayoutYAxisAnchor>, leading: NSLayoutAnchor<NSLayoutXAxisAnchor>, trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>) {
        let topConstraint = uiview.topAnchor.constraint(equalTo: top, constant: 8)
        
        let leadingConstraint = uiview.leadingAnchor.constraint(equalTo: leading)
        let trailingConstraint = uiview.trailingAnchor.constraint(equalTo: trailing)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .hybrid
            case 2:
                mapView.mapType = .satellite
            default:
                break
        }
    }
    
    @objc func toggleChanged(_ toggle: UISwitch) {
        if toggle.isOn {
            mapView.pointOfInterestFilter = .includingAll
        } else {
            mapView.pointOfInterestFilter = .excludingAll
        }
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        mapView.pointOfInterestFilter = .includingAll
        let region = MKCoordinateRegion.init(center: locationManager.location!.coordinate, span: MKCoordinateSpan())
        mapView.setRegion(region, animated: true)
    }
}

