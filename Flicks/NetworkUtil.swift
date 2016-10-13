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
    
    static let now_playing_base_url = "https://api.themoviedb.org/3/movie/now_playing"
    
    static let poster_base_url = "https://image.tmdb.org/t/p/w342"
    
    static let api_key = "a51686bebf35b11a2483372c5d8eaab8"
    
    static var nowPlayingUrl: String {
        get {
            return "\(now_playing_base_url)?api_key=\(api_key)"
        }
    }
    
    static func getNowPlayingMovies(successHandler: @escaping (URLSessionDataTask, Any?) -> (),
                                    failureHandler: @escaping (URLSessionDataTask?, Error) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.get(nowPlayingUrl,
                    parameters: nil,
                    progress: nil,
                    success: { (task, responseObject) -> Void in
                        return successHandler(task, responseObject)
            }) { (task, error) -> Void in
                        return failureHandler(task, error)
        }
    }
    
    
    
    

}
