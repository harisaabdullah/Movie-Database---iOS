//
//  VideoPlayerViewController.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 6/30/21.
//

import UIKit
import WebKit
import AVKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var youtubeVideoId = ""
    
    //MARK:- ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadYoutube(videoID: youtubeVideoId)
        // Do any additional setup after loading the view.
    }
    //MARK:- Action Methods
    @IBAction func doneClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Private Methods
    
    /// This function is creating the URL request to load embed youtube videos.
    /// - Parameters:
    ///   - videoId: Contains the videoId
    func loadYoutube(videoID:String) {
    guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
    return
    }
        self.webView.loadRequest(URLRequest(url: youtubeURL))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
