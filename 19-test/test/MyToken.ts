const { expect } = require("chai");
const hre = require("hardhat");

describe("MyToken", function () {
  let myToken: any;
  let owner: any;
  let addr1: any;
  let addr2: any;

  beforeEach(async function () {
    // 获取签名者
    const signers = await hre.ethers.getSigners();
    [owner, addr1, addr2] = signers;

    // 部署合约
    const MyToken = await hre.ethers.getContractFactory("MyToken");
    myToken = await MyToken.deploy(owner.address);
    await myToken.waitForDeployment();
  });

  describe("部署", function () {
    it("应该设置正确的名称和符号", async function () {
      expect(await myToken.name()).to.equal("Elen");
      expect(await myToken.symbol()).to.equal("Elen_MTK");
    });

    it("应该设置正确的小数位数", async function () {
      expect(await myToken.decimals()).to.equal(18);
    });

    it("应该给部署者铸造初始代币", async function () {
      const ownerBalance = await myToken.balanceOf(owner.address);
      expect(ownerBalance).to.equal(hre.ethers.parseEther("10000000"));
    });

    it("应该设置正确的总供应量", async function () {
      const totalSupply = await myToken.totalSupply();
      expect(totalSupply).to.equal(hre.ethers.parseEther("10000000"));
    });
  });

  describe("铸造", function () {
    it("应该允许铸造新代币", async function () {
      const mintAmount = hre.ethers.parseEther("1000");
      await myToken.mint(addr1.address, mintAmount);
      
      const addr1Balance = await myToken.balanceOf(addr1.address);
      expect(addr1Balance).to.equal(mintAmount);
    });

    it("铸造后应该增加总供应量", async function () {
      const initialSupply = await myToken.totalSupply();
      const mintAmount = hre.ethers.parseEther("1000");
      
      await myToken.mint(addr1.address, mintAmount);
      
      const newSupply = await myToken.totalSupply();
      expect(newSupply).to.equal(initialSupply + mintAmount);
    });
  });

  describe("转账", function () {
    it("应该能够转账代币", async function () {
      const transferAmount = hre.ethers.parseEther("100");
      
      await myToken.transfer(addr1.address, transferAmount);
      
      const addr1Balance = await myToken.balanceOf(addr1.address);
      expect(addr1Balance).to.equal(transferAmount);
    });

    it("转账后应该减少发送者余额", async function () {
      const initialBalance = await myToken.balanceOf(owner.address);
      const transferAmount = hre.ethers.parseEther("100");
      
      await myToken.transfer(addr1.address, transferAmount);
      
      const newBalance = await myToken.balanceOf(owner.address);
      expect(newBalance).to.equal(initialBalance - transferAmount);
    });
  });

  describe("授权", function () {
    it("应该能够授权代币", async function () {
      const approveAmount = hre.ethers.parseEther("500");
      
      await myToken.approve(addr1.address, approveAmount);
      
      const allowance = await myToken.allowance(owner.address, addr1.address);
      expect(allowance).to.equal(approveAmount);
    });

    it("应该能够使用授权进行转账", async function () {
      const approveAmount = hre.ethers.parseEther("500");
      const transferAmount = hre.ethers.parseEther("200");
      
      // 授权
      await myToken.approve(addr1.address, approveAmount);
      
      // 使用授权转账
      await myToken.connect(addr1).transferFrom(owner.address, addr2.address, transferAmount);
      
      const addr2Balance = await myToken.balanceOf(addr2.address);
      expect(addr2Balance).to.equal(transferAmount);
      
      // 检查剩余授权
      const remainingAllowance = await myToken.allowance(owner.address, addr1.address);
      expect(remainingAllowance).to.equal(approveAmount - transferAmount);
    });
  });
});
