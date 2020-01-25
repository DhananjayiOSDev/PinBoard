//
//  PBLinks.swift
//
//  Created by Dhananjay on 22/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation

class PBLinks: Codable {

  enum CodingKeys: String, CodingKey {
    case html
    case selfLink
    case download
  }

  var html: String?
  var selfLink: String?
  var download: String?

  init (html: String?, selfLink: String?, download: String?) {
    self.html = html
    self.selfLink = selfLink
    self.download = download
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    html = try container.decodeIfPresent(String.self, forKey: .html)
    selfLink = try container.decodeIfPresent(String.self, forKey: .selfLink)
    download = try container.decodeIfPresent(String.self, forKey: .download)
  }

}
