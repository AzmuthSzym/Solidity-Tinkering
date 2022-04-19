const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

let merkleWords = ["banana", "paper", "pen", "shovel", "science"]

const leafNodes = merkleWords.map(word => keccak256(word));
const merkleTree = new MerkleTree(leafNodes, keccak256, {sortPairs: true});
const testWord = leafNodes[0];
const hexProof = merkleTree.getHexProof(testWord);
const root = merkleTree.getRoot().toString('hex');

console.log('Generated Merkle Tree\n',merkleTree.toString());
console.log("-----------------------------------------");
console.log(root);
console.log("-----------------------------------------");
console.log(hexProof[0]);
console.log("-----------------------------------------");
//0821bd02648ece087f32e3654e1a0289eeb7406d3652b477063dc91056f8fc8f