import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

/*

    STABLE VARIABLE:
    - Normally, variables loose their state and are re-initialized everytime code is rerun or redeployed
    - We use databases to make it persistant 
    -
    - In Motoko, we can mark the variable as "stable"
    - And it's value or state will be persisted on next deploy
    - These are known as "Stable" variables
    -
    - The default variable work normally
    - And are called "Flexible" variable

*/

actor DBank {

  // Declaring and Initializing variable
  stable var currentBalance : Float = 300;

  // Mutating Value
  // currentBalance := 100;

  // Constants
  let id = 1234567890;
  Debug.print(debug_show (id));

  // Time Module
  stable var startTime = Time.now();
  Debug.print(debug_show (startTime));

  public func topUp(amount : Float) {
    currentBalance += amount;
    Debug.print(debug_show (currentBalance));
  };

  public func withdraw(amount : Float) {
    let temp : Float = currentBalance - amount;

    if (temp >= 0) {
      currentBalance -= amount;
      Debug.print(debug_show (currentBalance));
    } else {
      Debug.print("Failed: cannot withdraw more amount than the balance");
    };
  };

  // Query function
  public query func checkBalance() : async Float {
    return currentBalance;
  };

  public func compound() {
    let currentTime = Time.now();

    let timeElapsedInNs = currentTime - startTime;
    let timeElapsedInSec = timeElapsedInNs / 1000000000;

    currentBalance := currentBalance * (1.01 ** Float.fromInt(timeElapsedInSec));

    startTime := currentTime;
  };
};
