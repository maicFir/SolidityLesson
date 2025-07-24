import React, {useEffect, useRef} from "react";
import { useState } from "react";
import {ethers, BrowserProvider, Contract} from "ethers";
import abiJson from "./abi.json"

const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
const abi = abiJson.abi;




function App() {
  const [count, setCount] = useState(0);
  const contractRef = useRef(null);
  const [address, setAddress] = useState("")
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
        contractRef.current = contract;
        await getCount();
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
    </div>
  );
}

export default App;