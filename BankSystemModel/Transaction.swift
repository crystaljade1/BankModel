//
//  File.swift
//  BankSystemModel
//
//  Created by Crystal Jade Allen-Washington on 7/12/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import Foundation

struct Transaction: Hashable {
    
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
        self.datePosted = datePosted.map(Transaction.sanitize(date: ))
        self.dateCreated = Transaction.sanitize(date: dateCreated)
    }
}
