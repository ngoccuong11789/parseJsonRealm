//
//  ListArtist.swift
//  parseJson
//
//  Created by Rea Won Kim on 4/10/17.
//  Copyright © 2017 Rea Won Kim. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class ListArtist : Object {
    var code : Int!
    dynamic var message : String!
    dynamic var time_update: String!
    var artist = List<Artist>()
    dynamic var id : String = "1"
    init(code: Int, message: String, time_update: String, artist : List<Artist>) {
        super.init()
        self.code = code
        self.message = message
        self.time_update = time_update
        self.artist = artist
    }

    required init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}
