//
//  WayFinderContainer.swift
//  Sjmo
//
//  Created by Interview on 5/14/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class WayFinderContainer: UIViewController,UIWebViewDelegate{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    var bridge:WebViewJavascriptBridge?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        // Do any additional setup after loading the view.
        
        // connecting to SJMO website
        let url = NSURL (string: "http://sjmo.222miles.com/");
        let requestObj = NSURLRequest(URL: url!);
        webView.backgroundColor = UIColor.clearColor()
        webView.opaque = false
        webView.loadRequest(requestObj);
        
        WebViewJavascriptBridge.enableLogging()
        self.bridge = WebViewJavascriptBridge(forWebView: self.webView, webViewDelegate: self, handler: {
            (id:AnyObject!, responseCallback:WVJBResponseCallback! ) in
            
            self.back()
        })
        
    
    }

    
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
}
