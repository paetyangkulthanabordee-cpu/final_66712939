<?php

header("Content-Type: application/json");
include "condb.php";

$id = $_POST['id'];
$eq_name = $_POST['eq_name'];
$detail = $_POST['detail'];
$num = $_POST['num'];
$created_at = $_POST['created_at'];

////////////////////////////////////////////////////
// CHECK TIME CONFLICT
////////////////////////////////////////////////////

$sql_check = "SELECT * FROM equipment
WHERE id = :id
AND eq_name = :eq_name
AND detail < :detail
AND num > :num
AND created_at > :created_at";

$stmt = $conn->prepare($sql_check);

$stmt->bindParam(":id",$id);
$stmt->bindParam(":eq_name",$eq_name);
$stmt->bindParam(":detail",$detail);
$stmt->bindParam(":num",$num);
$stmt->bindParam(":created_at",$created_at);

$stmt->execute();

if($stmt->rowCount() > 0){

    echo json_encode([
        "status"=>"unavailable",
        "message"=>"อุปกรณ์ไม่ว่าง เวลาซ้อนกัน"
    ]);

    exit;
}

////////////////////////////////////////////////////
// INSERT BOOKING
////////////////////////////////////////////////////

$sql = "INSERT INTO equipment
(id,eq_name,deatail,num,created_at)
VALUES
(:id,:eq_name,:detail,:num,:created_at)";

$stmt = $conn->prepare($sql);

$stmt->bindParam(":id",$id);
$stmt->bindParam(":eq_name",$eq_name);
$stmt->bindParam(":detail",$detail);
$stmt->bindParam(":num",$num);
$stmt->bindParam(":created_at",$created_at);

if($stmt->execute()){

    echo json_encode([
        "status"=>"success"
    ]);

}else{

    echo json_encode([
        "status"=>"error"
    ]);

}

?>