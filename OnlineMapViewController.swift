import UIKit
import WebKit
class OnlineMapViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.samford.edu/campus-map/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
