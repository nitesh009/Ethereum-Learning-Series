> Getting some crypto currency other than ETH

You might have heard of many crypto currencies like Ethers, Bitcoin, Litecoin and many more. There are a lot of crypto currencies out there. However, there is a class of crypto currencies that are built on the ethereum network. These are called ERC20 tokens. Bitcoin is not an ERC20 token. Some examples of ERC20 tokens are DAI, MATIC.

An ERC20 Token is nothing but an implementation of a standard crypto currency smart contract. In this quest we will be looking at a crypto token called DAI, one of the most popular ERC20 tokens.

First, let’s look at what a smart contract for a crypto currency (ERC20) looks like.

https://ropsten.etherscan.io/address/0xad6d458402f60fd3bd25163575031acdce07538d#code

This is the link to the contract of the DAI token’s code.

> Let’s get some dai

We can exchange one crypto currency to another using what are called exchanges. There are many exchanges out there. Some of the popular ones are Uniswap, Coinbase and Binance.

We will be using Uniswap here because it is a decentralized exchange. Meaning, unlike Coinbase and Binance, there is no company that is running this exchange. It is completely run by a collection of a few smart contracts.

We already own one cryptocurrency that is ETH, let’s convert that into another crypto currency called DAI.

Head over to uniswap website



> Accepting ERC20 tokens (DAI etc) into our bank

Now that we have DAI in our wallet, let’s try to transfer those DAI to our smart bank account.

How do we accept DAI?

We know the DAI Erc20 token is just a smart contract. We have already seen how to add balance by sending ETH to our smart account. We use the payable key word.

However, payable allows only ETH to be sent to the function. We cannot send an ERC20 token like DAI to a payable function. We’ll have to do something else.

The reason we can’t send an ERC20 token to a function just like ETH is because ETH is the native currency of Ethereum. So Solidity natively supports ETH. However, DAI and other ERC20 tokens are mere smart contracts. We can only interact with the smart contract just like how we interacted with the compound smart contract in the previous quest.

So, let’s do just that. Like what we had done in Compound example, we’ll have to define the interface and initialize an object with the appropriate smart contract address.

> A new way to transfer Tokens

The first step is to send tokens along with a function call.

There are two ways to transfer an erc20 token.

The first is to use the transfer() function.Let us check the parameters of this function call. It is “To” and “amount”. So we’ll have to set the address of this smart bank account contract, and amount as the number of erc20 tokens we want to send.

That will work perfectly fine, but where’s the function call? What what code should get executed immediately after this transfer? Immediately after the transfer we want to run some code. I.e. to convert it into ETH using Uniswap and then deposit to Compound.

There is another way to transfer money. But this is a two step process. The first step is to call the approve() function. The owner of the ERC20 tokens tells Ethereum that they are approving a certain user/smart contract to use a portion of tokens they hold.


 
> approving transfer of DAI
Now the first step is to approve the transfer of DAI. But this has to happen not on our smart contract but on the smart contract of DAI. We need to interact with the DAI smart contract directly.

To do that we’ll use a tool called https://ethcontract.app

To use a contract you need two things. First is the address of the contract itself. The second is what is called the ABI. ABI is like an API specification for the web3 world. The ABI tells us what are the functions that are callable in this particular contract.

So let’s find the address of the smart contract of DAI. We will use the ropsten network. Remember the addresses of smart contracts differ between testnet and mainnet.

A simple google search “ropsten dai etherscan” will give you the contract address on etherscan.


> sending DAI to Uniswap

Now that we have transferred the DAIs from the user (msg.sender)’s account to the smart contract’s account using transferFrom(), we can now start looking at exchanging it for ETH before we can send it to compound.

For this we’ll integrate Uniswap, which is also a smart contract.

Search for “Uniswap Router v2 Ropsten Etherscan”

https://ropsten.etherscan.io/address/0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D#code

Direct link ^

If we want to use a smart contract’s functions, we need their address and an interface in which we define what functions we want to call.

We’ll use only two functions here to convert erc20 tokens to eth and eth to erc20 tokens.

They are called

swapExactETHForTokens (to convert eth to erc20 tokens)

swapExactTokensForETH (to convert erc20 tokens to eth)
