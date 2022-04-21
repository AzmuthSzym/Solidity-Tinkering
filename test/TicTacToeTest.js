const { expect } = require("chai");

describe("TicTacToe Game Contract", function () {
    let GameContract;
    let hardhatGameContract;
    let owner;
    let addr1;

    beforeEach(async function () {
        GameContract = await ethers.getContractFactory("TicTacToe");
        [owner, addr1] = await ethers.getSigners();
        hardhatGameContract = await GameContract.deploy();
    });

    describe("Game initiation", function () {
        it("Should start the game", async function () {
            const startGame = await hardhatGameContract.startGame();
            expect(await hardhatGameContract.gameStarted.call()).to.equal(true);
        });

        it("Should make second player join", async function () {
            const startGame = await hardhatGameContract.startGame();
            const joinGame = await hardhatGameContract.joinGame();
            expect(await hardhatGameContract.player2.call()).to.not.equal(0x0000000000000000000000000000000000000000);
            //console.log(hardhatGameContract.player2.call());
        });
    });
});