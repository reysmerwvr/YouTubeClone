//
//  PlayListModel.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/26/22.
//

import Foundation

// MARK: - PlayListModel
struct PlayListModel: Codable {
    let kind, etag, nextPageToken: String
    let pageInfo: PageInfo
    let items: [Item]
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
    
    // MARK: - Item
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        // MARK: - ContentDetails
        struct ContentDetails: Codable {
            let itemCount: Int
        }
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let publishedAt: String
            let channelID, title, snippetDescription: String
            let thumbnails: Thumbnails
            let channelTitle: String
            let localized: Localized
            
            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelID = "channelId"
                case title
                case snippetDescription = "description"
                case thumbnails, channelTitle, localized
            }
            
            // MARK: - Localized
            struct Localized: Codable {
                let title, localizedDescription: String
                
                enum CodingKeys: String, CodingKey {
                    case title
                    case localizedDescription = "description"
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
}
