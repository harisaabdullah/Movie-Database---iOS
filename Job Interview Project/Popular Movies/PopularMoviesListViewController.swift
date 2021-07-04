//
//  PopularMoviesListViewController.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 6/30/21.
//

import UIKit

class PopularMoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = popularMoviesViewModel()
    var movieListCount = 0
    var movieLists: [Result]?
    var pagination: Bool!
    var previousPageLoaded: Bool!
    
    //MARK:- ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.popularMovies(api_key: "6c5e11989e97410174f64b4c2d53b471", page: "10")
       
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Private Methods
    /// This function is creating a loader that will be shown at the bottom and top of table when pagination is taking place
    /// - Returns: loader
    func creatSpinner() -> UIView {
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.center = tableFooterView.center
        tableFooterView.addSubview(spinner)
        return tableFooterView
    }
    
    /// This function is creating an alert that will shown to user before and after pagination
    /// - Parameters:
    ///   - message: Contains the message to be displayed on alert
    ///   - type: What type of alert to be shown
    ///   - page: Page the user is requesting
    func alert(message: String, type: String, page: String){
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)

        if type == "Simple"{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        else{
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.viewModel.popularMovies(api_key: "6c5e11989e97410174f64b4c2d53b471", page: page)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                self.tableView.tableFooterView = nil
                self.tableView.tableHeaderView = nil
            }))
        }
   

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

// MARK: Extensions
extension PopularMoviesListViewController: popularMoviesViewModelDelegate{
    
    /// This delegate method gives us the response of popularMovies API
    /// - Parameters:
    ///   - message: Contains the message returned from the server incase of failure
    ///   - data: Contains response of popularMovies API
    ///   - isSuccessful: Flag for success and failure of popularMovies API response
    func didRecievePopularMoviesAPIResponse(message: String, data: popularMoviesModel?, isSuccessful: Bool) {
        self.tableView.tableFooterView = nil
        self.tableView.tableHeaderView = nil
        if isSuccessful{
            if self.movieLists == nil{
                self.movieListCount = data?.results?.count ?? 0
                self.movieLists = data?.results
                tableView.reloadData()
            }
            else{
                
                if self.previousPageLoaded == true{
                    var newList = data?.results
                    newList?.append(contentsOf: self.movieLists!)
                    self.movieLists = newList
                    tableView.reloadData()
                }
                else{
                    self.movieLists?.append(contentsOf: (data?.results)!)
                    self.movieListCount = self.movieLists?.count ?? 0
                    self.pagination = true
                    tableView.reloadData()
                }
            }
        }
    }
}

extension PopularMoviesListViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell") as! PopularMovieTableViewCell
        let imageUrl = "https://image.tmdb.org/t/p/w300\(self.movieLists?[indexPath.row].posterPath ?? "")"
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        cell.popularMovieImageView.image = UIImage(data: data ?? Data())
        cell.label.text = self.movieLists?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        viewController.id = self.movieLists?[indexPath.row].id ?? 0
        self.present(viewController, animated:true, completion:nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if self.pagination == true && position > (tableView.contentSize.height-tableView.frame.height) || self.previousPageLoaded == true && position == 0{
            alert(message: "No further records to display", type: "Simple", page: "")
        }
        else{
            if position > (tableView.contentSize.height-tableView.frame.height){
                self.tableView.tableFooterView = creatSpinner()
                
                alert(message: "Would you like to see records from next page?", type: "Selection", page: "11")
            }
            
            else if position == 0{
                self.tableView.tableHeaderView = creatSpinner()
                alert(message: "Would you like to see records from previous page?", type: "Selection", page: "9")
                self.previousPageLoaded = true
            }
            else {
                self.tableView.tableFooterView = nil
            }
        }
    }
}
