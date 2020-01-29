# Bank Tech Test

This is the first tech test taken on Week 10. 
The test was about creating a bank account system that allows users to print their bank statement and to perform operations such as withdrawals and deposits (see the [Specification](#specification) below).


## Get started

First, clone this repository. Then run :
```
> bundle install # install dependencies
> rspec # run tests
> rubocop # check code quality
```
The coverage is 100% (Simplecov).
Try it yourself in the ```irb```:
```
require './lib/account.rb'
account = Account.new
account.deposit(1000) # should return 1000
account.withdraw(200) # should return 800
account.statement # should display your operations in reverse chronological order
```

## <a name="specification">Specification</a>

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```
### User stories

```
As an existing client
So I can keep track of my finances
I want to see my account statement.
```
```
As an existing client
So I can put money on my bank account
I want to make a deposit.
```
```
As an existing client
So I can use my money
I want to make a withdrawal.
```
