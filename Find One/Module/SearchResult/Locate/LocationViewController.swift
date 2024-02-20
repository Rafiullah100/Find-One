//
//  LocationViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit
import GoogleMaps
class LocationViewController: BaseViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        setupMap()
        view.bringSubviewToFront(bottomView)
    }

    private func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 20.0)
        mapView.camera = camera
        let position = CLLocationCoordinate2D(latitude: 34.0151, longitude: 71.5249)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        marker.icon = UIImage(named: "marker")
    }
}
