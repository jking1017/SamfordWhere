
import UIKit
import MapKit
import CoreLocation



class SecondViewController : UIViewController, UISearchBarDelegate{
   
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearch.Request!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearch.Response!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
 
    @IBAction func centerLocationButton(sender: UIButton) {
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
       
    }
    
      @IBAction func searchButton(_ sender: Any)
        {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.delegate = self
            present(searchController, animated: true, completion: nil)
        }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    fileprivate let LocationManager: CLLocationManager = CLLocationManager()
    
   override func viewDidLoad() {
    super.viewDidLoad()
    
    
    mapView.showsUserLocation = true
    mapView.showsUserLocation = true
    mapView.delegate = self as? MKMapViewDelegate
    LocationManager.requestWhenInUseAuthorization()
    LocationManager.desiredAccuracy = kCLLocationAccuracyBest
    LocationManager.distanceFilter = kCLDistanceFilterNone
    LocationManager.startUpdatingLocation()
    //LocationManager.delegate = self as? CLLocationManagerDelegate
    
   //MARK: Instance methods
   func setRegionForLocation(
       location:CLLocationCoordinate2D,
       spanRadius:Double,
       animated:Bool)
   {
       let span = 3.0 * spanRadius
    let region = MKCoordinateRegion(center: location, latitudinalMeters: span, longitudinalMeters: span)
       mapView.setRegion(region, animated: animated)
       }
    
   
}
}

