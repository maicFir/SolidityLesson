const { expect } = require("chai");

describe("Hello Contract", function () {
  it("Should initialize and increment/desc correctly", async function () {
    const Hello = await ethers.getContractFactory("Hello");
    const hello = await Hello.deploy();
    await hello.deployed();

    expect(await hello.get()).to.equal(0);

    await hello.increment();
    expect(await hello.get()).to.equal(1);

    await hello.desc();
    expect(await hello.get()).to.equal(0);
  });
});
