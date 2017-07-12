//
//  Customer.swift
//  BankSystemModel
//
//  Created by Crystal Jade Allen-Washington on 7/10/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

class Customer: Person {
    var email: String
    var accounts: Set<Account>
    
    init(email: String, accounts: Set<Account>, givenName: String, familyName: String) {
        self.email = email
        self.accounts = accounts
        super.init(givenName: givenName, familyName: familyName)
        self.givenName = givenName
        self.familyName = familyName
    }
    
}
