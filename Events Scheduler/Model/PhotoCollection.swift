//
//  PhotoCollection.swift
//  Events Scheduler
//
//  Created by Gourav  Garg on 21/06/18.
//  Copyright © 2018 Gourav  Garg. All rights reserved.
//

import Foundation
struct PhotoCollection: Codable {
    let photos : Photos?
    let stat : String?
    
    enum CodingKeys: String, CodingKey {
        
        case photos = "photos"
        case stat = "stat"
    }
    
    /*init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent(Photos.self, forKey: .photos)
        stat = try values.decodeIfPresent(String.self, forKey: .stat)
    }*/
}
