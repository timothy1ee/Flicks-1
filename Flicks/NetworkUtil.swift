//
//  NetworkUtil.swift
//  Flicks
//
//  Created by James Zhou on 10/12/16.
//  Copyright © 2016 James Zhou. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkUtil: NSObject {
    
    static let movies_base_url = "https://api.themoviedb.org/3/movie/"
    
    static let poster_base_url_low_res = "https://image.tmdb.org/t/p/w342"
    
    static let poster_base_url_high_res = "https://image.tmdb.org/t/p/w500"
    
    static let api_key = "a51686bebf35b11a2483372c5d8eaab8"
    
    static func getMovies(endpoint: String,
                          successHandler: @escaping (URLSessionDataTask, Any?) -> (),
                          failureHandler: @escaping (URLSessionDataTask?, Error) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.cachePolicy = .reloadIgnoringLocalCacheData
        
        let url = "\(movies_base_url)\(endpoint)?api_key=\(api_key)"
        
        manager.get(url,
                    parameters: nil,
                    progress: nil,
                    success: { (task, responseObject) -> Void in
                        return successHandler(task, responseObject)
            }) { (task, error) -> Void in
                        return failureHandler(task, error)
        }
    }
    
    
    
    

}
