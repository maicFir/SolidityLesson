import React, {useEffect, useRef} from "react";
import { useState } from "react";
import {ethers, BrowserProvider, Contract} from "ethers";
import abiJson from "./abi.json"
import TokenAbi from "./token_abi.json"

const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const tokenContractAddress = "0x322813Fd9A801c5507c9de605d63CEA4f2CE6c44";
const abi = abiJson.abi;
const tokenAbi = TokenAbi.abi;




function App() {
  const [count, setCount] = useState(0);
  const contractRef = useRef(null);
  const contractRef2 = useRef(null);
  const [address, setAddress] = useState("");
  const [balance,setBalance] = useState("");

  const [to, setTo] = useState("0x959922bE3CAee4b8Cd9a407cc3ac1C251C2007B1");
  const [amount, setAmount] = useState("");

  const getCount = async () => {
    const count = await contractRef.current.get();
    console.log(count);
    setCount(count);
  }
  const increment = async () => {
    const tx = await contractRef.current.increment();
    await tx.wait();
    await getCount();
  }
  const desc = async () => {
    const tx = await contractRef.current.desc();
    await tx.wait();
    await getCount();
  }
  const isWalletAuthorized = async () => {
    const accounts = await window.ethereum.request({ method: "eth_accounts" });
    return accounts.length > 0;
  };

  const getMetaMaskProvider = () => {
    if (window.ethereum?.providers?.length) {
      return window.ethereum.providers.find(p => p.isMetaMask);
    }
    // fallback：如果没冲突插件，就直接返回
    return window.ethereum?.isMetaMask ? window.ethereum : null;
  };


  const checkIfWalletConnected = async () => {
    try {
      if (isWalletAuthorized()) {
        const provider = new BrowserProvider(window.ethereum);
        const signer = await provider.getSigner();
        const address = await signer.getAddress();
        setAddress(address);
        const contract = new Contract(contractAddress, abi, signer);
        const tokenTract = new Contract(tokenContractAddress, tokenAbi, signer);
        const resCode = await provider.getCode(tokenContractAddress)
        console.log("code", resCode);
        contractRef.current = contract;
        contractRef2.current = tokenTract;
        tokenTract.on("Transfer", (from, to, amount) => {
            console.log("Transfer event")
            console.log("from, to, amount", from, to, amount)
          })
          tokenTract.on("Balance", (account, balance, senderBalance) => {
            console.log("Balance event")
            console.log("from, to, amount", account, balance, senderBalance)
          }) 
       
        await getCount();
        handleGetBalance();
      }
    } catch (err) {
      console.warn("检查钱包失败", err);
    }
  };
  useEffect(() => {
    checkIfWalletConnected();
    
  }, [])
  const handleWalletConnect = async () => {
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new BrowserProvider(window.ethereum); 
    const signer = await provider.getSigner();
    const address = await signer.getAddress();
    console.log(address, "===address");
    setAddress(address);
  }
  const handleDiscontent = () => {
    window.ethereum.request({ method: "wallet_requestPermissions", params: [{ eth_accounts: {} }] });
  }
  const handleTransfer = async () => {
    const tx = await contractRef2.current.transfer(to, BigInt(amount));
    await tx.wait();
    console.log(tx)
    handleGetBalance();
  }
  const handleGetBalance =  () => {
    if (!to) {
        return;
    }
    contractRef2.current.getBalance(to).then((tx) => {
      setBalance(tx.toString())
    })
  }
  return (
    <div className="app">
            <h1>Hello Contract</h1>
            <p onClick={handleWalletConnect}>Connect Wallet</p>
            <button onClick={handleDiscontent}>discontent wallet</button>
            <p>address:{address}</p>
            <p>Count: <span id="count">{count}</span></p>
            <button onClick={getCount}>Get</button>
            <button onClick={increment}>Increment</button>
            <button onClick={desc}>Decrement</button>

            <hr />
            <input type="text" value={to} onChange={(e) => setTo(e.target.value)} />
            <input type="text" value={amount} onChange={(e) => setAmount(e.target.value)} />
            <p>balance:{balance}</p>
            <button onClick={handleTransfer}>Transfer</button>
            <button onClick={handleGetBalance}>GetBalance</button>
    </div>
  );
}

export default App;