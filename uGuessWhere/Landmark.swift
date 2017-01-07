//
//  Landmarks.swift
//  iWasHere
//
//  Created by Eric Torigian on 11/6/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Firebase

class Landmark {
    //MARK: - private internal variables
    private var _latitude: Double
    private var _longitude: Double
    private var _altitude: Double
    private var _timestamp: Double
    private var _title: String
    private var _key: String!
    private var _ref: FIRDatabaseReference!
	
    //MARK: - getter/setters
    var latitude: Double {
        return _latitude
    }
    
    var longitude: Double {
        return _longitude
    }
    
    var altitude: Double {
        return _altitude
    }
    
    var timestamp: Double {
        return _timestamp
    }
    
    var title: String {
        return _title
    }
	
	var annotation: MKPointAnnotation {
		let location = CLLocationCoordinate2DMake(_latitude, _longitude)
		let annotation = MKPointAnnotation()
		annotation.coordinate = location
		annotation.title = _title
		return annotation
	}
    
    var formatLatitudeString: String {
        var latSeconds = Int(_latitude * 3600)
        let latDegrees = latSeconds / 3600
        latSeconds = abs(latSeconds % 3600)
        let latMinutes = latSeconds / 60
        latSeconds %= 60
        return String(format:"%d°%d'%d %@",
                      abs(latDegrees),
                      latMinutes,
                      latSeconds,
                      {return latDegrees >= 0 ? "N" : "S"}()
        )
    }
    
    var formatLongitudeString: String {
        var longSeconds = Int(_longitude * 3600)
        let longDegrees = longSeconds / 3600
        longSeconds = abs(longSeconds % 3600)
        let longMinutes = longSeconds / 60
        longSeconds %= 60
        return String(format:"%d°%d'%d%@",
                      abs(longDegrees),
                      longMinutes,
                      longSeconds,
                      {return longDegrees >= 0 ? "E" : "W"}() )
    }
    
    var formatedAltitudeString: String {
        return String(format: "%.02f feet", _altitude * 3.28084)
    }

    
    //MARK: - initializers
    init(_ location: CLLocation, title: String! = "Landmark") {
        self._altitude = location.altitude * 3.28084
        self._latitude = location.coordinate.latitude
        self._longitude = location.coordinate.longitude
        self._timestamp = location.timestamp.timeIntervalSince1970
        self._title = title
		
    }
    
    init(snapshot: FIRDataSnapshot) {
        self._latitude = (snapshot.value as? NSDictionary)?["latitude"] as! Double
        self._longitude = (snapshot.value as? NSDictionary)?["longitude"] as! Double
        self._altitude = (snapshot.value as? NSDictionary)?["altitude"] as! Double
        self._timestamp = (snapshot.value as? NSDictionary)?["timestamp"] as! Double
        self._title = (snapshot.value as? NSDictionary)?["title"] as! String
        self._key = snapshot.key
        self._ref = snapshot.ref
    }

    
}
