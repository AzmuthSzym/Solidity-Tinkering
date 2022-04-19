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
            console.log(hardhatGameContract.gameStarted.call());
            expect(await hardhatGameContract.gameStarted.call()).to.equal(true);
            //expect(await hardhatGameContract.gameStarted).to.equal(true);
        });
    });
});