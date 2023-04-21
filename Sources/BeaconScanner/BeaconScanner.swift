//
//  ViewController.swift
//  WorkWithBeacon
//
//  Created by thanpd on 10/04/2023.
//

import UIKit
import CoreLocation

public protocol Ranging {
    func rangingBeacon(beacons: [CLBeacon])
}

public class BeaconScanner: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var uuid: [UUID]
    
    public var delegate: Ranging?
    
    public required init(uuid: [UUID]) {
        self.uuid = uuid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    public func startScanning() {
        if CLLocationManager.isRangingAvailable() {
            for i in uuid {
                let constraint = CLBeaconIdentityConstraint(uuid: i)
                locationManager.startRangingBeacons(satisfying: constraint)
            }
        }
    }
    
    public func stopScanning() {
        for i in uuid {
            let constraint = CLBeaconIdentityConstraint(uuid: i)
            locationManager.stopRangingBeacons(satisfying: constraint)
        }
    }

}

extension BeaconScanner: CLLocationManagerDelegate {
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var status: CLAuthorizationStatus?
        
        if #available(iOS 14.0, *) {
            status = self.locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }

        if(status == .denied || status == .restricted) {
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                let alert = UIAlertController(title: "Warning", message: "You must to enable position", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in
                    
                }))
                window.rootViewController?.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        if(status == .notDetermined) {
            self.locationManager.requestWhenInUseAuthorization()
            return
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        delegate?.rangingBeacon(beacons: beacons)
    }
    
}

