App = {
  contracts: {},
  init: async () => {
    await App.loadWeb3();
    await App.loadAccount();
    await App.loadContract();
    await App.render();    
    await App.getLips();
  },

  loadWeb3: async () => {
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      await window.ethereum.request({ method: "eth_requestAccounts" });
      //alert('estoy aqui');
    } else if (web3) {
      web3 = new Web3(window.web3.currentProvider);
      //alert('estoy aca');
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
  

  createRandomLip: async (nombre, cant) => {
    const valueInWei = 1000000000000000000;
    try {
      const result = await App.lipsContract.createRandomLip(nombre, cant, {
        from: App.account,    
        value: valueInWei    
      });
      console.log(result.logs[0]);
      window.location.reload();
    } catch (error) {
      console.error(error);
    }
  },



  getLips: async () => { 

    const LipsCounter = await App.lipsContract.getLips();
      
        
    document.querySelector("#LipssList").innerHTML = html;

  },

};
