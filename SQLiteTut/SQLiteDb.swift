//
//  SQLiteDb.swift
//  SQLiteTut
//
//  Created by ThangLQ on 5/3/17.
//  Copyright © 2017 ThangLQ. All rights reserved.
//

import UIKit
import SQLite

class SQLiteDb {
    static let instance = SQLiteDb()
    var connection: Connection? = nil
    
    let contactTable = Table("contacts")
    let columnId = Expression<Int64>("id")
    let columnName = Expression<String>("name")
    let columnPhone = Expression<String>("phone")
    let columnAddress = Expression<String>("address")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do{
            connection = try Connection("\(path)/contacts.sqlite3")
        } catch let error as NSError {
            connection = nil
            print("connection error = \(error)")
        }
        
        createTable()
        
    }
    
    func createTable() {
        do {
            try connection?.run(contactTable.create { t in
                t.column(columnId, primaryKey: true)
                t.column(columnName)
                t.column(columnPhone, unique: true)
                t.column(columnAddress)
            })
            
        } catch let error as NSError {
            print("create table error = \(error)")
        }
    }
    
    func addContact(contact: Contact) -> Int64 {
        do {
            let insertContact = contactTable.insert(columnName <- contact.name!, columnPhone <- contact.phone!, columnAddress <- contact.address!)
            let id = try connection?.run(insertContact)
            return id!
        } catch let error as NSError {
            print("addContact error = \(error)")
            return -1
        }
        
    }
    
    func getAllContact() -> [Contact] {
        var listContact = [Contact]()
        do {
            for contact in try connection!.prepare(contactTable) {
                listContact.append(Contact(id: contact[columnId], name: contact[columnName], phone: contact[columnPhone], address: contact[columnAddress]))
            }
        } catch let error as NSError {
            print("getAllContact error \(error)")
        }
        return listContact
    }
    
    func deleteContact(userId: Int64) -> Bool{
        do {
            let contact = contactTable.filter(columnId == userId)
            try contact.delete()
            return true
            
        } catch let error as NSError {
            print("deleteContact error\(error)")
            return false
        }
    }
    
    func updateContact(cId: Int64, newContact: Contact) -> Bool{
        let contact = contactTable.filter(columnId ==  cId)
        do {
            let update = contact.update([columnName <- newContact.name!, columnPhone <- newContact.phone!, columnAddress <- newContact.address!])
            if try (connection?.run(update))! > 0 {
                return true
            }
        } catch let error as NSError {
            print("updatecontact error \(error)")
        }
        return false
    }
}
