const { expect } = require("chai");

describe("Token contract", function () {
    let Token;
    let hardhatToken;
    let owner;
    let addr1;

    beforeEach(async function () {
        Token = await ethers.getContractFactory("UselessToken");
        [owner, addr1] = await ethers.getSigners();
        hardhatToken = await Token.deploy();
    });

    describe("Deployment", function () {
        it("Should assign the total supply of tokens to the owner", async function () {
            const ownerBalance = await hardhatToken.balanceOf(owner.address);
            expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
        });
    });

    describe("Transactions", function () {
        it("Should transfer tokens between accounts", async function () {
            await hardhatToken.transfer(addr1.address, 50);
            addr1Balance = await hardhatToken.balanceOf(addr1.address)
            expect(addr1Balance).to.equal(50);
        });
    });
});