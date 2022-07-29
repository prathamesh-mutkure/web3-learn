import { EthProvider } from "./contexts/EthContext";

import "./App.css";
import KYCPage from "./components/KYC/KycPage";
import BuyTokens from "./components/Tokens/BuyTokens";

function App() {
  return (
    <EthProvider>
      <div id="App">
        <div className="container">
          <KYCPage />
          <hr />
          <hr />
          <BuyTokens />
        </div>
      </div>
    </EthProvider>
  );
}

export default App;
