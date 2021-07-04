//
//  APIManager.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/1/21.
//

import Foundation
import Alamofire

final class APIManager{
    
    var httpHandler =  HttpHandler.sharedManager()
    
    private func initConfiguration() {
        httpHandler =  HttpHandler.sharedManager()
    }
    
    // MARK: Shared Instance
    private static var instance: APIManager!
    
    public static func shared() -> APIManager {
        if instance == nil {
            instance = APIManager()
        }
        instance.initConfiguration()
        return instance
        
    }
    
    //MARK:- APIS
    
    func processGetPopularMovies(api_key: String, page: String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : popularMoviesModel?) -> Void){
        
        httpHandler =  HttpHandler.sharedManager()
        
        let queryParams: [String: Any] = [
            "api_key":api_key,
            "page":page
        ]
        
        //let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)&page=\(page)"
        var urlComponents = UIApplication.shared.getUrlComponents(urlEndPoint: "/3/movie/popular")
        urlComponents.setQueryItems(with: queryParams)
        
        let reqParams: requestParameters = requestParameters(url: urlComponents.url?.absoluteString ?? "", method: .get, parameters: nil)
        print(urlComponents)
        print(urlComponents.url?.absoluteString ?? "")
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
            
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(popularMoviesModel.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
    }
    
    
    func processGetMovieDetail(api_key: String, movie_id: String, language: String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : movieDetailModel?) -> Void){
        
        httpHandler =  HttpHandler.sharedManager()
        
        let queryParams: [String: Any] = [
            "api_key":api_key,
            "language":language
        ]
        
        //let url = "https://api.themoviedb.org/3/movie/\(movie_id)?api_key=\(api_key)&language=\(language)"
        
        var urlComponents = UIApplication.shared.getUrlComponents(urlEndPoint: "/3/movie/\(movie_id)")
        urlComponents.setQueryItems(with: queryParams)
        
        let reqParams: requestParameters = requestParameters(url: urlComponents.url?.absoluteString ?? "", method: .get, parameters: nil)
        print(urlComponents.url?.absoluteString ?? "")
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
            
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(movieDetailModel.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
        
    }
    
    func processGetVideo(movie_id: String, api_key: String, language: String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : videoModel?) -> Void){
        httpHandler =  HttpHandler.sharedManager()
        
        let queryParams: [String: Any] = [
            "api_key":api_key,
            "language":language
        ]
        
        //let url = "https://api.themoviedb.org/3/movie/\(movie_id)?api_key=\(api_key)&language=\(language)"
        
        var urlComponents = UIApplication.shared.getUrlComponents(urlEndPoint: "/3/movie/\(movie_id)/videos")
        urlComponents.setQueryItems(with: queryParams)
        
        let reqParams: requestParameters = requestParameters(url: urlComponents.url?.absoluteString ?? "", method: .get, parameters: nil)
        print(urlComponents.url?.absoluteString ?? "")
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
            
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(videoModel.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
        
    }

}



