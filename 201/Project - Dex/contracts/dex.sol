pragma solidity =0.8.17;

import "./wallet.sol";

contract Dex is Wallet {

    enum Side {
        BUY,
        SELL
    }

    struct Order {
        uint256 id;
        address trader;
        Side side;
        bytes32 ticker;
        uint256 amount;
        uint256 price;
    }

    uint256 public nextOrderId = 0;

    mapping(bytes32 => mapping(uint256 => Order[]))  orderBook;

    function getOrderBook(bytes32 ticker,Side side) view public returns(Order[] memory) {
        return orderBook[ticker][uint256(side)];
    }

    function createLimitOrder(Side side,bytes32 ticker,uint256 amount,uint256 price) public {
        if(side == Side.BUY) {
            require(balances[msg.sender]["ETH"] >= amount * price);
        }
        else if(side == Side.SELL) {
            require(balances[msg.sender][ticker] >= amount );
        }

        Order[] storage orders = orderBook[ticker][uint(side)];
        orders.push(
            Order(nextOrderId, msg.sender,side,ticker,amount,price)
        );
        nextOrderId++;

        //Bubble sort
        if(side==Side.BUY){

        }else if(side == Side.SELL){

        }

    }
    
    
}