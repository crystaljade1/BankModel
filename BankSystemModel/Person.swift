//
//  Person.swift

//  BankWithJSON
//
//  Created by Crystal Jade Allen-Washington on 5/30/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

public class Person: Hashable {
    
    var givenName: String
    var familyName: String
    var fullName: String {
        let fullName = "\(givenName) + \(familyName)"
        return fullName
    }
    
    init(givenName: String, familyName: String) {
        self.givenName = givenName
        self.familyName = familyName
    }
    
    public var hashValue: Int {
        return fullName.hashValue
    }
    
    public static func == (_ lhs: Person, _ rhs: Person) -> Bool {
        return (lhs.givenName == rhs.givenName) && (lhs.familyName == rhs.familyName)
    }
    
}

public class Employee: Person {
    
    func addNewEmployee(employee: Employee, employees: Bank.Employees) -> Bool {
        var employees = employees
        
        if employees.contains(employee) {
            return false
        } else {
            employees.insert(employee)
            return true
        }
    }
}

public class Customer: Person {
    var email: String
    var accounts: [Account]
    
    init(email: String, accounts: [Account], givenName: String, familyName: String) {
        self.email = email
        self.accounts = accounts
        super.init(givenName: givenName, familyName: familyName)
        self.givenName = givenName
        self.familyName = familyName
    }
    
    func addNewCustomer(customer: Customer, customers: [Customer]) -> Bool {
        var customers = customers
        
        guard customer.email == customer.email else {
            return false
        }
        
        customers.append(customer)
        return true
    }
}
