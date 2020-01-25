//
//  PBProfileImage.swift
//
//  Created by Dhananjay on 22/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class PBProfileImage: Codable {

  enum CodingKeys: String, CodingKey {
    case large
    case medium
    case small
  }

  var large: String?
  var medium: String?
  var small: String?

  init (large: String?, medium: String?, small: String?) {
    self.large = large
    self.medium = medium
    self.small = small
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    large = try container.decodeIfPresent(String.self, forKey: .large)
    medium = try container.decodeIfPresent(String.self, forKey: .medium)
    small = try container.decodeIfPresent(String.self, forKey: .small)
  }

}
