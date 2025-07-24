// scripts/deploy.js
const hre = require("hardhat");

async function main() {
  const Hello = await hre.ethers.getContractFactory("Hello");
  const hello = await Hello.deploy();

  console.log("Hello deployed to:", hello.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
