//
//  Bank.swift
//  BankWithJSON
//
//  Created by Crystal Jade Allen-Washington on 5/2/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

public class Bank {
    
    var bankAddress = "1309 5th Avenue, New York, NY 10029"
    var employees = Set<Employee>()
    var customers = [Customer]()
    
    typealias AccountDirectory = [UUID: Account.AccountBalance]
    var accountDirectory: AccountDirectory = [:]
    
    var transactionType = Account.Transaction.TransactionType.self
    
    func addNewEmployee(employee: Employee?) -> Bool {
        
        guard let employee = employee, !employees.contains(employee) else {
            return false
        }
        
        employees.insert(employee)
        return true
    }

    func addNewCustomer(customer: Customer) -> Bool {
        
        guard customer.email == customer.email, !customers.contains(customer) else {
            return false
        }
        
        customers.append(customer)
        return true
    }
    

    func createNewAccount(customer: Customer, accountType: Account.AccountType) -> Account? {
        
        guard (customers.contains(customer) == true) else {
            return nil
        }
        
        let id = Account.ID()
        let balance = Account.AccountBalance()
        let newAccount: Account? = Account(id: id, balance: balance)
        
        customer.accounts.append(newAccount!)
        accountDirectory.updateValue(balance, forKey: id)
       
        return newAccount
    }

    func getSpecificAccountBalance(id: UUID) -> Double {
        let givenAccount = accountDirectory.filter { $0.key == id }
        let givenAccountBalance = givenAccount.reduce(0) { $0 + $1.1 }
        return givenAccountBalance
    }
    
    func getAllAccountsForSpecificCustomer(customer: Customer) -> [Account]? {
        if customer.email == customer.email {
            return customer.accounts
        } else {
            return nil
        }
    }
    
    func getBalanceOfAllAccounts(accountDirectory: AccountDirectory) -> Double {
        let bankBalance = accountDirectory.reduce(0) { $0 + $1.1 }
        return bankBalance
    }
}

