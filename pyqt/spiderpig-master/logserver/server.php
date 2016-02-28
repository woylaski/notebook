<?php

function saveLog() {


    $codecHost = $_REQUEST['codecHost'];
    $codecName = $_REQUEST['codecName'];
    $submitter = $_REQUEST['submitter'];
    $issueSummary = $_REQUEST['issueSummary'];
    $issueDate = $_REQUEST['issueDate'];
    $issueTime = $_REQUEST['issueTime'];
    $bugId = $_REQUEST['bugId'];
    $idefixIp = $_REQUEST['idefixIp'];
    $idefixLogData = $_REQUEST['idefixLogData'];

    $logdir = "logs";
    if (!is_dir($logdir))
        mkdir($logdir);

    $date = date("Y-m-d_His");
    $file = "$logdir/$date-$codecHost.log.html";

    $html = file_get_contents("template.html");
    $html = str_replace("\$codecHost", $codecHost, $html);
    $html = str_replace("\$codecName", $codecName, $html);
    $html = str_replace("\$submitter", $submitter, $html);
    $html = str_replace("\$issueSummary", $issueSummary, $html);
    $html = str_replace("\$issueDate", $issueDate, $html);
    $html = str_replace("\$issueTime", $issueTime, $html);
    $html = str_replace("\$bugId", $bugId, $html);
    $html = str_replace("\$idefixIp", $idefixIp, $html);
    $html = str_replace("\$idefixLogData", $idefixLogData, $html);

    $saved = file_put_contents($file, $html);

    if (! $saved)
        echo "Error saving to $file";
    else
        echo "Saved log to $file";
}

if ($_REQUEST['idefixLogData'])
    saveLog();
else
    echo "No log data specified. This is a server page for receiving log data and saving to file.";
?>
