<?php
// if (!isset($_POST['register'])) {
//     $response = array('status' => 'failed', 'data' => null);
//     sendJsonResponse($response);
//     die();
// }

include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(10000,99999);

$sqlregister = "INSERT INTO `table_user`(`user_email`, `user_name`, `user_phone`, `user_otp`, `user_password`) VALUES ('$email','$name','$phone','$otp','$password')";

 try {
	if ($conn->query($sqlregister) === TRUE) {
		$response = array('status' => 'success', 'data' => null);
		sendJsonResponse($response);
		//echo "sucess";
	}else{
		$response = array('status' => 'failed', 'data' => null);
		//echo "fail1";
		sendJsonResponse($response);
	}
 }
catch(Exception $e) {

  $response = array('status' => 'failed', 'data' => null);
sendJsonResponse($response);
echo "totally failed";
 }
 $conn->close();

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>