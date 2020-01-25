//
//  PBCategories.swift
//
//  Created by Dhananjay on 22/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class PBCategories: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case links
    case title
    case photoCount = "photo_count"
  }

  var id: Int?
  var links: PBLinks?
  var title: String?
  var photoCount: Int?

  init (id: Int?, links: PBLinks?, title: String?, photoCount: Int?) {
    self.id = id
    self.links = links
    self.title = title
    self.photoCount = photoCount
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    links = try container.decodeIfPresent(PBLinks.self, forKey: .links)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    photoCount = try container.decodeIfPresent(Int.self, forKey: .photoCount)
  }

}
