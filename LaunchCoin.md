## Launching our own coin

> ERC20 [https://github.com/ethereum/EIPs/blob/f98a60e1b1590c9cfa0bfe66c4e6a674e54cd386/EIPS/eip-20.md]

* It is a simple proposal saying any smart contract written to launch a new crypto currency (aka token), must implement the mentioned functions. The functions have been explained in the above EIP.
* An EIP is an Ethereum Improvement Proposal. Once approved by the community, it is converted into an ERC (Ethereum request for comment). 
* The EIP20 was accepted by the community. Now every developer uses this standard to launch a crypto currency. Every other software in the ecosystem 
including wallets (like metamask) and exchanges (like uniswap) use this standard to interact with the smart contracts - because they know what to expect.

---
To run these services, please follow below order
> Writing a new contract
``` bash
  Note that we have modified the signature a little bit. Instead of returns(string), we have changed it to returns(string memory). The memory keyword tells Solidity that after returning the variable, it can erase it from the memory stack.
  There are two such modifiers. Memory and Storage.
  Memory is for impersistent storage. That is after the function call the variable can be killed and deleted.
  However a Storage variable is stored persistently. The data will be accessible across function calls.
  In our case we want the function name() to return the name string. This function doesn’t modify any variable that we’d need to store for use by other functions.
```

> Defining the properties of this currency
``` bash
  	There are two properties we need to define for the currency itself.
    The first is the total supply. This defines how many coins of this currency will ever be in circulation.
    There are two types of currencies that are popular right now : Inflationary and Fixed.
    Inflation is one in which the number of coins in circulation keeps increasing with time. I.e the function totalSupply() returns a higher number each time you call it. ETH is an inflationary crypto currency.
    On the other hand, fixed supply currencies define how many coins will ever be in circulation. This creates scarcity, and drives up the prices on the exchanges when demand for the coins increases. Bitcoin is a fixed supply crypto currency, albeit not an ERC20 token. COMP (compound) is a fixed supply ERC20 token that has only 10M coins that will ever be in circulation.
    We’ll start with a fixed supply token. Let us start with 10M coins.
    Let us define the second parameter of our currency that is decimals().
    Solidity doesn’t have support for decimals (double and float) yet. But it does support big integers. That is also why Ethers are always measured in Wei. So instead of saying 0.000000000000000001 ETH, we say 1 Wei.
    The decimals() tells the world that every balance reported by this contract must be divided by ten to the power of this to get the actual value. So if we set our decimal to be 8, and a user has a balance of 1000, it really means they have a balance of 0.00001 coins.
```
---


> Dealing with money


> Minting a million coins for yourself

> Token approvals

These currencies allow for what is called approvals. Think of it as a parent letting their teenage kids spend money. ERC20 specifications require us to implement a function in which a user can give approval to another account to spend a designated number of coins.

This functionality is particularly useful when a user wants to allow a contract to spend money on their behalf. Just like what we saw in the previous quest. We wanted the contract to take our DAI and send it to Uniswap on our behalf. So what we did was, gave approval to the contract to use a certain number of DAI from our account.

The first function is the approve() function. Just like the balances, we must maintain what is the allowance for each user. Each user can give approvals to multiple other users. So, our data type will be

mapping(address => mapping(address => uint)) allowances

Allowances[user1][user2] = 10; implies user1 has approved user2 to spend 10 coins.

> Adding events

There’s another requirement that the ERC20 specification mandates.

It requires that events be triggered for allowance and transfers.

Any program like a web serverver, web app or iPhone application.

The events are mentioned here. You can copy paste the signatures to define the event.
https://github.com/ethereum/EIPs/blob/f98a60e1b1590c9cfa0bfe66c4e6a674e54cd386/EIPS/eip-20.md#events


Now that the events have been defined, they can be emitted. When an event is emitted, the other applications will be able to listen to them.

Transfer has to be emitted whenever a transfer is made. I.e. whenever the transfer() and transferFrom() are successful - so that, say the iphone app, can update the new balance of the user after the transfer in real time.

Approve must be emitted when the approval is made, so that the application can notify the spender that they now have an allowance waiting to be spent!

> Adding to metamask
> Listing on Uniswap
