//
//  HomeProvider.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/30/22.
//

import Foundation

protocol HomeProviderProtocol {
    func getVideos(searchQuery: String, channelId: String) async throws -> VideoModel
    func getChannel(channelId: String) async throws -> ChannelModel
    func getPlayList(channelId: String) async throws -> PlayListModel
    func getPlayListItems(playlistId: String) async throws -> PlayListItemModel
}

class HomeProvider: HomeProviderProtocol {
    func getVideos(searchQuery: String, channelId: String) async throws -> VideoModel {
        var queryParams: [String: String] = ["part": "snippet", "type": "videos"]
        if !searchQuery.isEmpty {
            queryParams["channelId"] = channelId
        }
        if !searchQuery.isEmpty {
            queryParams["q"] = searchQuery
        }
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        do {
            return try await ServiceLayer.callService(requestModel, VideoModel.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    func getChannel(channelId: String) async throws -> ChannelModel {
        let queryParams: [String: String] = ["part": "snippet,statistics,brandingSettings", "id": channelId]
        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams)
        do {
            return try await ServiceLayer.callService(requestModel, ChannelModel.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    func getPlayList(channelId: String) async throws -> PlayListModel {
        let queryParams: [String: String] = ["part": "snippet,contentDetails", "channelId": channelId]
        let requestModel = RequestModel(endpoint: .playlist, queryItems: queryParams)
        do {
            return try await ServiceLayer.callService(requestModel, PlayListModel.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    func getPlayListItems(playlistId: String) async throws -> PlayListItemModel {
        let queryParams: [String: String] = ["part": "snippet,id,contentDetails", "playlistId": playlistId]
        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams)
        do {
            return try await ServiceLayer.callService(requestModel, PlayListItemModel.self)
        } catch {
            print(error)
            throw error
        }
    }
}
