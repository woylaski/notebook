<?php

if (!_iscurlinstalled()) {
	die("Sorry, it seems curl is not available for us");
}

go();

function go() {
    $username = $_REQUEST['username'];
    $password = $_REQUEST['password'];

    if (! isset($_REQUEST['endpointIp'])) {
        echo "<p>Please specify endpointIp and bookingXml (or just endpointIp for testing with predefined sample)";
        return;
    }

    $ip = $_REQUEST['endpointIp'];
    if (! isset ($_REQUEST['bookingXml'])) {
        unitTest($ip, $username);
    }
    else {
        $data = stripslashes($_REQUEST['bookingXml']);
        sendBookingData($ip, $username, $password, $data);
    }
}

function unitTest($ip, $username, $password) {
    $data = file_get_contents("booking.xml");
    sendBookingData($ip, $username, $password, $data);
}

function _iscurlinstalled() {
    if  (in_array  ('curl', get_loaded_extensions())) {
        return true;
    }
    else{
        return false;
    }
}

function base64encode($username, $password) {
    $auth = $username . ":" . $password;
    return base64_encode($auth);
    //return "YWRtaW46cGFzc3dvcmQ="; /* base64 for admin:password */
}

function sendBookingData($ip, $username, $password, $bookingXml) {
    $url = "http://$ip/bookingsputxml";
    $ch = curl_init($url);

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Authorization: Basic ' . base64encode($username, $password),
                    'X-Tsh-Addr: test-that-this-gets-through',
                    'User-Agent: Tandberg Http User Agent (compatible; MSIE 5.6; Windows NT 5.0)',
                    'Expect:' /* needed due to http "Expectation failed" error */
    ));
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $bookingXml);

    $response = curl_exec($ch);
    curl_close($ch);

    echo "<p>Sent to ip $ip:";
    echo "<p><pre>" .htmlentities($bookingXml) . "</pre>";
    echo "<p>Response:";
    echo "<p><pre>" .htmlentities($response) . "</pre>";
}

?>

