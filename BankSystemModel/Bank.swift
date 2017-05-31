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
    
    typealias Employees = Set<Employee>
    var employees: Employees
    
    typealias Customers = [Customer]
    var customers: Customers
    
    let account: Account
    
    typealias AccountBalance = Double
    
    var accountBalance: AccountBalance {
        let accountBalance = account.balance
        return accountBalance
    }
    
    typealias TransactionType = Account.Transaction.TransactionType
    var transactionType: TransactionType
    
    typealias AccountDirectory = [UUID: AccountBalance]
    var accountDirectory: AccountDirectory
    
    init(account: Account, accountDirectory: [UUID: AccountBalance], transactionType: TransactionType, employees: Employees, customers: Customers) {
        self.account = account
        self.accountDirectory = accountDirectory
        self.transactionType = transactionType
        self.employees = employees
        self.customers = customers
    }
    
    struct AccountMethods {
        
        func createNewAccount(customer: Customer?, account: Account, accountType: Account.AccountType) -> Bool {
            guard customer != nil else {
                return false
            }
            var customers = Bank.Customers()
            var accountDirectory = Bank.AccountDirectory()
            
            customers.append(customer!)
            for (_, _) in accountDirectory {
                accountDirectory.updateValue(account.balance, forKey: account.id)
            }
            return true
        }
        
        func makeCustomerTransaction(customer: Customer, account: Account, transactionType: TransactionType) -> Bool {
            
            let customers = Bank.Customers()
            
            guard customers.contains(customer) else {
                return false
            }
            
            var transactions = Account.Transactions()
            var accountBalance = Account.AccountBalance()
            let amount = Double()
            
            switch transactionType {
            case .credit(amount):
                guard amount.sign == .plus else {
                    return false
                }
                accountBalance.add(amount)
                for transaction in transactions {
                    transactions.append(transaction)
                    return true
                }
            case .debit(amount: amount):
                guard amount < account.balance else {
                    return false
                }
                account.balance.subtract(amount)
                for transaction in transactions {
                    transactions.append(transaction)
                    return true
                }
            default:
                return false
            }
            return false
        }
        
        func getSpecificAccountBalance(accountDirectory: AccountDirectory, id: UUID) -> Double {
            let givenAccount = accountDirectory.filter { $0.key == id }
            let givenAccountBalance = givenAccount.reduce(0) { $0 + $1.1 }
            return givenAccountBalance
        }
        
        func getBalanceOfAllAccounts(accountDirectory: AccountDirectory) -> Double {
            let bankBalance = accountDirectory.reduce(0) { $0 + $1.1 }
            return bankBalance
        }
    }
}
