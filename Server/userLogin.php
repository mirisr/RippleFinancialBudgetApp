<?php

require("Conn.php");
require("MySQLDao.php");


$email = htmlentities($_POST["email"]);
$password = htmlentities($_POST["password"]);
$returnValue = array();

if(empty($email) || empty($password))
{
    $returnValue["status"] = "error";
    $returnValue["message"] = "Missing required field";
    echo json_encode($returnValue);
    return;
}

$dao = new MySQLDao();
$dao->openConnection();

//$secure_password = md5($password);
$userDetails = $dao->getUserDetailsWithPassword($email,$password);

if(!empty($userDetails))
{
    $returnValue["status"] = "Success";
    $returnValue["message"] = "User is registered";
    $returnValue["userID"] = $userDetails['UserID'];
    
    echo json_encode($returnValue);
    
} else {

    $returnValue["status"] = "error";
    $returnValue["message"] = "User is not found";
    echo json_encode($returnValue);
}

$dao->closeConnection();

?>