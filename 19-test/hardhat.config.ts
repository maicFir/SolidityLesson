import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";
import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    hardhat: {},
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
      accounts:
        process.env.SEPOLIA_PRIVATE_KEY !== undefined
          ? [process.env.SEPOLIA_PRIVATE_KEY]
          : [],
    },
  },
};

export default config;
