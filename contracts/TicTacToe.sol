////SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

/// @title A contract implementing TicTacToe game
/// @author Azmuth
/// @notice Player can start a game and make one move before the action of the second player is required
/// @notice This behaviour was expected but it can easily be changed so that only when two players joined the game they can make their moves
/// @notice I am also debating whether I should add a variable called "winner" so that it will be more accessible
contract TicTacToe {
    uint8[9] public board = [0,0,0,0,0,0,0,0,0];
    address public player1;
    address public player2;
    bool public gameStarted = false;
    uint public gamePlayedCount = 0;
    uint public move = 1;

    modifier gameActive {
        require(gameStarted == true, "Game hasn't started");
        _;
    }

    function startGame() public {
        require(gameStarted == false, "Game has already started, use joinGame()");
        player1 = msg.sender;
        gameStarted = true;
    }

    function joinGame() public gameActive {
        player2 = msg.sender;
    }

    /// @notice Execute move given by the player
    /// @dev Winner is the player that has moved before
    /// @dev move=1 -> player2 has won, move=2 -> player1 has won
    /// @param boardPlace A position (number) passed by the player
    /// @return true if a move has been made, false is the move was invalid and couldnt be executed
    function makeMove(uint boardPlace) public gameActive returns(bool) {
        if(checkWinner() == true) 
        {
            gameStarted = false;
            gamePlayedCount++;
        }
        if (validateMove(boardPlace) == false) return false; 
        if(move == 1 && msg.sender == player1)
        {
            board[boardPlace] = 1;
            move = 2;
            return true;
        }
        else if(move == 2 && msg.sender == player2)
        {
            board[boardPlace] = 2;
            move = 1;
            return true;
        }
        else {
            return false;
        }
    }

    /// @notice validate if the position given by the player is withing the boundaries
    /// @param place A position (number) passed by the player
    /// @return true if the position is correct and false if it isn't
    function validateMove(uint place) internal view returns(bool) {
        if(place < 0 || place > 8) return false;
        if(board[place] != 0) return false;
        return true;
    }

    // 0 1 2
    // 3 4 5
    // 6 7 8
    uint[][] winninPos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]];

    /// @notice Check if a player has won the game by looking for possible winning combinations
    /// @return true if a player has won, false if the winner was not found
    function checkWinner() public view returns(bool)
    {
        for(uint i = 0; i < 8; i++)
        {
            uint[] memory temp = winninPos[i];
            if(board[temp[0]] != 0 && board[temp[0]] == board[temp[1]] && board[temp[0]] == board[temp[2]]) return true;
        }

        return false;
    }
}