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
    var employees: Set<Employee>
    
    typealias AccountDirectory = [Customer: Set<Account>]
    var accountDirectory: AccountDirectory
    
    init(employees: Set<Employee> = [], accountDirectory: AccountDirectory = [:]) {
        self.employees = employees
        self.accountDirectory = accountDirectory
    }
}

extension Bank {
    
    var customers: Set<Customer> {
        return Set(accountDirectory.keys)
    }

    func addNewEmployee(employee: Employee) -> Bool {
        if employees.contains(employee) {
            return false
        } else {
            employees.insert(employee)
            return true
        }
    }

    func addNewCustomer(customer: Customer) -> Bool {
        
        guard customers.contains(customer) == false else {
            return false
        }
        
        accountDirectory[customer] = []
        return true
    }
    

    func createNewAccount(customer: Customer, accountType: Account.AccountType) -> Account? {
        
        guard var customerAccounts = accountDirectory[customer] else {
            return nil
        }
        
        let newAccount: Account
        
        switch accountType {
        case .checking:
            newAccount = CheckingAccount()
        case .savings:
            newAccount = SavingsAccount()
        }
        
        customerAccounts.insert(newAccount)
        accountDirectory[customer] = customerAccounts
       
        return newAccount
    }

    func getSpecificAccountBalance(customer: Customer, id: UUID) -> Double? {
        guard let customerAccounts = accountDirectory[customer] else {
            return nil
        }
        
        let givenAccountBalance = customerAccounts.reduce(0) { $0 + $1.balance }
        return givenAccountBalance
    }
    
    func getAllAccountsForSpecificCustomer(customer: Customer) -> Set<Account>? {
        guard let customerAccounts = accountDirectory[customer] else {
            return nil
        }
        
        accountDirectory[customer] = customerAccounts
        return customerAccounts
    }
    
    func getBalanceOfAllAccounts() -> Double? {
        for (_, accounts) in accountDirectory {
            let totalBankBalance = accounts.reduce(0) { $0 + $1.balance }
            return totalBankBalance
        }
        
        return nil
    }
}

