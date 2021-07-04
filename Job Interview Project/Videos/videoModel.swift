//
//  videoModel.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 7/2/21.
//

import Foundation

struct videoModel : Codable {

    let id : Int?
    let results : [Results]?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }


}

struct Results : Codable {

    let id : String?
    let iso31661 : String?
    let iso6391 : String?
    let key : String?
    let name : String?
    let site : String?
    let size : Int?
    let type : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case iso31661 = "iso_3166_1"
        case iso6391 = "iso_639_1"
        case key = "key"
        case name = "name"
        case site = "site"
        case size = "size"
        case type = "type"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        iso31661 = try values.decodeIfPresent(String.self, forKey: .iso31661)
        iso6391 = try values.decodeIfPresent(String.self, forKey: .iso6391)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        site = try values.decodeIfPresent(String.self, forKey: .site)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }


}
