//
//  VideosProvider.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/29/22.
//

import Foundation

protocol VideosProviderProtocol: AnyObject {
    func getVideos(channelId: String) async throws -> VideoModel
}

class VideosProvider: VideosProviderProtocol {
    func getVideos(channelId: String) async throws -> VideoModel {
        let queryParams: [String: String] = ["part": "snippet", "type": "videos", "maxResults": "50"]
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        do {
            return try await ServiceLayer.callService(requestModel, VideoModel.self)
        } catch {
            print(error)
            throw error
        }
    }
}
