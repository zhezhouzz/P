param numAccounts: int;
param numClients: int;

machine TestDriver
{
  start state Init {
    entry {
      var i: int;
      var j: int;
      var accountId: int;
      var server: BankServer;
      var accountIds: seq[int];
      var initAccBalance: map[int, int];
    
      // randomly initialize the account balance for all clients
      // creates a random map from accountId's to account balance of size `numAccounts`
      i = default(int);
      while(i < numAccounts) {
        initAccBalance[i] = choose(100) + 10; // min 10 in the account
        /* Hint 1: Reduce the number of choices by changing the above line to the following:
          bankBalance[i] = choose(10) + 10; // min 10 in the account
        */
        i = i + 1;
      }

      // create bank server with the init account balance
      server = new BankServer(initAccBalance);
    
      // before client starts sending any messages make sure we
      // initialize the monitors or specifications
      announce eSpec_BankBalanceIsAlwaysCorrect_Init, initAccBalance;
    
      accountIds = keys(initAccBalance);
    
      // create the clients
      i = default(int);
      while(i < numClients) {
        j = choose(sizeof(accountIds));
        accountId = accountIds[j];
        accountIds -= (j);
        new Client((serv = server, accountId = accountId, balance = initAccBalance[accountId]));
        i = i + 1;
      }
    }
  }
}