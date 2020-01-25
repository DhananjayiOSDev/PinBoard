//
//  PBPinsListModel.swift
//
//  Created by Dhananjay on 22/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation

enum DownloadState {
    case Downloading
    case Cancelled
    case Downloaded
}

class PBPinsListModel: Codable {

  enum CodingKeys: String, CodingKey {
    case categories
    case color
    case width
    case createdAt = "created_at"
    case id
    case height
    //case currentUserCollections = "current_user_collections"
    case user
    case likes
    case links
    case urls
    case likedByUser = "liked_by_user"
  }

  var categories: [PBCategories]?
  var color: String?
  var width: Int?
  var createdAt: String?
  var id: String?
  var height: Int?
    //var currentUserCollections: Any?
  var user: PBUser?
  var likes: Int?
  var links: PBLinks?
  var urls: PBUrls?
  var likedByUser: Bool?
    var downloadState:DownloadState = .Downloading 

  var categoriesStr: String {
    guard let categories = categories else { return "" }
    
    return categories
        .compactMap({ (category) -> String? in
            return category.title
        })
        .joined(separator: ", ")
   }
    
  init (categories: [PBCategories]?, color: String?, width: Int?, createdAt: String?, id: String?, height: Int?, currentUserCollections: Any?, user: PBUser?, likes: Int?, links: PBLinks?, urls: PBUrls?, likedByUser: Bool?) {
    self.categories = categories
    self.color = color
    self.width = width
    self.createdAt = createdAt
    self.id = id
    self.height = height
    //self.currentUserCollections = currentUserCollections
    self.user = user
    self.likes = likes
    self.links = links
    self.urls = urls
    self.likedByUser = likedByUser
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    categories = try container.decodeIfPresent([PBCategories].self, forKey: .categories)
    color = try container.decodeIfPresent(String.self, forKey: .color)
    width = try container.decodeIfPresent(Int.self, forKey: .width)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    height = try container.decodeIfPresent(Int.self, forKey: .height)
    //currentUserCollections = try container.decodeIfPresent([].self, forKey: .currentUserCollections)
    user = try container.decodeIfPresent(PBUser.self, forKey: .user)
    likes = try container.decodeIfPresent(Int.self, forKey: .likes)
    links = try container.decodeIfPresent(PBLinks.self, forKey: .links)
    urls = try container.decodeIfPresent(PBUrls.self, forKey: .urls)
    likedByUser = try container.decodeIfPresent(Bool.self, forKey: .likedByUser)
  }

}
