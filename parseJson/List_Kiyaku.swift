//
//  List_Kiyaku.swift
//  parseJson
//
//  Created by Rea Won Kim on 4/11/17.
//  Copyright © 2017 Rea Won Kim. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class List_Kiyaku : Object {
    var code : Int!
    dynamic var message : String!

    var artist = List<Kiyaku>()
    dynamic var id : String = "1"
    init(code: Int, message: String, artist : List<Kiyaku>) {
        super.init()
        self.code = code
        self.message = message
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

