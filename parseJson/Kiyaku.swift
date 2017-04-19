//
//  Kiyaku.swift
//  parseJson
//
//  Created by Rea Won Kim on 4/11/17.
//  Copyright © 2017 Rea Won Kim. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
class Kiyaku : Object {
    dynamic var id : String!
    dynamic var text : String!
    dynamic var title : String!
    
    init(id: String, text: String, title: String) {
        super.init()
        self.id = id
        self.text = text
        self.title = title
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}


