import hre from "hardhat";

async function main() {
  console.log("测试 hre.viem 是否可用...");
  console.log("hre.viem:", !!hre.viem);
  
  if (hre.viem) {
    console.log("hre.viem 可用！");
    try {
      const publicClient = await hre.viem.getPublicClient();
      console.log("公共客户端获取成功");
      
      const walletClients = await hre.viem.getWalletClients();
      console.log("钱包客户端数量:", walletClients.length);
    } catch (error) {
      console.error("获取客户端时出错:", error);
    }
  } else {
    console.log("hre.viem 不可用");
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });