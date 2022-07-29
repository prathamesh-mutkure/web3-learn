const actions = {
  init: "INIT",
};

const initialState = {
  tokenArtifact: null,
  tokenSaleArtifact: null,
  kycArtifact: null,

  web3: null,
  accounts: null,
  networkID: null,

  tokenContract: null,
  tokenSaleContract: null,
  kycContract: null,

  tokenBalance: 0,
};

const reducer = (state, action) => {
  const { type, data } = action;
  switch (type) {
    case actions.init:
      return { ...state, ...data };
    default:
      throw new Error("Undefined reducer action type");
  }
};

export { actions, initialState, reducer };
