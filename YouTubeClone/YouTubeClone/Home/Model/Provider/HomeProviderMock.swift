//
//  HomeProviderMock.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/31/22.
//

import Foundation

class HomeProviderMock: HomeProviderProtocol {
    func getVideos(searchQuery: String, channelId: String) async throws -> VideoModel {
        guard let model = Helpers.parseJson(jsonName: "SearchVideos", model: VideoModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getChannel(channelId: String) async throws -> ChannelModel {
        guard let model = Helpers.parseJson(jsonName: "Channel", model: ChannelModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlayList(channelId: String) async throws -> PlayListModel {
        guard let model = Helpers.parseJson(jsonName: "PlayList", model: PlayListModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlayListItems(playlistId: String) async throws -> PlayListItemModel {
        guard let model = Helpers.parseJson(jsonName: "PlayListItems", model: PlayListItemModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
}
