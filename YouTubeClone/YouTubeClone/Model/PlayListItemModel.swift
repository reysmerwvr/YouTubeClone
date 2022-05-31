//
//  PlayListItemModel.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/30/22.
//

import Foundation

// MARK: - PlayListItemModel
struct PlayListItemModel: Codable {
    let kind, etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    // MARK: - Item
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        // MARK: - ContentDetails
        struct ContentDetails: Codable {
            let videoID: String
            let videoPublishedAt: String

            enum CodingKeys: String, CodingKey {
                case videoID = "videoId"
                case videoPublishedAt
            }
        }
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let publishedAt: String
            let channelID, title, snippetDescription: String
            let thumbnails: Thumbnails
            let channelTitle, playlistID: String
            let position: Int
            let resourceID: ResourceID
            let videoOwnerChannelTitle, videoOwnerChannelID: String

            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelID = "channelId"
                case title
                case snippetDescription = "description"
                case thumbnails, channelTitle
                case playlistID = "playlistId"
                case position
                case resourceID = "resourceId"
                case videoOwnerChannelTitle
                case videoOwnerChannelID = "videoOwnerChannelId"
            }
            
            // MARK: - ResourceID
            struct ResourceID: Codable {
                let kind, videoID: String

                enum CodingKeys: String, CodingKey {
                    case kind
                    case videoID = "videoId"
                }
            }
            
            // MARK: - Thumbnails
            struct Thumbnails: Codable {
                let thumbnailsDefault, medium, high: Default
                let standard, maxres: Default?

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high, standard, maxres
                }
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width, height: Int
                }
            }
        }
    }
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
}
