//
//  ContentView.swift
//  map
//
//  Created by JiYoon Kang on 2/25/24.
//
import MapKit
import SwiftUI
import UIKit
import CoreLocationUI
import Foundation
import CoreLocation
extension CLLocationCoordinate2D {
    static let BMCBlueBusStop = CLLocationCoordinate2D(latitude: 40.026527, longitude: -75.312359)
    static let HCBlueBusStop = CLLocationCoordinate2D(latitude: 40.010283, longitude: -75.308985)
}
//struct schedule{
//    let hours: Int
//    let mins: Int
//}
let bmcbustimeMW: Dictionary<Int,[Int]>=[
    7: [30],
    8: [15,45],
    9: [10,30],
    10: [5,15,35,55],
    11: [5,35],
    12: [10,30],
    13: [10,30],
    14: [0,5,45],
    15: [10],
    16: [0,5,20],
    17: [10,50],
    18: [20],
    19: [15],
    20: [0,35],
    21: [5,35],
    22: [15,55],
    23: [45],
    24: [30]
]

let bmcbustimeTTH: Dictionary<Int,[Int]>=[
    7: [20,55],
    8: [15,50],
    9: [10,40,50],
    10: [35,55],
    11: [20,25],
    12: [20,40,50],
    13: [10,55],
    14: [10,20],
    15: [10,40],
    16: [5,20],
    17: [10,45],
    18: [20],
    19: [10],
    20: [0,35],
    21: [5,35],
    22: [15,55],
    23: [45],
    24: [30]
]

let bmcbustimeF: Dictionary<Int,[Int]>=[
    7: [35],
    8: [15,45],
    9: [10,30],
    10: [05,15,35,55],
    11: [5,35],
    12: [10],
    13: [10],
    14: [5,35],
    15: [10,45],
    16: [20],
    17: [10,50],
    18: [20],
    19: [0],
    20: [0,35],
    21: [5,35],
    22: [5,55],
    23: [25],
    24: [25],
    1:[15],
    2: [0]
]

let bmcbustimeSat: Dictionary<Int,[Int]>=[
    17: [00,30],
    18: [00,30],
    19: [00],
    20: [00],
    21: [00,30],
    22: [00,30],
    23: [00],
    24: [00,30],
    1:[00,30],
    2: [15]
]

let bmcbustimeSun: Dictionary<Int,[Int]>=[
    9: [30],
    10: [15],
    11: [30],
    12: [30],
    13: [30],
    14: [30],
    15: [30],
    16: [15],
    17: [0,30],
    18: [0,30],
    19: [0,30],
    20: [0],
    21: [0],
    22: [0],
    23: [0],
    24: [0]
]

let hcbustimeMW: Dictionary<Int,[Int]>=[
    7: [50],
    8: [50],
    9: [15,40,45],
    10: [20,30,50],
    11: [15,30,50],
    12: [40],
    13: [0,45,50],
    14: [20,45],
    15: [20,50],
    16: [10,20,35],
    17: [25],
    18: [5,50],
    19: [30],
    20: [15,50],
    21: [20],
    22: [5,30],
    23: [10],
    24: [0,45]
]

let hcbustimeTTH: Dictionary<Int,[Int]>=[
    7: [40],
    8: [10,35],
    9: [15,35],
    10: [10,20],
    11: [5,10,40],
    12: [10,35],
    13: [0,20,45],
    14: [10,40],
    15: [10,50],
    16: [5,20,45],
    17: [25,55],
    18: [25],
    19: [00,40],
    20: [20,55],
    21: [40],
    22: [30],
    23: [10],
    24: [0,45]
]

let hcbustimeF: Dictionary<Int,[Int]>=[
    7: [50],
    8: [50],
    9: [15,40,45],
    10: [20,35,50],
    11: [15,30,50],
    12: [40],
    13: [45],
    14: [20,50],
    15: [30],
    16: [5,35],
    17: [30],
    18: [5,50],
    19: [30],
    20: [15,50],
    21: [20,50],
    22: [20],
    23: [10],
    24: [0,45],
    1:[45],
    2: [40]
]

let hcbustimeSat: Dictionary<Int,[Int]>=[
    17: [15,45],
    18: [15,45],
    19: [30],
    20: [30],
    21: [15,45],
    22: [15,45],
    23: [15],
    24: [15,45],
    1:[15,45],
    2: [45]
]

