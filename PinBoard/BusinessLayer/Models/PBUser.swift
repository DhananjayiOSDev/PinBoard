//
//  PBUser.swift
//
//  Created by Dhananjay on 22/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class PBUser: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case username
    case profileImage = "profile_image"
    case name
    case links
  }

  var id: String?
  var username: String?
  var profileImage: PBProfileImage?
  var name: String?
  var links: PBLinks?

  init (id: String?, username: String?, profileImage: PBProfileImage?, name: String?, links: PBLinks?) {
    self.id = id
    self.username = username
    self.profileImage = profileImage
    self.name = name
    self.links = links
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    profileImage = try container.decodeIfPresent(PBProfileImage.self, forKey: .profileImage)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    links = try container.decodeIfPresent(PBLinks.self, forKey: .links)
  }

}
