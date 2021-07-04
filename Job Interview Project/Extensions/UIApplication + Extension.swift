//
//  UIApplication + Extension.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/1/21.
//

import Foundation
import UIKit

extension UIApplication{
    
    /// This function returns url components after getting host name from smile configuration
    /// - Parameter urlEndPoint: EndPoint of url
    /// - Returns: url components
    func getUrlComponents(urlEndPoint: String) -> URLComponents {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = urlEndPoint
        return urlComponents
    }

}
