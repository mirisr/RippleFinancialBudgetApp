<?php
class MySQLDao {
    
var $dbhost = null;
var $dbuser = null;
var $dbpass = null;
var $conn = null;
var $dbname = null;
var $result = null;

function __construct() {
    
    $this->dbhost = Conn::$dbhost;
    $this->dbuser = Conn::$dbuser;
    $this->dbpass = Conn::$dbpass;
    $this->dbname = Conn::$dbname;
    
}

public function openConnection() {
    
    $this->conn = new mysqli($this->dbhost, $this->dbuser, $this->dbpass, $this->dbname);
    if (mysqli_connect_errno())
        echo new Exception("Could not establish connection with database");
    
}

public function getConnection() {
    
    return $this->conn;
    
}

public function closeConnection() {
    
    if ($this->conn != null)
        $this->conn->close();
    
}

public function getUserDetails($email)
{
    $returnValue = array();
    $sql = "select * from Users where Email='" . $email . "'";

    $result = $this->conn->query($sql);
    if ($result != null && (mysqli_num_rows($result) >= 1)) {
        $row = $result->fetch_array(MYSQLI_ASSOC);
        if (!empty($row)) {
            $returnValue = $row;
        }
    }
    
    return $returnValue;
}

public function getUserDetailsWithPassword($email, $userPassword)
{
    $returnValue = array();
    $sql = "select UserID, Email from Users where Email='" . $email . "' and Password='" .$userPassword . "'";

    $result = $this->conn->query($sql);
    if ($result != null && (mysqli_num_rows($result) >= 1)) {
        $row = $result->fetch_array(MYSQLI_ASSOC);
        if (!empty($row)) {
            $returnValue = $row;
        }
    }
    return $returnValue;
}

public function registerUser($email, $password)
{
    $sql = "insert into Users set Email=?, Password=?";
    $statement = $this->conn->prepare($sql);

    if (!$statement)
        throw new Exception($statement->error);

    $statement->bind_param("ss", $email, $password);
    $returnValue = $statement->execute();

    return $returnValue;
}
    
public function addCategory($userID, $categoryName, $budgetAmount)
{
    $sql = "insert into Categories set UserID=?, CategoryName=?, BudgetAmount=?";
    
    $statement = $this->conn->prepare($sql);

    if (!$statement)
        throw new Exception($statement->error);

    $statement->bind_param("isd", $userID, $categoryName, $budgetAmount);
    $returnValue = $statement->execute();

    return $returnValue;
}
    
public function deleteCategory($userID, $categoryID)
{
    $sql = "delete from Categories where UserID =".$userID." and
    CategoryID = ". $categoryID;
    
    $statement = $this->conn->prepare($sql);
    
    if (!$statement)
        throw new Exception($statement->error);
    
    $returnValue = $statement->execute();
    
    return $returnValue;

}

/*
public function getAmountSpentInEachCategory($userID, $month, $year)
{
    
    
    $statement = $this->conn->prepare($sql);

    if (!$statement)
        throw new Exception($statement->error);

    //$statement->bind_param("iiss", $userID, $categoryID, $month, $year);
    $returnValue = $statement->execute();

    return $returnValue;
}



  (select C.CategoryID, C.CategoryName, C.UserID, C.BudgetAmount, sum(T.Amount) as Amount_Spent 

from AssignedTransactions as AT

join Transactions as T
on AT.TransactionID = T.TransactionID 

join Categories as C
on C.UserID = T.UserID
and C.CategoryID = AT.CategoryID

where extract(month from T.TransactionDate) = '2' and extract(year from T.TransactionDate) = '2016' and C.UserID = 13
group by C.CategoryID
)
Union
(

   
    select C.CategoryID, C.CategoryName, C.UserID, C.BudgetAmount, 0 as Amount_Spent
    from Categories as C
    
    where C.CategoryID not in
    (
        select CategoryID
        from AssignedTransactions as AT
        
        
    )and C.UserID = 13


)
*/

}
?>