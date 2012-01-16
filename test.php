<?php

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

$response = submitHTTPpost($cookie_file, "http://cloud.cs50.net/~ruthfong/pset7/login2.php", false, "username=test10&password=password10");
echo $response;
?>
