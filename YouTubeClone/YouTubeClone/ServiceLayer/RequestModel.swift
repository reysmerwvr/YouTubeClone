//
//  RequestModel.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/30/22.
//

import Foundation

struct RequestModel {
    let endpoint: Endpoints
    var queryItems: [String:String]?
    let httpMethod: HttpMethod = .GET
    var baseUrl: URLBase = .youtube
    
    func getURL() -> String {
        return baseUrl.rawValue + endpoint.rawValue
    }
    
    enum HttpMethod: String {
        case GET
        case POST
    }
    
    enum Endpoints : String {
        case search = "/search"
        case channels = "/channels"
        case playlist = "/playlists"
        case playlistItems = "/playlistItems"
        case videos = "/videos"
        case empty = ""
    }
    
    enum URLBase : String {
        case youtube = "https://youtube.googleapis.com/youtube/v3"
    }
}
