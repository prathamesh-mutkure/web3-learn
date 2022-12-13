import { dbank } from "../../declarations/dbank";

async function updateBalance() {
  const balance = await dbank.checkBalance();

  window.document.getElementById("value").innerText = balance.toFixed(2);
}

window.addEventListener("load", async function () {
  await updateBalance();
});

document
  .querySelector("form")
  .addEventListener("submit", async function (event) {
    event.preventDefault();

    const topUpField = document.getElementById("input-amount");
    const withdrawField = document.getElementById("withdrawal-amount");
    const submitButton = document.getElementById("submit-btn");

    const inputAmount = parseFloat(topUpField.value);
    const outputAmount = parseFloat(withdrawField.value);

    submitButton.setAttribute("disabled", true);

    if (inputAmount && inputAmount.toString().length !== 0) {
      await dbank.topUp(inputAmount);
    }

    if (outputAmount && outputAmount.toString().length !== 0) {
      await dbank.withdraw(outputAmount);
    }

    await dbank.compound();

    await updateBalance();

    topUpField.value = "";
    withdrawField.value = "";

    submitButton.removeAttribute("disabled");
  });
