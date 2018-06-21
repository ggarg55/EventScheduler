//
//  Photos.swift
//  Events Scheduler
//
//  Created by Gourav  Garg on 21/06/18.
//  Copyright © 2018 Gourav  Garg. All rights reserved.
//

import Foundation
struct Photos : Codable {
    let page : Int?
    let pages : String?
    let perpage : Int?
    let total : String?
    let photo : [Photo]?
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photo = "photo"
    }
    
   /* init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pages = try values.decodeIfPresent(String.self, forKey: .pages)
        perpage = try values.decodeIfPresent(Int.self, forKey: .perpage)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        photo = try values.decodeIfPresent([Photo].self, forKey: .photo)
    }*/
}
