import { EthProvider } from "./contexts/EthContext";

import "./App.css";
import KYCPage from "./components/KYC/KycPage";

function App() {
  return (
    <EthProvider>
      <div id="App">
        <div className="container">
          <KYCPage />
        </div>
      </div>
    </EthProvider>
  );
}

export default App;
