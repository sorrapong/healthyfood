//
//  MapViewController.swift
//  HealthyFood
//
//  Created by Sorrapong W on 12/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    private var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
          locationManager.requestLocation()
          
          mapView.isMyLocationEnabled = true
          mapView.settings.myLocationButton = true
        } else {
          locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
      let geocoder = GMSGeocoder()
      
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard let address = response?.firstResult(), let lines = address.lines else {
          return
        }        
        print(lines)
      }
    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
      mapView.clear()
      
      dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
        places.forEach {
          let marker = ShopMarker(place: $0)
          marker.map = self.mapView
        }
      }
    }
}

extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    guard status == .authorizedWhenInUse else {
      return
    }
    
    locationManager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    fetchNearbyPlaces(coordinate: location.coordinate)
    locationManager.stopUpdatingLocation()
  }
    
    func locationManager(
      _ manager: CLLocationManager,
      didFailWithError error: Error
    ) {
      print(error)
    }
}

extension MapViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    reverseGeocodeCoordinate(position.target)
  }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
      guard let placeMarker = marker as? ShopMarker else {
        return nil
      }
      guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
        return nil
      }
      
      infoView.nameLabel.text = placeMarker.place.name
      if let photo = placeMarker.place.photo {
        infoView.placePhoto.image = photo
      } else {
        infoView.placePhoto.image = UIImage(named: "generic")
      }
      
      return infoView
    }
    
}

