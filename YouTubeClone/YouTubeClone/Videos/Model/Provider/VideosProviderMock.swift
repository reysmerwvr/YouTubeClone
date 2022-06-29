//
//  VideosProviderMock.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/29/22.
//

import Foundation

class VideosProviderMock: VideosProviderProtocol {
    func getVideos(channelId: String) async throws -> VideoModel {
        guard let model = Helpers.parseJson(jsonName: "SearchVideos", model: VideoModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
}
