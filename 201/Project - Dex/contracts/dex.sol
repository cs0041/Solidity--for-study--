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
        bool buyOrder; //Side side;
        bytes32 ticker;
        uint256 amount;
        uint256 price;
    }

    mapping(bytes32 => mapping(uint256 => Order[]))  orderBook;

    function getOrderBook(bytes32 ticker,Side side) view public returns(Order[] memory) {
        return orderBook[ticker][uint256(side)];
    }

    // function createLimitOrder() {

    // }
    
    
}