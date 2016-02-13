<?php 


require("Conn.php");
require("MySQLDao.php");

$userID = htmlentities($_POST["userID"]);
$categoryName = htmlentities($_POST["categoryName"]);
$budgetAmount = htmlentities($_POST["budgetAmount"]);

$returnValue = array();

$dao = new MySQLDao();
$dao->openConnection();


$categoryDetails = $dao->addCategory($userID, $categoryName, $budgetAmount);

if($categoryDetails) {
    
    $returnValue["status"] = "success";
    $returnValue["message"] = "Success!";
    echo json_encode($returnValue);
    return;
}

if(empty($categoryDetails)){
    
    $returnValue["status"] = "error:".$userID." ".$categoryName." ".$budgetAmount;
    $returnValue["message"] = "Invalid Entry";
    echo json_encode($returnValue);
    return;
}

$dao->closeConnection();

?>

