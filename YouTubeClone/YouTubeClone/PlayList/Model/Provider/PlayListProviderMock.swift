//
//  PlayListProviderMock.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/29/22.
//

import Foundation

class PlayListProviderMock: PlayListProviderProtocol {
    func getPlayList(channelId: String) async throws -> PlayListModel {
        guard let model = Helpers.parseJson(jsonName: "PlayList", model: PlayListModel.self) else {
            throw NetworkError.jsonDecoder
        }
        return model
    }
}
