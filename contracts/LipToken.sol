// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Importación de los Smart Contract: ERC721.sol y Ownable.sol
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// Creación del Smart Contract para el Videojuego NFT
contract LipToken is ERC721, Ownable {

    // Constructor de mi Smart Contract
    constructor (string memory _name, string memory _symbol)
    ERC721(_name, _symbol) {}

    // ============================================
    // Declaraciones iniciales

    // Contador de tokens NFT
    uint256 COUNTER;
    // Fijación en el precio de los Tokens NFT
    uint256 fee = 0.001 ether;
    string sex;
    uint level;
    uint cant;
    // Estructura de datos con las propiedades del lip (labio)
    struct Lip {
        string name;
        uint256 id;
        uint256 dna;
        uint level;
        uint8 rarity;
        string sex;
        uint vida;
        uint habil;
        uint fuerza;
        uint defenza;
        uint poder;
    }
    // Estructura de almacenamiento
    Lip [] public lips;
    // Declaración de un evento 
    event NewLip(address indexed owner, uint256 id, uint256 dna);

    // ============================================
    // Funciones de ayuda 

    // Asignación de un número aleatorio
    function _createRandomNum(uint256 _mod) internal view returns (uint256) {
        uint256 randomNum = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        return randomNum % _mod; 
    }

    // Actualización del precio del Token NFT
    function updateFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }

    // Extracción de los ethers del Smart Contract hacia el Owner 
    function withdraw() external payable onlyOwner {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }

    // Creación del Token NFT (AniMons)
    function _createLip(string memory _name, uint _cant) internal {
        cant = _cant;                
        uint randDna = _createRandomNum(10**16);
        uint8 randRarity = uint8(_createRandomNum(100));
        uint sexo = _createRandomNum(33*33);   
         uint256  vida = block.timestamp/100000000;   


        for (uint256 i = 1; i <= cant; i++){               
            vida = vida*7;
            randDna = randDna *35;
            randRarity = randRarity*3;
            
        //uint256 randomNum2 = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));                                               
            if(level == 0){level=1;}
            if (sexo % 2 == 0) {sex="F";} else {sex="M";}
            uint habil = 5;
            uint fuerza = 5;
            uint defenza = 5;
            uint poder = 5;            
            //uint256 vida = randomNum2/100000000;                
        Lip memory newLip = Lip(_name, COUNTER, randDna, level, randRarity, sex, vida, habil, fuerza, defenza, poder);
        lips.push(newLip);             
        _safeMint(msg.sender, COUNTER);
        emit NewLip(msg.sender, COUNTER, randDna);
        
        vida = vida /15;
        randDna = randDna /25;
        randDna= randDna * 7;
        COUNTER++;
        randRarity = randRarity /10;
        randRarity = randRarity /5;
        }
    }

    // ============================================
    
    
    
    // Creación de un labio aleatorio
    function createRandomLip(string memory _name, uint _cant) public payable {
        require(msg.value >= fee);     
        _createLip(_name, _cant);        
    }
    // Obtención de todos los lips (labios)
    function getLips() public view returns (Lip [] memory) {
        return lips;
    }

    // Visualizar el balance del Smart Contract 
    function moneySmartContract() public view returns (uint256){
        return address(this).balance;
    }

    // Visualizar la dirección del Smart Contract
    function addressSmartContract() public view returns (address) {
        return address(this);
    }

    // Obtención de los tokens NFT usuario
    function getOwnerLips(address _owner) public view returns (Lip [] memory) {
        Lip [] memory result = new Lip [] (balanceOf(_owner));
        uint256 counter = 0;
        for (uint256 i = 0; i <lips.length; i++) {
            if (ownerOf(i) == _owner) {
                result[counter] = lips[i];
                counter++;
            }
        }
        return result;
    }

    // Subir de nivel los tokens NFT 
    function levelUp(uint256 _lipId) public payable {
        require(ownerOf(_lipId) == msg.sender);
         require(msg.value >= fee);
        Lip storage lip = lips[_lipId];
        lip.level++;
    }

 // Subir Vida los tokens NFT 
    function vidaUp(uint256 _lipId) public payable {
        require(ownerOf(_lipId) == msg.sender);
         require(msg.value >= fee);
        Lip storage lip = lips[_lipId];
        uint auvi;
        auvi = 15;
        lip.vida = lip.vida + auvi;
    }


    

    // Subir habilidad los tokens NFT 
    function habilUp(uint256 _lipId) public payable {
        require(ownerOf(_lipId) == msg.sender);
         require(msg.value >= fee);
        Lip storage lip = lips[_lipId];
        uint auvi;
        auvi = 3;
        lip.habil = lip.habil + auvi;
    }

    // Subir Fuerza los tokens NFT 
    function fuerzaUp(uint256 _lipId) public payable {
        require(ownerOf(_lipId) == msg.sender);
         require(msg.value >= fee);
        Lip storage lip = lips[_lipId];
        uint auvi;
        auvi = 5;
        lip.fuerza = lip.fuerza + auvi;
    }

    // Subir Defenza los tokens NFT 
    function defenzaUp(uint256 _lipId) public payable {
        require(ownerOf(_lipId) == msg.sender);
         require(msg.value >= fee);
        Lip storage lip = lips[_lipId];
        uint auvi;
        auvi = 3;
        lip.defenza = lip.defenza + auvi;
    }

    // Subir Poder los tokens NFT 
    function poderUp(uint256 _lipId) public payable {
        require(ownerOf(_lipId) == msg.sender);
         require(msg.value >= fee);
        Lip storage lip = lips[_lipId];
        uint auvi;
        auvi = 10;
        lip.poder = lip.poder + auvi;
    }


}