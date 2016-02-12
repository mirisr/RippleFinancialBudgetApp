<?php 


require("Conn.php");
require("MySQLDao.php");

$userID = htmlentities($_POST["UserID"]);

$returnValue = array();


$dao = new MySQLDao();
$dao->openConnection();


// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM Categories where UserID='".$userID."';";
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

