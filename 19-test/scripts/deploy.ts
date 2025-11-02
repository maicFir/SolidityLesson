const hre = require("hardhat");

async function main() {
  // 获取部署者账户
  const signers = await hre.ethers.getSigners();
  const deployer = signers[0];

  // 获取部署者余额
  const balance = await deployer.provider.getBalance(deployer.address);
  console.log("部署者地址:", deployer.address);
  console.log("部署者余额:", hre.ethers.formatEther(balance), "ETH");

  // 部署 MyToken 合约
  console.log("\n开始部署 MyToken 合约...");
  const MyToken = await hre.ethers.getContractFactory("MyToken");
  const myToken = await MyToken.deploy(deployer.address);

  // 等待部署完成
  await myToken.waitForDeployment();

  // 获取合约地址
  const contractAddress = myToken.target || await myToken.getAddress();
  console.log("MyToken 合约已部署到:", contractAddress);

  // 验证合约基本信息
  const name = await myToken.name();
  const symbol = await myToken.symbol();
  const decimals = await myToken.decimals();
  const totalSupply = await myToken.totalSupply();
  const deployerBalance = await myToken.balanceOf(deployer.address);

  console.log("\n合约信息:");
  console.log("名称:", name);
  console.log("符号:", symbol);
  console.log("小数位数:", decimals);
  console.log("总供应量:", hre.ethers.formatEther(totalSupply));
  console.log("部署者代币余额:", hre.ethers.formatEther(deployerBalance));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });