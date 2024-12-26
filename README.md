# Bank-Database

## Scenaio

### The bank is organized into branches, and each branch has a unique branch number, branch name, branch address, and postal code. A branch serves a number of customers in the city it operates in; however, a customer can also access services from branches in other cities. Nonetheless, each customer is registered with the branch in the city where they reside.

Each branch has a number of employees assigned exclusively to it. Each employee has a unique employee ID, first and last name, position, phone number, and hiring date. Additionally, each branch is managed by a single manager.

Customers are assigned unique customer IDs and have associated personal information, including their full name, date of birth, and gender. A customer can hold one or more bank accounts.

A bank account has a unique account ID, account opening date, monthly fees, and current balance. Accounts can be classified as either current or savings accounts. Each current account has a daily transfer limit and is associated with one debit card, which has a daily withdrawal limit. Savings accounts earn interest and are linked to one savings card, which has a specific monthly transaction limit. Both cards have a unique card number, an expiration date, and a status (either "blocked" or "active"). Both account types can perform transactions, but only current accounts can initiate loans. Moreover, current accounts can transfer funds to other current or savings accounts, whereas savings accounts cannot.

Each loan has a unique loan number, loan type (personal, student, or business), amount, interest rate, start date, and due date. Each loan type has a unique type ID, name, and associated loan limit. Loan repayments are tracked with a unique repayment ID, the amount repaid, and the date of repayment.

Transactions are also recorded, and each transaction has a unique transaction ID, amount, description (such as "in," "out," or "between accounts"), and date. Transactions can be classified as either current transactions (made by a current account) or savings transactions (made by a savings account). For current accounts, transactions are free if the account belongs to a student. Savings accounts are allowed up to three emergency transactions annually that exceed the account’s transaction limit.

