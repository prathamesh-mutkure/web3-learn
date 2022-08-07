import { EthProvider } from "./contexts/EthContext";

import "./App.css";
import KYCPage from "./components/KYC/KycPage";
import BuyTokens from "./components/Tokens/BuyTokens";
import TokenSupply from "./components/Tokens/TokenSupply";

function App() {
  return (
    <EthProvider>
      <div id="App">
        <div className="container">
          <KYCPage />
          <hr />
          <TokenSupply />
          <hr />
          <hr />
          <BuyTokens />
        </div>
      </div>
    </EthProvider>
  );
}

export default App;
