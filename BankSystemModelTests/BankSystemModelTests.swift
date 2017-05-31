//
//  BankSystemModelTests.swift
//  BankSystemModelTests
//
//  Created by Crystal Jade Allen-Washington on 5/30/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import XCTest
@testable import BankSystemModel

class BankSystemModelTests: XCTestCase {
    
    // PERSON TESTS
    func testAddNewEmployee() {
        let employee = Employee(givenName: "Jared", familyName: "Stevenson")
        let employees = Bank.Employees()
        let result = employee.addNewEmployee(employee: employee, employees: employees)
        let expected = true
        XCTAssertEqual(result, expected)
    }
    
    func testAddCustomer() {
        let accounts = [Account]()
        let customers = Bank.Customers()
        let customer = Customer(email: "iamjude312@gmail.com", accounts: accounts, givenName: "Brother", familyName: "Sunflower")
        let result = customer.addNewCustomer(customer: customer, customers: customers)
        let expected = true
        XCTAssertEqual(result, expected)
    }
    
    // ACCOUNT TESTS
    
    func testCreateNewAccount() {
        let id = UUID()
        let accounts = [Account]()
        let customer = Customer(email: "zurigrace1@gmail.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let bank = Bank.AccountMethods()
        let account = Account(id: id, balance: 100.00)
        let accountType = Account.AccountType.checking
        let result = bank.createNewAccount(customer: customer, account: account, accountType: accountType)
        let expected = true
        XCTAssertEqual(result, expected)
    }
    
    // BANK TESTS
    
    func testMakeCustomerTransactionFail() { // Test passes since there are no customers in Customer Array. Designed to fail, however, to show process where account balance < debit amount.
        
        let bank = Bank.AccountMethods()
        let accounts = [Account]()
        let customer = Customer(email: "dododo1@gmail.com", accounts: accounts, givenName: "Bunga", familyName: "Boy")
        let id = UUID()
        let account = Account(id: id, balance: 0.00)
        let transactionType = Bank.TransactionType.debit(amount: 50.00)
        let result = bank.makeCustomerTransaction(customer: customer, account: account, transactionType: transactionType)
        let expected = false
        XCTAssertEqual(result, expected)
    }
    
    func testMakeCustomerTransactionSuccess() { // Test passes since there are no customers in Customer Array. Designed to pass, so long as customer is within the Customer Array, as account balance > debit amount.

        let bank = Bank.AccountMethods()
        let accounts = [Account]()
        let customer = Customer(email: "dododo1@gmail.com", accounts: accounts, givenName: "Bunga", familyName: "Boy")
        let id = UUID()
        let account = Account(id: id, balance: 100.00)
        let transactionType = Bank.TransactionType.debit(amount: 50.00)
        let result = bank.makeCustomerTransaction(customer: customer, account: account, transactionType: transactionType)
        let expected = false
        XCTAssertEqual(result, expected)
    }
    
    func testGetSpecificAccountBalance() {
        let accountDirectory = Bank.AccountDirectory()
        let id = UUID()
        let bank = Bank.AccountMethods()
        let result = bank.getSpecificAccountBalance(accountDirectory: accountDirectory, id: id)
        let expected = 0.00
        XCTAssertEqual(result, expected)
    }
    
    func testGetBalanceOfAllAccounts() {
        let accountDirectory = Bank.AccountDirectory()
        let bank = Bank.AccountMethods()
        let result = bank.getBalanceOfAllAccounts(accountDirectory: accountDirectory)
        let expected = 0.00
        XCTAssertEqual(result, expected)
    }

    
}
