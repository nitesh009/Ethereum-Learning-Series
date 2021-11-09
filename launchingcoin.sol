pragma solidity >=0.7.0 <0.9.0;

contract MyErc20 {
    string NAME = "MyErc20TokensReallyLongName";
    string SYMBOL = "M20";
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    
    mapping(address => uint) balances;
    address deployer;
    
    // https://app.uniswap.org/#/pool
    // Minting a million coins for yourself
    /*
        The constructor is called when the contract is deployed. 
        Just like every other function, the msg object is populated and 
        the msg.sender is set to the address of the user deploying the contract.
        The initial million tokens can be set when the constructor is called. 
        The constructor will be called exactly once in the lifetime of the contract. 
        It is also a good idea to store the deployer’s address as a variable in the contract, 
        so that if you want to give some special permissions to this user, you can do that using this variable.
    
    */
    constructor(){
        deployer = msg.sender;
        balances[deployer] = 1000000 * 1e8;
    }
    
    function name() public view returns (string memory){
        return NAME;
    }
    
    function symbol() public view returns (string memory) {
        return SYMBOL;
    }

    function decimals() public view returns (uint8) {
        return 8;
    }
    
    function totalSupply() public view returns (uint256) {
        return 10000000 * 1e8; //10M * 10^8 because decimals is 8
    }
    
    // Dealing with money
    
    /*
    Given a user address, we must return the balance of that person.

    In order to enable this functionality, we’ll define a mapping so that we can store the balances.

    mapping(address => uint)
    
    */
    
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];    
    }
    
    
    /*
        Similarly, when transfer is called we will deduct the balance from one user to another.

        You’ll notice the function has two parameters : to and value (aka amount). But from whom?
        
        We’ve added an assert statement so that we transfer money only if the sender actually has that much money. 
        If the assert fails the function will terminate.
    */ 
    function transfer(address _to, uint256 _value) public returns (bool success) {
        assert(balances[msg.sender] > _value);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        
        emit Transfer(msg.sender, _to, _value);
        
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if(balances[_from] < _value)
            return false;
        
        if(allowances[_from][msg.sender] < _value)
            return false;
            
        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, _value);
        
        return true;
    }
    
    mapping(address => mapping(address => uint)) allowances;
    
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }
    
    mapping(uint => bool) blockMined;
    uint totalMinted = 1000000 * 1e8; //1M that has been minted to the deployer in constructor()
    
    
    // Minting a million coins for yourself!
    /*
    So earlier we mentioned that the total supply is 10M coins. We’ve minted(taken up) 1M coins into our own address. How will the next 9M coins get into circulation?

    You can use whatever logic you want but we’re going to use a very simple logic. Every 10th block on Ethereum, 10 coins will be rewarded into the wallet of a person on a first come first serve basis.

    A new block is created on ethereum about once every 20 seconds.

    So every 200 seconds one lucky person will be able to see that no one has claimed the reward for a certain 10th block & claim it.

    The process for claiming these rewards are

    Check if the current block number is a multiple of 10
    Check if the reward has already been given to someone
    If the reward has not yet been given out, claim it!
    We’ll call this process of digging for rewards as mining.
    
    */
    
    
    function mine() public returns(bool success){
        if(blockMined[block.number]){ // rewards of this block already mined
            return false;
        }
        if(block.number % 10 != 0 ){ // not a 10th block
            return false;
        }
        
        balances[msg.sender] = balances[msg.sender] + 10*1e8;
        totalMinted = totalMinted + 10*1e8;
        blockMined[block.number] = true;
        
        return true;
    }
    
    function getCurrentBlock() public view returns(uint){
        return block.number;
    }
    
    function isMined(uint blockNumber) public view returns(bool) {
        return blockMined[blockNumber];
    }
    
}
