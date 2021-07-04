//
//  movieDetailViewModel.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/1/21.
//

import Foundation
import UIKit

protocol movieDetailViewModelDelegate {
    
    /**
     * Use this delegate method to pass values to the respective view controller where movie detail API is to be called.
     *
     * - Parameters:
     *   - message: Contains the message returned from the server
     *   - data: Contains data returned in reponse of movie detail API
     *   - isSuccessful: Flag for success and failure of movie detail API response
     */
    func didRecieveMovieDetailAPIResponse(message: String, data: movieDetailModel?, isSuccessful: Bool)
}
class movieDetailViewModel{
    
    var delegate: movieDetailViewModelDelegate?
    var apiManager = APIManager.shared()
    
    func movieDetail(api_key: String, language: String, movie_id: String){
        apiManager.processGetMovieDetail(api_key: api_key, movie_id: movie_id, language: language, completion: {[weak self] (isSuccessful, errorMessage, results) in
            
            if let mSelf = self {
                
                if isSuccessful {
                        
                        mSelf.delegate?.didRecieveMovieDetailAPIResponse(message: "",  data: results, isSuccessful: isSuccessful)
                }
                else {
                    
                    mSelf.delegate?.didRecieveMovieDetailAPIResponse(message: errorMessage ?? "We are unable to process your request. Please try again.", data: nil, isSuccessful: false)
                }
            }
        })
    }
}
