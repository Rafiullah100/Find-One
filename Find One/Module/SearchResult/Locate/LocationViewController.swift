//
//  LocationViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit
import GoogleMaps
import CoreLocation
class LocationViewController: BaseViewController {

    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var instituteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    var viewModel = DetailViewModel()
    var locationDetail: LocationResult?
    var id: Int?
    private var locationManager: CLLocationManager?
    private let geocoder = CLGeocoder()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        view.bringSubviewToFront(bottomView)
        
        location.text = LocalizationKeys.schoolLocation.rawValue.localizeString()
        userLocation.text = LocalizationKeys.yourLocation.rawValue.localizeString()

        viewModel.locationDetails.bind { locationDetail in
            self.stopAnimation()
            self.locationDetail = locationDetail
            self.setupMap()
        }
        self.animateSpinner()
        viewModel.getLocationDetails(id: id ?? 0, detailType: .location)
    }

    private func setupMap(){
        nameLabel.text = locationDetail?.name
        instituteLabel.text = locationDetail?.address
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 9.0)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        guard let latitude = locationDetail?.latitude, let longitude = locationDetail?.longitude else { return }
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        marker.icon = UIImage(named: "marker")
    }
    
    private func getAddressFromCoordinates(location: CLLocation)
    {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                return
            }

            guard let placemark = placemarks?.first else {
                print("No placemark found")
                return
            }

            let address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
            print(address)
            self.userLabel.text = address
        }
    }
}


extension LocationViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 9.0, bearing: 0, viewingAngle: 0)
            getAddressFromCoordinates(location: location)
            locationManager?.stopUpdatingLocation()
        }
    }
}
