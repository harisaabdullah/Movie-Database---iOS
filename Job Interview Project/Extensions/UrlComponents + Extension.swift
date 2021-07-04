//
//  UrlComponents + Extension.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/1/21.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
    }
}