let hcbustimeSun: Dictionary<Int,[Int]>=[
    9: [45],
    10: [45],
    11: [45],
    12: [45],
    13: [45],
    14: [45],
    15: [45],
    16: [30],
    17: [15,45],
    18: [15,45],
    19: [15,45],
    20: [15],
    21: [15],
    22: [15],
    23: [15],
    24: [15]
]

private let places = [
        //2.
        PointOfInterest(name: "BMC_Bluebus", latitude: 40.01355, longitude:  -75.18442),
        PointOfInterest(name: "HC_Bluebus", latitude: 40.00368, longitude: -75.18326)
]

func gethour()-> Int{
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return hour
}

func getmin()-> Int{
    let date = Date()
    let calendar = Calendar.current
    let min = calendar.component(.minute, from: date)
    return min
}

func getweekday() ->String{
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayInWeek = dateFormatter.string(from: date)
    return dayInWeek
}

func upcomingSchBM(hour: Int,week: String, min: Int)-> (upcomhr: Int, upcommin: Int) {
    var listMins: [Int]
    var diff = 60
    var resulthr = hour
    var resultmin = -1
    switch week{
    case "Monday","Wednesday":
        listMins = bmcbustimeMW[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = bmcbustimeMW[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Tuesday","Thursday":
        listMins = bmcbustimeTTH[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = bmcbustimeTTH[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Friday":
        listMins = bmcbustimeF[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = bmcbustimeF[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Saturday":
        listMins = bmcbustimeSat[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = bmcbustimeSat[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Sunday":
        listMins = bmcbustimeSun[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = bmcbustimeSun[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    default:
        return (upcomhr: resulthr, upcommin: resultmin)
    }
}
func upcomingSchHC(hour: Int,week: String, min: Int)-> (upcomhr: Int, upcommin: Int) {
    var listMins: [Int]
    var diff = 60
    var resulthr = hour
    var resultmin = -1
    switch week{
    case "Monday","Wednesday":
        listMins = hcbustimeMW[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = hcbustimeMW[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Tuesday","Thursday":
        listMins = hcbustimeTTH[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = hcbustimeTTH[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Friday":
        listMins = hcbustimeF[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = hcbustimeF[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Saturday":
        listMins = hcbustimeSat[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = hcbustimeSat[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    case "Sunday":
        listMins = hcbustimeSun[hour,default: [-1]]
        for i in listMins{
            if((min<=i)&&(min-i)<diff){
                diff = (min-i)
                resultmin = i
            }
        }
        if (resultmin == -1){
            listMins = hcbustimeSun[(hour+1),default: [-1]]
            resulthr += 1
            for i in listMins{
                if(((i+60)-min)<diff){
                    diff = (i+60)-min
                    resultmin = i
                }
            }
        }
        return (upcomhr: resulthr, upcommin: resultmin)
    default:
        return (upcomhr: resulthr, upcommin: resultmin)
    }
}
struct ContentView: View {

    let locationManager = CLLocationManager()
    @State var BrynMawr = MKCoordinateRegion(
        center:.init(
            latitude: 40.0286808,
            longitude: -75.3154550926182),
        span: .init(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )
    @State var Haverford = MKCoordinateRegion(
        center:.init(
            latitude: 40.0079,
            longitude: -75.3062),
        span: .init(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )
    @State var newBrynMawr = MapCameraPosition.region(MKCoordinateRegion(
        center:.init(
            latitude: 40.0286808,
            longitude: -75.3154550926182),
        span: .init(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    )
    @State var newHaverford = MapCameraPosition.region(MKCoordinateRegion(
        center:.init(
            latitude: 40.0079,
            longitude: -75.3062),
        span: .init(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    )
    var body: some View {
        
        @StateObject var locationDataManager = LocationDataManager()
        
        let latitude:Double = Double(self.locationManager.location?.coordinate.latitude ?? 0)
        let longitude:Double = Double(self.locationManager.location?.coordinate.longitude ?? 0)
        
        switch locationDataManager.locationManager.authorizationStatus   {
        case .authorizedWhenInUse, .authorizedAlways:
            if 40.023188 < latitude && latitude < 40.030195 &&
                -75.320219 < longitude && longitude < -75.309426 {
                Map(position: $newBrynMawr){
                    Marker("BMC_Bluebus", coordinate: .BMCBlueBusStop).annotationTitles(.visible)
                    UserAnnotation()
                }.tint(.blue)
//                Map(coordinateRegion: $BrynMawr, showsUserLocation: true, userTrackingMode: .constant(.follow)
////                    , annotationItems: places
//                )
////                    { place in MapMarker(coordinate: place.coordinate)}
//                    .edgesIgnoringSafeArea(.all)
//                    .onAppear {
//                        locationManager.requestWhenInUseAuthorization()
//                    }
            }
            else if 40.003197 < latitude && latitude < 40.01367 &&
                -75.313708 < longitude && longitude < -75.299844{
                Map(position: $newHaverford){
                    Marker("HC_Bluebus", coordinate: .HCBlueBusStop).annotationTitles(.visible)
                    UserAnnotation()
                }.tint(.blue)
//            Map(coordinateRegion: $Haverford,showsUserLocation: true, userTrackingMode: .constant(.follow)).edgesIgnoringSafeArea(.all)
//                    .onAppear {
//                        locationManager.requestWhenInUseAuthorization()
//                    } 
            }else{
                Text("Seems your not in BMC/HC campus").font(
                    .custom("AmericanTypewriter", fixedSize: 20)
                    .weight(.heavy)
                )
            }
        case .restricted, .denied:
            Text("Current location data was restricted or denied.").font(
                .custom("AmericanTypewriter", fixedSize: 20)
                .weight(.heavy)
            )
            
        case .notDetermined:
            Text("Current location data was not Determined.").font(
                .custom("AmericanTypewriter", fixedSize: 20)
                .weight(.heavy)
            )
//            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            ProgressView()
        }
        VStack {
            
            switch locationDataManager.locationManager.authorizationStatus {
                
            case .authorizedWhenInUse:  // Location services are available.
                // Insert code here of what should happen when Location services are authorized
//                Text("Your current location is:")
//                Text("Latitude: \(latitude)")
//                Text("Longitude: \(longitude)")
                var hr:Int = gethour()
                var min:Int = getmin()
                var week:String = getweekday()
                Text("Current time: \(gethour()) hr \(getmin()) min. Week: \(getweekday())").font(
                    .custom("AmericanTypewriter", fixedSize: 18)
                    .weight(.semibold)
                )
                if 40.023188 < latitude && latitude < 40.030195 &&
                    -75.320219 < longitude && longitude < -75.309426 {
                    //BMC
                    var scheduleBM = upcomingSchBM(hour: hr,week:week,min:min)
                    let userLoc = CLLocation(latitude: latitude, longitude: longitude)
                    let BMCBusStop = CLLocation(latitude: 40.026527, longitude: -75.312359)
                    var dis = BMCBusStop.distance(from: userLoc)
                    var estimeMin = ceil((dis/(1.4))/(60))
//                    Text("distance: \(dis)")
                    Text("Estimated travel timeMin: \(Int(estimeMin))mins").font(
                        .custom("AmericanTypewriter", fixedSize: 20)
                        .weight(.semibold)
                    )
                    Text("upcoming schedule: \(scheduleBM.upcomhr)hr \(scheduleBM.upcommin) min").font(
                        .custom("AmericanTypewriter", fixedSize: 20)
                        .weight(.semibold)
                    )
                }else if 40.003197 < latitude && latitude < 40.01367 &&
                            -75.313708 < longitude && longitude < -75.299844{
                    //HC
                    var scheduleHC = upcomingSchHC(hour: hr,week:week,min:min)
                    let userLoc = CLLocation(latitude: latitude, longitude: longitude)
                    let HCBusStop = CLLocation(latitude: 40.010283, longitude: -75.308985)
                    var dis = HCBusStop.distance(from: userLoc)
                    var estimeMin = ceil((dis/(1.4))/(60))
//                    Text("distance: \(dis)")
                    Text("Estimated travel timeMin:: \(Int(estimeMin))mins").font(
                        .custom("AmericanTypewriter", fixedSize: 20)
                        .weight(.semibold)
                    )
                    Text("upcoming schedule: \(scheduleHC.upcomhr)hr \(scheduleHC.upcommin) min").font(
                        .custom("AmericanTypewriter", fixedSize: 20)
                        .weight(.semibold)
                    )
                }
                
            case .restricted, .denied:  // Location services currently unavailable.
                // Insert code here of what should happen when Location services are NOT authorized
                Text("Current location data was restricted or denied.").font(
                    .custom("AmericanTypewriter", fixedSize: 20)
                    .weight(.heavy)
                )
            case .notDetermined:// Authorization not determined yet.
                Text("Finding your location...").font(
                    .custom("AmericanTypewriter", fixedSize: 20)
                    .weight(.heavy)
                )
                ProgressView()
            default:
                ProgressView()
            }
        }
    }
}
#Preview {
    ContentView()
}
class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
}



