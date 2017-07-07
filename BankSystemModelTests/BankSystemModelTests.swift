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
        let accounts = [Account]()
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
    
    func testAddNewCustomerAndCreateNewAccountandGetAccountBalance() {
        // New Customer Created
        let accounts = [Account]()
        let newCustomer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let bank = Bank()
        let result = bank.addNewCustomer(customer: newCustomer)
        let expected = true
        XCTAssertEqual(result, expected)
        
        // Customer Added to List
        let customers = bank.customers
        let addedSuccessfully = customers.contains(newCustomer)
        XCTAssertTrue(addedSuccessfully)
        
        // New Account Created
        let accountType = Account.AccountType.checking
        let newAccount = bank.createNewAccount(customer: newCustomer, accountType: accountType)
        XCTAssertNotNil(newAccount)
        
        //Account Added to Customer's Accounts List
        let customerAccountList = newCustomer.accounts
        let addedToCustomerAccountList = customerAccountList.contains(newAccount!)
        XCTAssertTrue(addedToCustomerAccountList)
        
        // Account Added to Account Directory
        let createdID = newAccount?.id
        let accountDirectory = bank.accountDirectory
        let balanceValue = accountDirectory[createdID!]
        XCTAssertNotNil(balanceValue)
        
        // Account Balance Pulled Successfully
        let balanceResult = bank.getSpecificAccountBalance(id: createdID!)
        let balanceExpected = 0.00
        XCTAssertEqual(balanceResult, balanceExpected)
    }
    
    func testCreateNewAccountFail() {
        // Expected result = nil because customer does not exist within customer list.
        let accounts = [Account]()
        let accountType = Account.AccountType.savings
        let customer = Customer(email: "noahnoah1@aol.com", accounts: accounts, givenName: "Noah", familyName: "Washington")
        let bank = Bank()
        let result = bank.createNewAccount(customer: customer, accountType: accountType)
        let expected: Account? = nil
        XCTAssertTrue(result == expected)
    }
    

    // BANK TESTS
    
    func testAddNewCustomerAndCreateNewAccountAndMakeDeposit() {
        // New Customer Created
        let accounts = [Account]()
        let newCustomer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let bank = Bank()
        let result = bank.addNewCustomer(customer: newCustomer)
        let expected = true
        XCTAssertEqual(result, expected)
        
        // Customer Added to List
        let customers = bank.customers
        let addedSuccessfully = customers.contains(newCustomer)
        XCTAssertTrue(addedSuccessfully)
        
        // New Account Created
        let accountType = Account.AccountType.checking
        let newAccount = bank.createNewAccount(customer: newCustomer, accountType: accountType)
        XCTAssertNotNil(newAccount)
        
        // Account Added to Customer's Accounts List
        let customerAccountList = newCustomer.accounts
        let addedToCustomerAccountList = customerAccountList.contains(newAccount!)
        XCTAssertTrue(addedToCustomerAccountList)
        
        // Deposit Made Successfully
        let depositAmount = 50.00
        let account = Account(id: (newAccount?.id)!, balance: (newAccount?.balance)!)
        let transactionType = Account.Transaction.TransactionType.credit(amount: depositAmount)
        let userDescription = "Money for food."
        let vendor = "Cash deposit."
        let dateCreated = Date()
        let newTransaction = account.makeCustomerTransaction(customer: newCustomer, account: newAccount!, amount: depositAmount, transactionType: transactionType, userDescription: userDescription, vendor: vendor, dateCreated: dateCreated)
        let balance = account.balance
        XCTAssertNotNil(newTransaction)
        XCTAssertTrue(balance == 50.00)
        
        // Deposit Added to Transaction List
        let transactionList = account.transactions
        let transactionAddedToCustomerTransactionList = transactionList.contains(newTransaction!)
        XCTAssertTrue(transactionAddedToCustomerTransactionList)
        
        // Pull All Accounts For This Specific Customer
        let allAccountsResult = bank.getAllAccountsForSpecificCustomer(customer: newCustomer)
        let allAccountsExpected = newCustomer.accounts
        XCTAssertEqual(allAccountsResult!, allAccountsExpected)
        
        // Pull Balance for All Accounts in Bank
        let accountDirectory = bank.accountDirectory
        let totalBankBalanceResult = bank.getBalanceOfAllAccounts(accountDirectory: accountDirectory)
        let totalBankBalanceExpected = 50.00
        XCTAssertEqual(totalBankBalanceResult, totalBankBalanceExpected)
    }
    
    func testAddNewCustomerAndCreateNewAccountAndMakeWithdrawal() {
        // New Customer Created
        let accounts = [Account]()
        let newCustomer = Customer(email: "jaredchristopher@aol.com", accounts: accounts, givenName: "Jared", familyName: "Stevenson")
        let bank = Bank()
        let result = bank.addNewCustomer(customer: newCustomer)
        let expected = true
        XCTAssertEqual(result, expected)
        
        // Customer Added to List
        let customers = bank.customers
        let addedSuccessfully = customers.contains(newCustomer)
        XCTAssertTrue(addedSuccessfully)
        
        // New Account Created
        let accountType = Account.AccountType.checking
        let newAccount = bank.createNewAccount(customer: newCustomer, accountType: accountType)
        XCTAssertNotNil(newAccount)
        
        // Account Added to Customer's Accounts List
        let customerAccountList = newCustomer.accounts
        let addedToCustomerAccountList = customerAccountList.contains(newAccount!)
        XCTAssertTrue(addedToCustomerAccountList)
        
        // Withdrawal Made Successfully
        let dateCreated = Date()
        let account = Account(id: (newAccount?.id)!, balance: (newAccount?.balance)!)
        account.balance = 100.00
        let withdrawalAmount = 20.00
        let withdrawalTransactionType = Account.Transaction.TransactionType.debit(amount: withdrawalAmount)
        let description = "Dinner"
        let withdrawalVendor = "Chilis"
        let withdrawalTransaction = account.makeCustomerTransaction(customer: newCustomer, account: account, amount: withdrawalAmount, transactionType: withdrawalTransactionType, userDescription: description, vendor: withdrawalVendor, dateCreated: dateCreated)
        let newBalance = account.balance
        XCTAssertNotNil(withdrawalTransaction)
        XCTAssertTrue(newBalance == 80.00)
        
        //Withdrawal Added To Transaction List
        let transactionList = account.transactions
        let withdrawalAddedToCustomerTransactionList = transactionList.contains(withdrawalTransaction!)
        XCTAssertTrue(withdrawalAddedToCustomerTransactionList)
    }

    func testAddNewCustomerAndCreateNewAccountAndMakeUnsuccessfulWithdrawal() {
        // New Customer Created
        let accounts = [Account]()
        let newCustomer = Customer(email: "zurigrace1@aol.com", accounts: accounts, givenName: "Zuri", familyName: "Manuel")
        let bank = Bank()
        let result = bank.addNewCustomer(customer: newCustomer)
        let expected = true
        XCTAssertEqual(result, expected)
        
        // Customer Added to List
        let customers = bank.customers
        let addedSuccessfully = customers.contains(newCustomer)
        XCTAssertTrue(addedSuccessfully)
        
        // New Account Created
        let accountType = Account.AccountType.checking
        let newAccount = bank.createNewAccount(customer: newCustomer, accountType: accountType)
        XCTAssertNotNil(newAccount)
        
        // Withdrawal Unsuccessful 
        let withdrawalAmount = 50.00
        let account = Account(id: (newAccount?.id)!, balance: (newAccount?.balance)!)
        let transactionType = Account.Transaction.TransactionType.debit(amount: withdrawalAmount)
        let userDescription = "Dinner"
        let vendor = "Olive Garden"
        let dateCreated = Date()
        let newTransaction = account.makeCustomerTransaction(customer: newCustomer, account: newAccount!, amount: withdrawalAmount, transactionType: transactionType, userDescription: userDescription, vendor: vendor, dateCreated: dateCreated)
        let balance = account.balance
        XCTAssertNil(newTransaction)
        XCTAssertTrue(balance == 0.00)
    }
    
}
