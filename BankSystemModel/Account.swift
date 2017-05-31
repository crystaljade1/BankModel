//
//  Account.swift
//  BankWithJSON
//
//  Created by Crystal Jade Allen-Washington on 5/2/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

public class Account {
    enum AccountType {
        case checking
        case savings
    }
    
    typealias ID = UUID
    let id: ID
    
    typealias AccountBalance = Double
    var balance: AccountBalance
    
    init(id: UUID, balance: Double) {
        self.id = id
        self.balance = balance
    }
    
    public typealias Transactions = [Transaction]
    public var transactions: Transactions = []
    
    public struct Transaction: Hashable {
        
        public var hashValue: Int {
            let transaction: Transaction
            transaction = Transaction(amount: amount, userDescription: userDescription, vendor: vendor, datePosted: datePosted)
            return transaction.hashValue
        }
        
        public static func == (_ lhs: Transaction, _ rhs: Transaction) -> Bool {
            return (lhs.amount == rhs.amount &&
                lhs.dateCreated == rhs.dateCreated &&
                lhs.datePosted == rhs.datePosted &&
                lhs.vendor == rhs.vendor &&
                lhs.userDescription == rhs.userDescription)
        }
        
        enum TransactionType {
            case debit(amount: Double)
            case credit(amount: Double)
        }
        
        let amount: Double
        var userDescription: String?
        let vendor: String
        var datePosted: Date?
        let dateCreated: Date
        static func sanitize(date: Date) -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            return calendar.date(from: components)!
        }
        
        public init(amount: Double,
                    userDescription: String?,
                    vendor: String,
                    datePosted: Date?) {
            self.init(amount: amount, userDescription: userDescription,
                      vendor: vendor,
                      datePosted: datePosted,
                      dateCreated: Date())
        }
        
        internal init(amount: Double,
                      userDescription: String?,
                      vendor: String,
                      datePosted: Date?,
                      dateCreated: Date) {
            self.amount = amount
            self.userDescription = userDescription
            self.vendor = vendor
            self.datePosted = datePosted.map(Account.Transaction.sanitize(date: ))
            self.dateCreated = Account.Transaction.sanitize(date: dateCreated)
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
