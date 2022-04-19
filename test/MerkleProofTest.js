const { expect } = require("chai");
const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

describe("Merkle Proof Contract", function () {
    let MerkleContract;
    let hardhatMerkleContract;
    let owner;
    let addr1;
    let merkleWords = ["banana", "paper", "pen", "shovel", "science"];
    const leafNodes = merkleWords.map(word => keccak256(word));
    const merkleTree = new MerkleTree(leafNodes, keccak256, {sortPairs: true});
    const root = merkleTree.getRoot().toString('hex');
    const testWord = leafNodes[0];
    const hexProof = merkleTree.getHexProof(testWord);

    beforeEach(async function () {
        MerkleContract = await ethers.getContractFactory("MerkleTest");
        [owner, addr1] = await ethers.getSigners();
        hardhatMerkleContract = await MerkleContract.deploy();
    });

    describe("Test of the word", function () {
        it("Should check if the word is in tree", async function () {
            expect(await hardhatMerkleContract.treeCheck(hexProof, merkleWords[0])).to.equal(true);
        });
    });
});