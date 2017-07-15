//
//  Bank.swift
//  BankWithJSON
//
//  Created by Crystal Jade Allen-Washington on 5/2/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

class Bank {
    
    var bankAddress: String
    var employees: Set<Employee>
    
    typealias AccountDirectory = [Customer: Set<Account>]
    var accountDirectory: AccountDirectory

    static var bankAddressKey: String = "address"
    static var employeesKey: String = "employees"
    static var accountDirectoryKey: String = "accountDirectory"
    
    static func pullBank(json: [[String: Any]]) -> [Bank]? {
        let back = json.flatMap(Bank.init(json:))
        guard back.count == json.count else {
            return nil
        }
        return back
    }
    
    init(bankAddress: String = "", employees: Set<Employee> = [], accountDirectory: AccountDirectory = [:]) {
        self.bankAddress = bankAddress
        self.employees = employees
        self.accountDirectory = accountDirectory
    }
    
    convenience init?(json: [String: Any]) {
        guard let bankAddress = json[Bank.bankAddressKey] as? String,
        let employees = json[Bank.employeesKey] as? Set<Employee>,
        let accountDirectory = json[Bank.accountDirectoryKey] as? AccountDirectory
            else {
                return nil
        }
        self.init(bankAddress: bankAddress, employees: employees, accountDirectory: accountDirectory)
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
