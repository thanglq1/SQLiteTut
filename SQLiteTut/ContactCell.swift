//
//  ContactCell.swift
//  SQLiteTut
//
//  Created by ThangLQ on 5/3/17.
//  Copyright © 2017 ThangLQ. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell{
    var contact : Contact? {
        didSet {
            self.textLabel?.text = contact?.name
            self.detailTextLabel?.text = (contact?.phone)!
        }
    }
}
