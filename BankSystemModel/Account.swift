//
//  Account.swift
//  BankWithJSON
//
//  Created by Crystal Jade Allen-Washington on 5/2/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

class Account {
    enum AccountType {
        case checking
        case savings
    }
    
    let id: UUID
    let accountType: AccountType
    
    public private(set) var balance: Double

    init(accountType: AccountType, id: UUID = UUID(), balance: Double = 0) {
        self.id = id
        self.accountType = accountType
        self.balance = balance
    }
    
    public typealias Transactions = [Transaction]
    public var transactions: Transactions = []
           
        
    func makeCustomerTransaction(customer: Customer, account: Account, amount: Double, transactionType: Transaction.TransactionType, userDescription: String, vendor: String, dateCreated: Date) -> Transaction? {
        
        guard (customer.accounts.contains(account) == true) else {
            return nil
        }
                
        let newTransaction = Transaction(amount: amount, userDescription: userDescription, vendor: vendor, datePosted: nil, dateCreated: dateCreated)
        
        switch transactionType {
        case .credit(amount):
            guard amount.sign == .plus else {
                return nil
            }
            
            balance.add(amount)
            transactions.append(newTransaction)
            return newTransaction
            
        case .debit(amount: amount):
            guard amount < account.balance else {
                return nil
            }
            
            balance.subtract(amount)
            transactions.append(newTransaction)
            return newTransaction
            
        default:
            return nil
        }
    }
}

extension Account: Hashable {
    public var hashValue: Int {
        return id.hashValue
    }
    
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}

class SavingsAccount: Account {
    init(balance: Double = 0, id: UUID = UUID()) {
        super.init(accountType: .savings, id: id, balance: balance)
    }

}

class CheckingAccount: Account {
    init(balance: Double = 0, id: UUID = UUID()) {
        super.init(accountType: .checking, id: id, balance: balance)
    }
}
