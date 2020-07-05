

/****** 1. Create a Database  ******/
/******change the Collation to Cyrillic_General_100_CI_AS ******/
CREATE database Bank;

/******2. Create Tables ******/
/**Create Table Clients **/

CREATE TABLE Clients (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL
)

/**Create Table AccountType  **/

CREATE TABLE AccountTypes (
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

/**Create Table Accounts **/

CREATE TABLE Accounts (
	Id INT PRIMARY KEY IDENTITY,
	AccountTypeId INT FOREIGN KEY REFERENCES AccountTypes(Id),
	Balance DECIMAL(15, 2) NOT NULL DEFAULT(0),
	ClientId INT FOREIGN KEY REFERENCES Clients(Id)
)

/****** 3.Insert Example Data into our Database  ******/
/**Insert Data into Clients**/

INSERT INTO Clients (FirstName, LastName) VALUES
('Greta', 'Andersson'),
('Peter', 'Pettersson'),
('Mel', 'Gibson'),
('Maria', 'Danielsson')

/**Insert Data into AccountTypes**/

INSERT INTO AccountTypes (Name) VALUES
('Checking'),
('Savings')

/**Insert Data into Accounts**/

INSERT INTO Accounts (ClientId, AccountTypeId, Balance) VALUES
(1, 1, 175),
(2, 1, 275.56),
(3, 1, 138.01),
(4, 1, 40.30),
(4, 2, 375.50)



/******4.Create a simple View  ******/
/**Create view name "v_ClientBalances" **/

CREATE VIEW v_ClientBalances AS
SELECT (FirstName + ' ' + LastName) AS [Name], 
  (AccountTypes.Name) AS [Account Type], Balance 
FROM Clients
JOIN Accounts ON Clients.Id = Accounts.ClientId
JOIN AccountTypes ON AccountTypes.Id = Accounts.AccountTypeId



/**Check everything  The v_ClientBalances view **/

SELECT * FROM v_ClientBalances;



/******5.Create a Function  ******/

/**Create Function name "f_CalculateTotalBalance " **/

CREATE FUNCTION f_CalculateTotalBalance (@ClientID INT)
RETURNS DECIMAL(15, 2)
BEGIN
	DECLARE @result AS DECIMAL(15, 2) = (
	  SELECT SUM(Balance) 
	  FROM Accounts WHERE ClientId = @ClientID
	)	
  RETURN @result
END

/**Check Function, client ID is 4  **/

SELECT dbo.f_CalculateTotalBalance(4) AS Balance


/******6.Create Procedures  ******/

/**Creates a new account for an existing client  **/

CREATE PROC p_AddAccount @ClientId INT, @AccountTypeId INT AS
INSERT INTO Accounts (ClientId, AccountTypeId) 
VALUES (@ClientId, @AccountTypeId)

/** Create or add a new savings account for our client with ID = 2 **/ 
p_AddAccount 2, 2

/** check if an account is added correctly**/

SELECT * FROM Accounts

/** Create Deposit Procedure to add input amount to the current balance**/

CREATE PROC p_Deposit @AccountId INT, @Amount DECIMAL(15, 2) AS
UPDATE Accounts
SET Balance += @Amount
WHERE Id = @AccountId


/** Create Withdraw procedure will subtract the given amount of money from the account
if the balance is enough and return an error message if it isn’t:**/

CREATE PROC p_Withdraw @AccountId INT, @Amount DECIMAL(15, 2) AS
BEGIN
	DECLARE @OldBalance DECIMAL(15, 2)
	SELECT @OldBalance = Balance FROM Accounts WHERE Id = @AccountId
	IF (@OldBalance - @Amount >= 0)
	BEGIN
		UPDATE Accounts
		SET Balance -= @Amount
		WHERE Id = @AccountId
	END
	ELSE
	BEGIN
		RAISERROR('Insufficient funds', 10, 1)
	END
END



/****** 7. Create Transactions Table and a Trigger  ******/

/** Create Transactions Table **/

CREATE TABLE Transactions (
	Id INT PRIMARY KEY IDENTITY,
	AccountId INT FOREIGN KEY REFERENCES Accounts(Id),
	OldBalance DECIMAL(15, 2) NOT NULL,
	NewBalance DECIMAL(15, 2) NOT NULL,
	Amount AS NewBalance - OldBalance,
	[DateTime] DATETIME2
)




/** Create a Trigger Name: tr_Transaction **/

CREATE TRIGGER tr_Transaction ON Accounts
AFTER UPDATE
AS
	INSERT INTO Transactions (AccountId, OldBalance, NewBalance, [DateTime])
	SELECT inserted.Id, deleted.Balance, inserted.Balance, GETDATE() FROM inserted
	JOIN deleted ON inserted.Id = deleted.Id


	/** Do some transactions, which should run our trigger**/

	p_Deposit 1, 25.00
GO

p_Deposit 1, 40.00
GO

p_Withdraw 2, 200.00
GO

p_Deposit 4, 180.00
GO


/** Finally, check and look the Transactions table to make sure that trigger is working. **/
SELECT * FROM Transactions;