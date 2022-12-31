pragma solidity =0.8.17;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
contract Wallet is Ownable{

    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }

    mapping(bytes32 => Token) public tokenMapping;
    bytes32 [] public tokenList;
    
    modifier tokenExist(bytes32 _ticker) {
        require(tokenMapping[_ticker].tokenAddress != address(0),"Token does not exist");
        _;
    }

    mapping(address => mapping(bytes32 => uint256)) public balances;

    function addToken(bytes32 ticker,address tokenAddress) onlyOwner external {
        tokenMapping[ticker] = Token(ticker,tokenAddress);
        tokenList.push(ticker);
    }

    function deposit(uint256 amount , bytes32 ticker) tokenExist(ticker) external {
        balances[msg.sender][ticker] = balances[msg.sender][ticker] + amount;
        // IERC20(tokenMapping[ticker].tokenAddress).approve(address(this),amount);
        IERC20(tokenMapping[ticker].tokenAddress).transferFrom(msg.sender, address(this),amount);


    }


    function withdraw(uint256 amount , bytes32 ticker) tokenExist(ticker) external {
        require( balances[msg.sender][ticker] >= amount,"Balnce not sufficient");

        balances[msg.sender][ticker] = balances[msg.sender][ticker] - amount;
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender, amount);
    }

    
    
}