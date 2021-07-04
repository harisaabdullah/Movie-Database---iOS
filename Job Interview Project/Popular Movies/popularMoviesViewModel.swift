//
//  popularMoviesViewModel.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/1/21.
//

import Foundation
import UIKit

protocol popularMoviesViewModelDelegate {
    
    /**
     * Use this delegate method to pass values to the respective view controller where popuplar movies API is to be called.
     *
     * - Parameters:
     *   - message: Contains the message returned from the server
     *   - data: Contains data returned in reponse of popuplar movies API
     *   - isSuccessful: Flag for success and failure of popuplar movies API response
     */
    func didRecievePopularMoviesAPIResponse(message: String, data: popularMoviesModel?, isSuccessful: Bool)
}
class popularMoviesViewModel{
    
    var delegate: popularMoviesViewModelDelegate?
    var apiManager = APIManager.shared()
    
    func popularMovies(api_key: String, page: String){
        apiManager.processGetPopularMovies(api_key: api_key, page: page, completion: {[weak self] (isSuccessful, errorMessage, results) in
            
            if let mSelf = self {
                
                if isSuccessful {
                        
                        mSelf.delegate?.didRecievePopularMoviesAPIResponse(message: "",  data: results, isSuccessful: isSuccessful)
                }
                else {
                    
                    mSelf.delegate?.didRecievePopularMoviesAPIResponse(message: errorMessage ?? "We are unable to process your request. Please try again.", data: nil, isSuccessful: false)
                }
            }
        })
    }
}
