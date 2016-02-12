<?php 


require("Conn.php");
require("MySQLDao.php");

$email = htmlentities($_POST["email"]);
$password = htmlentities($_POST["password"]);

$returnValue = array();

if(empty($email) || empty($password)) {
    
    $returnValue["status"] = "error";
    $returnValue["message"] = "Missing required field";
    echo json_encode($returnValue);
    return;
}

$dao = new MySQLDao();
$dao->openConnection();

//$secure_password = md5($password);
$userDetails = $dao->getUserDetailsWithPassword($email,$password);

if(!empty($userDetails)){
    
    $returnValue["status"] = "error";
    $returnValue["message"] = "User Already Exists";
    echo json_encode($returnValue);
    return;
}

//$secure_password = md5($password); 
$result = $dao->registerUser($email,$password);

if($result){
    
    $returnValue["status"] = "Success";
    $returnValue["message"] = "Success!";
    echo json_encode($returnValue);
    return;
}

$dao->closeConnection();

?>

