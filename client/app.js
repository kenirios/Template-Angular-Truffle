App = {
  contracts: {},
  init: async () => {
    await App.loadWeb3();
    await App.loadAccount();
    await App.loadContract();
    await App.render();    
  },
  loadWeb3: async () => {
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      await window.ethereum.request({ method: "eth_requestAccounts" });
    } else if (web3) {
      web3 = new Web3(window.web3.currentProvider);
    } else {
      console.log(
        "MetaMask no esta instaldo, por favor instale metamas para Jugar"
      );
    }
  },
  loadAccount: async () => {
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    App.account = accounts[0];
    console.log(App.account = accounts[0]);
  },
  loadContract: async () => {
    try {
      const res = await fetch("LipToken.json");
      const lipsContractJSON = await res.json();
      App.contracts.LipsContract = TruffleContract(lipsContractJSON);
      App.contracts.LipsContract.setProvider(App.web3Provider);      
      App.lipsContract = await App.contracts.LipsContract.deployed();
    } catch (error) {
      console.error(error);
    }
  },
  render: async () => {
    document.getElementById("account").innerText = App.account;
  },
  
};
