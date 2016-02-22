<?php 


require("Conn.php");
require("MySQLDao.php");

$userID = htmlentities($_POST["UserID"]);
$month = htmlentities($_POST["Month"]);
$year = date('Y');


$returnValue = array();


$dao = new MySQLDao();
$dao->openConnection();


//$sql = "SELECT * FROM Categories where UserID='".$userID."';";

$sql = "
    (
        select C.CategoryID, C.CategoryName, C.UserID, C.BudgetAmount, sum(T.Amount) as AmountSpent 

        from AssignedTransactions as AT

        join Transactions as T
        on AT.TransactionID = T.TransactionID 

        join Categories as C
        on C.UserID = T.UserID
        and C.CategoryID = AT.CategoryID

        where extract(month from T.TransactionDate) = '".$month."' and extract(year from T.TransactionDate) = '".$year."' and C.UserID = ".$userID."
        group by C.CategoryID
    )
    Union
    (
        select C.CategoryID, C.CategoryName, C.UserID, C.BudgetAmount, 0 as Amount_Spent
        from Categories as C

        where C.CategoryID not in
        (
            select AT.CategoryID
            from AssignedTransactions as AT
            join Transactions as T
            on
            T.TransactionID = AT.TransactionID
            where extract(month from T.TransactionDate) = '".$month."' 
            and 
            extract(year from T.TransactionDate) = '".$year."' 
            and 
            T.UserID = ".$userID." 



        )and C.UserID = ".$userID."


    )";

$con = $dao->getConnection();
    

// Check if there are results
if ($result = mysqli_query($con, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();
 
	// Loop through each row in the result set
	while($row = $result->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
 
	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
}
 



$dao->closeConnection();

?>

