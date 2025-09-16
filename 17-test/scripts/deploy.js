// scripts/deploy.js
const hre = require("hardhat");

async function main() {
  const Hello = await hre.ethers.getContractFactory("Hello");
  const hello = await Hello.deploy();

  const Token = await hre.ethers.getContractFactory("Token");
  const token = await Token.deploy();

  console.log("Hello deployed to:", hello.target);
  console.log("Token deployed to:", token.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
