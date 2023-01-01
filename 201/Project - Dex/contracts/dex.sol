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
        uint256 filled;
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
            Order(nextOrderId, msg.sender,side,ticker,amount,price,0)
        );
        nextOrderId++;

        //Bubble sort
        uint256 i = orders.length > 0 ?  orders.length -1 : 0;

        if(side == Side.BUY){
            while(i > 0) {

                if(orders[i-1].price > orders[i].price){
                    break;
                }

                Order memory orderToMove = orders[i-1];
                orders[i-1] = orders[i];
                orders[i] = orderToMove;
                i--;
            }
        }
        else if(side == Side.SELL){
             while(i > 0) {

                if(orders[i-1].price < orders[i].price){
                    break;
                }

                Order memory orderToMove = orders[i-1];
                orders[i-1] = orders[i];
                orders[i] = orderToMove;
                i--;
            }
        }

    }

    function createMarketOrder(Side side, bytes32 ticker, uint256 amount) public{
         
        if(side == Side.SELL){
            require(balances[msg.sender][ticker] >= amount, "Insuffient balance");
        }

        uint256 orderBookSide = side == Side.BUY ? 1 : 0;
        Order[] storage orders = orderBook[ticker][orderBookSide];

        uint256 totalFilled = 0;

        for (uint256 i = 0; i < orders.length && totalFilled < amount; i++) {
            uint256 leftToFill = amount - totalFilled;
            uint256 availableToFill = orders[i].amount - orders[i].filled;
            uint256 filled = 0;
            if(availableToFill > leftToFill){
                filled = leftToFill; //Fill the entire market order
            }
            else{ 
                filled = availableToFill; //Fill as much as is available in order[i]
            }

            totalFilled = totalFilled + filled;
            orders[i].filled = orders[i].filled  + filled;
            uint256 cost = filled * orders[i].price;

            if(side == Side.BUY){
                //Verify that the buyer has enough ETH to cover the purchase (require)
                require(balances[msg.sender]["ETH"] >= cost);
                //msg.sender is the buyer
                balances[msg.sender][ticker] = balances[msg.sender][ticker] + filled;
                balances[msg.sender]["ETH"] = balances[msg.sender]["ETH"] - cost;
                
                balances[orders[i].trader][ticker] = balances[orders[i].trader][ticker] - filled;
                balances[orders[i].trader]["ETH"] = balances[orders[i].trader]["ETH"] + cost;
            }
            else if(side == Side.SELL){
                //msg.sender is the seller
                balances[msg.sender][ticker] = balances[msg.sender][ticker] - filled;
                balances[msg.sender]["ETH"] = balances[msg.sender]["ETH"] + cost;
                
                balances[orders[i].trader][ticker] = balances[orders[i].trader][ticker] + filled;
                balances[orders[i].trader]["ETH"] = balances[orders[i].trader]["ETH"] - cost;
            }
            
        }

        //Remove 100% filled orders from the orderbook
        while(orders.length > 0 && orders[0].filled == orders[0].amount){
        //Remove the top element in the orders array by overwriting every element
        // with the next element in the order list
            for (uint256 i = 0; i < orders.length - 1; i++) {
                orders[i] = orders[i + 1];
            }
            orders.pop();
        }
    }
    
    
}