//
//  PlayListProvider.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/29/22.
//

import Foundation

protocol PlayListProviderProtocol: AnyObject {
    func getPlayList(channelId: String) async throws -> PlayListModel
}

class PlayListProvider: PlayListProviderProtocol {
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
}
