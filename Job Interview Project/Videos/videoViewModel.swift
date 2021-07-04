//
//  videoViewModel.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/2/21.
//

import Foundation
import UIKit

protocol videoViewModelDelegate {
    
    /**
     * Use this delegate method to pass values to the respective view controller where get videos API is to be called.
     *
     * - Parameters:
     *   - message: Contains the message returned from the server
     *   - data: Contains data returned in reponse of get videos  API
     *   - isSuccessful: Flag for success and failure of get videos  API response
     */
    func didRecieveGetVideoAPIResponse(message: String, data: videoModel?, isSuccessful: Bool)
}
class videoViewModel{
    
    var delegate: videoViewModelDelegate?
    var apiManager = APIManager.shared()
    
    func movieDetail(api_key: String, language: String, movie_id: String){
        apiManager.processGetVideo(movie_id: movie_id, api_key: api_key, language: language, completion: {[weak self] (isSuccessful, errorMessage, results) in
            
            if let mSelf = self {
                
                if isSuccessful {
                        
                        mSelf.delegate?.didRecieveGetVideoAPIResponse(message: "",  data: results, isSuccessful: isSuccessful)
                }
                else {
                    
                    mSelf.delegate?.didRecieveGetVideoAPIResponse(message: errorMessage ?? "We are unable to process your request. Please try again.", data: nil, isSuccessful: false)
                }
            }
        })
    }
}
