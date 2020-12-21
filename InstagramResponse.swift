//
//  InstagramJSONDecoder.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/21.
//

import Foundation
struct InstagramResponse: Codable{
    let graphql: Graphql
    struct Graphql: Codable {
        let user: User
        struct User: Codable {
            let biography: String
            let profile_pic_url_hd: URL
            let full_name: String
            let edge_followed_by: Edge_followed_by
            struct Edge_followed_by:Codable {
                let count: Int
            }
            let edge_owner_to_timeline_media: Edge_owner_to_timeline_media
            struct Edge_owner_to_timeline_media: Codable {
                let count: Int
                let edges: [Edges]
                struct Edges: Codable {
                    var node: Node
                    struct Node: Codable {
                        let display_url: URL
                    }
                }
            }
            let edge_felix_video_timeline: Edge_felix_video_timeline
            struct Edge_felix_video_timeline: Codable {
                let edges: [Edges]
                struct Edges: Codable {
                    var node: Node
                    struct Node: Codable {
                        let display_url: URL
                        let video_url: URL
                    }
                }
            }
            let edge_follow: Edge_follow
            struct Edge_follow: Codable {
                let count: Int
            }
        }
    }
}
