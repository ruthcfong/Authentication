<?php
//echo 'hello!';

function submitHTTPpost($cookie_file, $url, $isPOSTsubmission, $params)
{
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_COOKIEJAR, $cookie_file);
  curl_setopt($ch, CURLOPT_COOKIEFILE, $cookie_file);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
  curl_setopt($ch, CURLOPT_HEADER, 0); 
  
  // set submission to POST if needed
  if ($isPOSTsubmission == true)
  {
    curl_setopt($ch, CURLOPT_POST, true);
  }

  // set parameters for HTTP body, if any
  if ($params != "")
  {
    curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
  }

  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
  curl_setopt($ch, CURLOPT_VERBOSE, 0); 
  $response = (curl_exec($ch));
  curl_close($ch);
  return $response;
}

// create cookie jar and direct to Harvard pin authentication site
$cookie_file = tempnam(sys_get_temp_dir(), '');

//$responseArr = array();

// direct to Harvard pin authentication site using GET submission
$response = submitHTTPpost($cookie_file, "https://www.pin1.harvard.edu/pin/authenticate?__authen_application=VPA_HUDS_MYHUDS", false, "");

// submit HUID & PIN for authentication & remember cookies via POST submission
$response = submitHTTPpost($cookie_file, "https://www.pin1.harvard.edu/pin/submit-login", true, "__authen_application=VPA_HUDS_MYHUDS&__authen_login_type=PIN&__authen_id=".$_POST['huid']."&__authen_password=".$_POST['password']);

// check if there's a page that's being the PIN site is trying to redirect
preg_match('/<meta http-equiv="Refresh" content="3; URL=([\w\:\/\.\?=\%\&\+]+)/', $response, $matches);

// if there's a match to the reg ex above, redirect to the appropriate link
if (count($matches) > 1) 
{
  $response = submitHTTPpost($cookie_file, $matches[1], false, "");
}

// check whether the the scrip should submit an order
/*if (empty($_POST["order"]))
{
  return;
}*/

// submit order via GET submission
$response = submitHTTPpost($cookie_file,$_POST['order'] ,false, "");
//$response = submitHTTPpost($cookie_file,"http://www.dining.harvard.edu/myhuds/students/breakfast/?action=submit&pickup=2012-01-16&order%5Blocation_id%5D=FD&order%5Bdelivery_time%5D=07%3A00&pickup_list=0&items%5B8%20oz%20Cottage%20Cheese%5D=on",false, "");

header("HTTP/1.1 200 OK");
//echo $response;
$str = (file_get_contents($cookie_file));

// use a reg ex to check whether the login cookie has been activated
preg_match('/\.www\.dining\.harvard\.edu([\s]+)TRUE/',$str, $matches);
if (count($matches) > 1)
{
  // echo 'it worked!';
  $arr = array('didWork'=>'yes');
  echo json_encode($arr);
  //header("HTTP/1.1 200 OK");
  //return $response;
}
else
{
  $arr = array('didWork'=>'no');
  //echo 'it failed =(';
  echo json_encode($arr);
  //header("HTTP/1.1 200 OK");
  //return $response;
}
?>
