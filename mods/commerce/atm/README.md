# ATM Redo mod for Minetest

original by gpcf: git://gpcf.eu/atm.git

updated and improved by RB

## New

*Improved, high quality graphics.

*Added ability to process 50 and 100 minegeld denominations.

*Reduced 3 ATMs down to 1 that does everything.

This mod adds an ATM (Automatic Teller Machine) and MWT (Money Wire Transfer) 
designed to work with the currency mod and its minegeld banknotes. 
ATMs allow you to transfer money to your bank account and withdraw
various sums as needed.  The ATM allows to add and withdraw banknotes 
by ones, tens, and hundreds in denominations of 1, 5, 10, 50, and 100.  
MWTs allow you to send funds to other players registered with a bank account.

## Crafting ATM

```
[ steel ingot, mese crystal, steel ingot ]
[ glass,       10 MG note,   steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

If mesecons mod is not installed, then the mese wire in recipes is replaced by a copper ingot.

## Crafting MWT

An alternative system for transfering money from one player's account to another. The terminals
provide an interface for sending a specified amount (integer number) to a player (who must
have an existing banking account) and for checking the transfers to the account of the user of
the terminal. The history of transactions can be erased completely, and it is recommended to
clean it once the stored data are no longer of any relevance. Otherwise, the transaction history
is preserved indefinitely.

```
[ steel ingot, mese crystal, steel ingot ]
[ glass,       mese wire,    steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

To complete a Money Wire Transfer a player must provide the name of the recipient with an
existing banking account, the desired amount to be transfered, and a description of the 
payment (optional, but strongly recommended).
After entering those parameters the terminal checks their validity and if there is no problem,
the player is shown the final confirmation window. If the player confirms the payment, the specified
amount will be transfered immediately. At this point the transaction is final.
If there are errors, a corresponding message is shown in the chat, and the transaction is aborted.

