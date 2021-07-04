//
//  MovieDetailViewController.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 6/30/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var popularMovieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    var viewModel = movieDetailViewModel()
    var viewModelVideos = videoViewModel()
    var id = 0
    var genres: [Genre]?
    var movieDetail: movieDetailModel?
    
    //MARK:- ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModelVideos.delegate = self
        self.viewModel.movieDetail(api_key: "6c5e11989e97410174f64b4c2d53b471", language: "en-US", movie_id: String(self.id))
    }
    //MARK:- Action Methods
    @IBAction func watchTrailerBtnClicked(_ sender: Any) {
        self.viewModelVideos.movieDetail(api_key: "6c5e11989e97410174f64b4c2d53b471", language: "en-US", movie_id: String(self.id))
    }
    //MARK:- Private Methods
    
    /// This function is populating the UI with the data returned from the movieDetail API
    /// - Parameters:
    ///   - movieDetail: Contains the data returned from the movieDetail API
    func setupUI(movieDetail: movieDetailModel){
        let imageUrl = "https://image.tmdb.org/t/p/w300\(movieDetail.backdropPath ?? "")"
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        self.popularMovieImageView.image = UIImage(data: data!)
        self.dateLabel.text = movieDetail.releaseDate
        self.movieTitleLabel.text = movieDetail.title
        self.overviewLabel.text = movieDetail.overview
        
    }
    /// This function is navigating user to Video Player after the success of videos API
    /// - Parameters:
    ///   - videoId: Contains the videoId returned by the videos API
    func watchVideo(videoId: String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        //viewController.id = self.movieList?.results?[indexPath.row].id ?? 0
        viewController.youtubeVideoId = videoId
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated:true, completion:nil)
    }
    
    /// This function is creating an alert that will shown to user when videos API returns an empty response.
    func alert(){
        let alert = UIAlertController(title: "Error!", message: "Sorry! Trailer is currently unavailable.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
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
//MARK:- Extensions
extension MovieDetailViewController: movieDetailViewModelDelegate{
    
    /// This delegate method gives us the response of movieDetail API
    /// - Parameters:
    ///   - message: Contains the message returned from the server incase of failure
    ///   - data: Contains response of movieDetail API
    ///   - isSuccessful: Flag for success and failure of popularMovies API response
    func didRecieveMovieDetailAPIResponse(message: String, data: movieDetailModel?, isSuccessful: Bool) {
        if isSuccessful{
            setupUI(movieDetail: data!)
        }
    }
}

extension MovieDetailViewController: videoViewModelDelegate{
    
    /// This delegate method gives us the response of video API
    /// - Parameters:
    ///   - message: Contains the message returned from the server incase of failure
    ///   - data: Contains response of video API
    ///   - isSuccessful: Flag for success and failure of video API response
    func didRecieveGetVideoAPIResponse(message: String, data: videoModel?, isSuccessful: Bool) {
        if isSuccessful{
            if data?.results?.count == 0{
                alert()
            }
            else{
                watchVideo(videoId: data?.results?[0].key ?? "")
            }
        }
    }
}
