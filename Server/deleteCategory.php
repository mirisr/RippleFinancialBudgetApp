<?php 


require("Conn.php");
require("MySQLDao.php");

$userID = htmlentities($_POST["userID"]);
$categoryID = htmlentities($_POST["categoryID"]);


$returnValue = array();

$dao = new MySQLDao();
$dao->openConnection();

$categoryDetails = $dao->deleteCategory($userID, $categoryID);

if($categoryDetails) {
    
    $returnValue["status"] = "success";
    $returnValue["message"] = "Success!";
    echo json_encode($returnValue);
    return;
}

if(empty($categoryDetails)){
    
    $returnValue["status"] = "error: ";
    $returnValue["message"] = "Deletion Error";
    echo json_encode($returnValue);
    return;
}

$dao->closeConnection();

?>