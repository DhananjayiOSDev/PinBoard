//
//  PBUrls.swift
//
//  Created by Dhananjay on 22/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class PBUrls: Codable {

  enum CodingKeys: String, CodingKey {
    case raw
    case thumb
    case small
    case full
    case regular
  }

  var raw: String?
  var thumb: String?
  var small: String?
  var full: String?
  var regular: String?

  init (raw: String?, thumb: String?, small: String?, full: String?, regular: String?) {
    self.raw = raw
    self.thumb = thumb
    self.small = small
    self.full = full
    self.regular = regular
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    raw = try container.decodeIfPresent(String.self, forKey: .raw)
    thumb = try container.decodeIfPresent(String.self, forKey: .thumb)
    small = try container.decodeIfPresent(String.self, forKey: .small)
    full = try container.decodeIfPresent(String.self, forKey: .full)
    regular = try container.decodeIfPresent(String.self, forKey: .regular)
  }

}
