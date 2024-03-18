//
//  MapViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit
import GoogleMaps
class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var searchList: [SearchResult]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        guard searchList?.count ?? 0 > 0 else { return }
        setupMap()
    }

    private func setupMap(){
        
        let camera = GMSCameraPosition.camera(withLatitude: searchList?[0].latitude ?? 0.0, longitude: searchList?[0].longitude ?? 0.0, zoom: 6.0)
        mapView.camera = camera
        searchList?.forEach({ institute in
            let position = CLLocationCoordinate2D(latitude: institute.latitude ?? 0.0, longitude: institute.longitude ?? 0.0)
            let marker = GMSMarker(position: position)
            marker.map = mapView
            marker.icon = UIImage(named: "marker")
        })
    }
}
