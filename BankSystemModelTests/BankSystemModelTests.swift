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
        let newEmployee = Employee(givenName: "Jared", familyName: "Stevenson")
        let bank = Bank()
        let result = bank.addNewEmployee(employee: newEmployee)
        let expected = true
        XCTAssertEqual(result, expected)
        
        let employees = bank.employees
        let addedSuccessfully = employees.contains(newEmployee)
        XCTAssertTrue(addedSuccessfully)
    }
    
    func testAddNewCustomer() {
        let accounts = Set<Account>()
        let newCustomer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let bank = Bank()
        let result = bank.addNewCustomer(customer: newCustomer)
        let expected = true
        XCTAssertEqual(result, expected)
        
        let customers = bank.customers
        let addedSuccessfully = customers.contains(newCustomer)
        XCTAssertTrue(addedSuccessfully)
    }

    
    // ACCOUNT TESTS
    
    func testCreateNewAccountandGetAccountBalance() {
        let id = UUID()
        let accounts: Set<Account> = [Account(accountType: .savings, id: id, balance: 200.00),
                                      Account(accountType: .checking, id: id, balance: 50.00)]
        let customer = Customer(email: "noahnoah@aol.com", accounts: accounts, givenName: "Noah", familyName: "Noah")
        let bank = Bank()
        let result = bank.addNewCustomer(customer: customer)
        let expected = true
        XCTAssertEqual(result, expected)
        
        let customers = bank.customers
        let addedSuccessfully = customers.contains(customer)
        XCTAssertTrue(addedSuccessfully)
        
        let accountType = Account.AccountType.checking
        let newAccount = bank.createNewAccount(customer: customer, accountType: accountType)
        XCTAssertNotNil(newAccount)
        
        // Account Added to Account Directory
        let customerAccountList = bank.accountDirectory[customer]
        let accountAddedToList = customerAccountList?.contains(newAccount!)
        XCTAssertTrue(accountAddedToList!)
        
        // Account Balance Pulled Successfully
        let createdID = newAccount?.id
        let balanceResult = bank.getSpecificAccountBalance(customer: customer, id: createdID!)
        let balanceExpected = 0.00
        XCTAssertEqual(balanceResult, balanceExpected)
    }
    
    func testCreateNewAccountFail() {
        // Expected result = nil because customer does not exist within customer list.
        let accounts = Set<Account>()
        let accountType = Account.AccountType.savings
        let customer = Customer(email: "noahnoah1@aol.com", accounts: accounts, givenName: "Noah", familyName: "Washington")
        let bank = Bank()
        let result = bank.createNewAccount(customer: customer, accountType: accountType)
        let expected: Account? = nil
        XCTAssertTrue(result == expected)
    }
    

    // BANK TESTS
    
    func testMakeDepositSuccessfully() {
        let id = UUID()
        let accounts: Set<Account> = [Account(accountType: .savings, id: id, balance: 200.00),
                                      Account(accountType: .checking, id: id, balance: 50.00)]
        let customer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let dateCreated = Date()
        let savingsAccount = accounts.first
        let transaction = savingsAccount?.makeCustomerTransaction(customer: customer, account: savingsAccount!, amount: 1000.00, transactionType: .credit(amount: 1000.00), userDescription: "Money", vendor: "Family", dateCreated: dateCreated)
        XCTAssertNotNil(transaction)
        
        // Deposit Added to Transaction List
        let addedToTransactionList = savingsAccount?.transactions.contains(transaction!)
        XCTAssertTrue(addedToTransactionList!)
    }
    
    func testPullingAllAccountsForSpecificCustomer() {
        let id = UUID()
        let accounts: Set<Account> = [Account(accountType: .savings, id: id, balance: 200.00),
                                      Account(accountType: .checking, id: id, balance: 50.00)]
        let customer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        customer.accounts = accounts
        let bank = Bank()
        let result = bank.getAllAccountsForSpecificCustomer(customer: customer)
        let expected = bank.accountDirectory[customer]
        XCTAssertEqual(result, expected)
    }
    
    func testPullingBalanceForAllAccountsInBank() {
        let employees = Set<Employee>()
        let id = UUID()
        let accounts: Set<Account> = [Account(accountType: .savings, id: id, balance: 200.00)]
        let accountDirectory = [Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel") : accounts]
        let bank = Bank(employees: employees, accountDirectory: accountDirectory)
        let result = bank.getBalanceOfAllAccounts()
        let expected = 200.00
        XCTAssertNotNil(result)
        XCTAssertEqual(result, expected)
        
    }
    
    func testMakeWithdrawalSuccessfully() {
        let id = UUID()
        let accounts: Set<Account> = [Account(accountType: .savings, id: id, balance: 200.00),
                                          Account(accountType: .checking, id: id, balance: 50.00)]
        let newCustomer = Customer(email: "jaredchristopher@aol.com", accounts: accounts, givenName: "Jared", familyName: "Stevenson")
        let givenAccount = newCustomer.accounts.first
        let dateCreated = Date()
        let result = givenAccount?.makeCustomerTransaction(customer: newCustomer, account: givenAccount!, amount: 100.00, transactionType: .debit(amount: 100.00), userDescription: "Cash", vendor: "ATM", dateCreated: dateCreated)
        let newBalance = givenAccount?.balance
        let expectedBalance = 100.00
        XCTAssertNotNil(result)
        XCTAssertEqual(newBalance, expectedBalance)
        
        // Withdrawal Added To Transaction List
        let addedToListOfAccountTransactions = givenAccount?.transactions.contains(result!)
        XCTAssertTrue(addedToListOfAccountTransactions!)
    }

    func testAddNewCustomerAndCreateNewAccountAndMakeUnsuccessfulWithdrawal() {
        let id = UUID()
        let accounts: Set<Account> = [Account(accountType: .savings, id: id, balance: 200.00),
                                                     Account(accountType: .checking, id: id, balance: 50.00)]
        let newCustomer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let givenAccount = accounts.first
        
        // Withdrawal Unsuccessful 
        let withdrawalAmount = 300.00
        let transactionType = Transaction.TransactionType.debit(amount: withdrawalAmount)
        let userDescription = "Dinner"
        let vendor = "Olive Garden"
        let dateCreated = Date()
        let newTransaction = givenAccount?.makeCustomerTransaction(customer: newCustomer, account: givenAccount!, amount: withdrawalAmount, transactionType: transactionType, userDescription: userDescription, vendor: vendor, dateCreated: dateCreated)
        let balance = givenAccount?.balance
        XCTAssertNil(newTransaction)
        XCTAssertTrue(balance == 200.00)
    }
    
    func testJSONPull() {
        let bank = Bank()
    }
    
}
