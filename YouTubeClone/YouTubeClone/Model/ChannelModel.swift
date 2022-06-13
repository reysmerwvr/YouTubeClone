//
//  ChannelModel.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/30/22.
//

import Foundation

// MARK: - ChannelModel
struct ChannelModel: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [Item]
    
    // MARK: - Item
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let statistics: Statistics
        let brandingSettings: BrandingSettings?
        
        // MARK: - BrandingSettings
        struct BrandingSettings: Codable {
            let channel: Channel
            let image: Image
            
            // MARK: - Channel
            struct Channel: Codable {
                let title, keywords: String
                let moderateComments: Bool?
                let unsubscribedTrailer, country: String?
            }
            
            // MARK: - Image
            struct Image: Codable {
                let bannerExternalURL: String

                enum CodingKeys: String, CodingKey {
                    case bannerExternalURL = "bannerExternalUrl"
                }
            }
        }
        
        // MARK: - Snippet
        struct Snippet: Codable {
            let title, snippetDescription, customURL: String
            let publishedAt: String
            let thumbnails: Thumbnails
            let localized: Localized
            let country: String

            enum CodingKeys: String, CodingKey {
                case title
                case snippetDescription = "description"
                case customURL = "customUrl"
                case publishedAt, thumbnails, localized, country
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

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high
                }
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width, height: Int
                }
            }
        }
        
        // MARK: - Statistics
        struct Statistics: Codable {
            let viewCount, subscriberCount: String
            let hiddenSubscriberCount: Bool
            let videoCount: String
        }
    }
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
}
