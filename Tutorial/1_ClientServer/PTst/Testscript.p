/* This file contains three different model checking scenarios */

// assert the properties for the single client and single server scenario
test param (numClients in [1], numAccounts in [1]) tcSingleClient [main=TestDriver]:
  assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
  (union Client, Bank, { TestDriver });

// assert the properties for the two clients and single server scenario
test param (numClients in [2,3,4], numAccounts in [2,3,4]) assume (numClients <= numAccounts) tcMultipleClients [main=TestDriver]:
  assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
  (union Client, Bank, { TestDriver });

// assert the properties for the single client and single server scenario but with abstract server
test param (numClients in [1], numAccounts in [1]) tcAbstractServer [main=TestDriver]:
  assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
  (union Client, AbstractBank, { TestDriver });
