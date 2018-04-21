
-- SQL queries 

/* SELECT [columns] FROM [table] - to select rows from a specific table */

	SELECT [columns] 
	FROM [table];

/* LIMIT [number_of_rows] - to SELECT (return) only a couple of rows from a query. 
Avoids to collect all rows.
Efficient when tables are big */

	SELECT [columns] 
	FROM [table]
	LIMIT [number_of_rows];

 /* ORDER BY [column] [ASC or DESC] - Sorts the data using the [columns] specified after ORDER BY.
 Data is order by default in ASCesnding order. If needed in DESCending order add DESC after the column.
 The [columns] = [column_A [ASC/ DESC] , column_B [ASC/ DESC],  ...] order int he query are important. The first column (column_A) sorts results first, then the second column (column_B) is bounded by column_A order to sort the data based on column_B, and so on until we sort data by all columns.
 */

	SELECT [columns]
	FROM [table]
	ORDER BY [column_A] [ASC / DESC]  [, column_B] [ASC / DESC] [, more columns if needed...]
 	LIMIT [number_of_rows];


/* WHERE [conditions] - allows to filter a set of results based on specific criteria using the [conditions] given. A couple of comparisons WHERE allows are:
	
	> (greater than) :  
		column > value; column > 'date_string'

	< (less than) : 
		column < value; column < 'date_string'

	>= (greater than or equal to) : 
		column >= value; column >= 'date_string'

	<= (less than or equal to) : 
		column <= value; column <= 'date_string'

	= (equal to) : 
		column = value; column = 'any_string'

	!= (not equal to): 
		column != value; column != 'any_string'

	like (similar to) : column like 'word%' 
	NOTE: % symbol is a wildcard that implies anything after word is also good, so word1, wordABCDE are also going to be accepted as values that meet a condition */	

	SELECT [columns]
	FROM [table]
	WHERE [conditions]
	ORDER BY [column_A] [ASC / DESC]  [, column_B] [ASC / DESC] [, more columns if needed...]
 	LIMIT [number_of_rows];


/* ARITHMETHIC OPERATORS and ALIAS using  [columnA OPERATOR columnB ] AS [alias] - arithmetic operators allow to create new column(s) using operations on existing columns during queries. In order to name (alias) such new column(s), one needs to use AS [alias] after the arithmetic manipulation of columnA and ColumnB.
Common Operators are:
+ sum, - substraction, * multiplication, / division, % modulus */

	SELECT  columnA,
			columnB,
			columnA OPERATOR columnB AS [alias]
	FROM [table]


/* LOGICAL OPERATORS - used with WHERE column LOGICAL_OPERATOR value
-> LIKE
	This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for. Extremely useful for working with text. You will use LIKE within a WHERE clause. The LIKE operator is frequently used with %. The % tells us that we might want any number of characters leading up to a particular set of characters or following a certain set of characters

-> IN
	This allows you to perform operations similar to using WHERE and =, but for more than one condition. WHERE [column] IN (valueA, valueB, ...)

-> NOT
	This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

-> AND & BETWEEN
	These allow you to combine operations where all combined conditions must be true.
	
	AND - WHERE column ARITHMETIC/LOGIC_OPERATOR valueA AND column ARITHMETIC/LOGIC_OPERATOR valueB  AND ...
	
	BETWEEN - Sometimes we can make a cleaner statement using BETWEEN than we can using AND. Particularly this is true when we are using the same column for different parts of our AND statement. In the previous video, we probably should have used BETWEEN.

		Instead of writing : 				WHERE column >= 6 AND column <= 10
		we can instead write, equivalently: WHERE column BETWEEN 6 AND 10

		***** NOTE: The lower bound is inclusive, but the upper bound is exclusive. 
		From example above we will get results including 6, but not including 10

-> OR
	This allow you to combine operations where at least one of the combined conditions must be true.
	Similar use to AND operator.
*/

	SELECT [columns]
	FROM [table]
	WHERE ([columnA] [LOGICAL_OPERATORS/OPERATOR] [valueA]) [LOGICAL_OPERATORS] ([columnB] [LOGICAL_OPERATORS/OPERATOR] [valueB]) [... more conditions] 

