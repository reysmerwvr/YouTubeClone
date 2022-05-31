//
//  HomePresenter.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/30/22.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [[Any]])
}

class HomePresenter {
    var provider: HomeProviderProtocol
    weak var delegate: HomeViewProtocol?
    private var objectList: [[Any]] = []
    
    init(delegate: HomeViewProtocol, provider: HomeProvider = HomeProvider()) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = HomeProviderMock()
        }
        #endif
    }
    
    @MainActor
    func getHomeObjects() async {
        objectList.removeAll()
        
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlayList(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchQuery: "", channelId: Constants.channelId).items
        
        do {
            let (channelResponse, playlistResponse, videosResponse) = await (try channel, try playlist, try videos)
            objectList.append(channelResponse) // 0
            if let playlistId = playlistResponse.first?.id, let playlistItems = await getPlayListItems(playlistId: playlistId) {
                objectList.append(playlistItems.items) // 1
            }
            objectList.append(videosResponse) // 2
            objectList.append(playlistResponse) // 3
            delegate?.getData(list: objectList)
        } catch {
            print(error)
        }
    }
    
    func getPlayListItems(playlistId: String) async -> PlayListItemModel? {
        do {
            return try await provider.getPlayListItems(playlistId: playlistId)
        } catch {
            print(error)
            return nil
        }
    }
}
