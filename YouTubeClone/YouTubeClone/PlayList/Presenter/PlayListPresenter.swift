//
//  PlayListPresenter.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/29/22.
//

import Foundation

protocol PlayListViewProtocol: AnyObject {
    func getPlayList(playList: [PlayListModel.Item])
}

class PlayListPresenter {
    private weak var delegate: PlayListViewProtocol?
    private var provider: PlayListProviderProtocol
    
    init(delegate: PlayListViewProtocol, provider: PlayListProviderProtocol = PlayListProvider()) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = PlayListProviderMock()
        }
        #endif
    }
    
    @MainActor
    func getPlayList() async {
        do {
            let playList = try await provider.getPlayList(channelId: Constants.channelId).items
            delegate?.getPlayList(playList: playList)
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
}
