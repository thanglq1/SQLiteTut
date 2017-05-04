//
//  Contact.swift
//  SQLiteTut
//
//  Created by ThangLQ on 5/3/17.
//  Copyright © 2017 ThangLQ. All rights reserved.
//

import UIKit

class Contact {
    let id: Int64?
    var name: String?
    var phone: String?
    var address: String?
    
    init(id: Int64?) {
        self.id = id
        name = ""
        phone = ""
        address = ""
    }
    
    init(id: Int64?, name: String, phone: String, address: String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
    }
}
