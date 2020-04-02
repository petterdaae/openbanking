# Open Banking

## Goals
* [x] Show accounts
* [x] Show transactions
* [ ] Transfer between accounts
* [ ] Categorize transactions and get an overview of spendings
* [ ] Automaitcally categorize transactions
* [ ] Add expected incomes and expenses and show status on future economy
* [ ] Split transactions

## Problems
### Showing the sum of transactions in a category within a timespan
* *Current solution*: Does not support this (only supports the total). This can be precomputed efficiently using cloud functions.
* *Possible solution*:  Precalculate each month. This can also be implemented efficiently.
* *Possible solution*: Fetch all transactions and compute the sum client-side. This will cause a lot of database reads.

