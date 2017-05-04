//
//  ViewController.swift
//  SQLiteTut
//
//  Created by ThangLQ on 5/3/17.
//  Copyright © 2017 ThangLQ. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    var contacts = [Contact]()
    var contactSelected: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableview.delegate = self
        tableview.dataSource = self
        contacts = SQLiteDb.instance.getAllContact()
    }

    
    @IBAction func addContact(_ sender: Any) {
        if let name = nameTextFiled.text, let phone = phoneTextField.text, let address = addressTextField.text {
            let contact = Contact(id: 0, name: name, phone: phone, address: address)
            
            contacts.append(contact)
            tableview.reloadData()
            SQLiteDb.instance.addContact(contact: contact)
        }
    }

    @IBOutlet weak var updateContact: UIButton!
    @IBAction func updateContact(_ sender: Any) {
        if let name = nameTextFiled.text, let phone = phoneTextField.text, let address = addressTextField.text {
            let contact = Contact(id: contacts[contactSelected!].id, name: name, phone: phone, address: address)
            SQLiteDb.instance.updateContact(cId: contacts[contactSelected!].id!, newContact: contact)
            contacts.remove(at: contactSelected!)
            contacts.insert(contact, at: contactSelected!)
            tableview.reloadData()
        }
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        contacts.remove(at: contactSelected!)
        tableview.reloadData()
        let contact = contacts[contactSelected!]
        SQLiteDb.instance.deleteContact(userId: (contact.id)!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]
        cell.contact = contact
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        nameTextFiled.text = contact.name
        phoneTextField.text = contact.phone
        addressTextField.text = contact.address
        contactSelected = indexPath.row
    }
}

