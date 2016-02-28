$(document).ready(init);

function init() {
    addDefaultData();
    addCalendar();
    $(".meetingDetails").hide();
    $("#editXmlField").hide();
    $("#editGui").hide();
}

function pad(number) {
    if (number < 10) number = "0"+number;
    return number;
}

function addCalendar() {
    $(".startDate").datepicker({dateFormat: "yy-mm-dd"});
    //console.log("calendars added: ", $(".startDate").length);
}

function addDefaultData() {
    var now = new Date();
    var timeZoneOffset = 2;
    var minutesFromNow = 2;
    var minutesLength= 2;
    var start = new Date(now.getTime());

    $("#endpointIp").val($.cookie("ipEndpoint"));
    $("#timezoneOffset").val($.cookie("timezoneOffset"));
    $("#username").val($.cookie("username"));
    $("#password").val($.cookie("password"));

    var date = new Array(start.getFullYear(), pad(start.getMonth()+1), pad(start.getDate()));
    var time = new Array(pad(start.getHours()), pad(start.getMinutes()));
    $(".startDate").val(date.join('-'));
    $(".startTime").val(time.join(":"));
    $(".hours").val("01");
    $(".minutes").val("00");
}

function replaceVariable(xml, variableName, value) {
    var regexp = new RegExp("{" + variableName + "}", "g");
    return xml.replace(regexp, value);
}


function getStartDateTime(element) {
    var date = $(".startDate", element).val().split("-");
    var time = $(".startTime", element).val().split(":");

    // note: javascript uses 0-index months. and we dont care about seconds or milliseconds
    var dateTime = new Date(date[0], date[1]-1, date[2], time[0], time[1]);
    var dateUTC = new Date(dateTime.getTime() - $("#timezoneOffset").val()*60*60*1000);
    return dateUTC;
}

function getStartDate(row) {
    var utc = getStartDateTime(row);
    return utc;
}

function getEndDate(row) {
    var start = getStartDate(row);
    var hourMs = 1000*60*60 *$(".hours", row).val();
    var minuteMs = 1000*60 *$(".minutes", row).val();
    var endDate = new Date(start.getTime() + hourMs + minuteMs);
    return endDate;
}

function formatDate(date) {
    var txt = [date.getFullYear(), pad(date.getMonth()+1), pad(date.getDate())].join("-");
    txt = txt + "T" + [pad(date.getHours()), pad(date.getMinutes()), "00"].join(":") + "Z";
    //console.log(txt);
    return txt;
}
function cloneMeeting(button) {
    var row = $(button).parents(".meeting");
    var meeting = row.clone();

    $(".startDate", meeting).removeAttr("id"); // otherwise calendar will be connected to the wrong input field
    $(".startDate", meeting).removeClass("hasDatepicker");// otherwise jquery-ui thinks its already added, and doesn't add it properly
    $(".startDate", meeting).datepicker({dateFormat: "yy-mm-dd"});

    $(".agenda", meeting).val( $(".agenda", row).val()); // textarea value isn't cloned automatically

    row.after(meeting);
}

function removeMeeting(button) {
    var row = $(button).parents(".meeting");
    row.remove();
}

function onResponse(data) {
    console.log("booking response received");
    alert('Meetings booked');
    //console.log(data);
}

function onError(jqXHR, textStatus, errorThrown) {
    console.log("send error", jqXHR, textStatus, errorThrown);
    alert("Error: " + textStatus);
}

function onFail() {
    console.log("Problems sending booking data");
}

function toggleDetails(button) {
    var parent = $(button).parents(".meeting");
    var details = $(".meetingDetails", parent);
    details.toggle();
}

function validateElement(element, regexp) {
    var el = $(element);
    if (! el.val().match(regexp)) {
        el.addClass("invalid");
    }
    else el.removeClass("invalid");

}

function editRawXml() {
    $("#meetingList").hide();
    $("#editRaw").hide();
    $("#editXmlField").show();
    $("#editGui").show();

    $("#editXmlField").val(makeXml());
}

function showGuiEditor() {
    $("#editXmlField").hide();
    $("#editGui").hide();
    $("#editRaw").show();
    $("#meetingList").show();
}

function findErrors() {

    function validateTitle(i, e) { validateElement(e, /\S+/);}
    function validateDate(i, e) { validateElement(e, /^\d{4}\-\d{1,2}\-\d{1,2}$/);}
    function validateTime(i, e) { validateElement(e, /^\d{1,2}\:\d\d$/);}

    validateElement($("#endpointIp"), /\d+\.\d+\.\d+.\d+/);
    $(".title").each(validateTitle);
    $(".startDate").each(validateDate);
    $(".startTime").each(validateTime);

    return $(".invalid").length;
}

function makeXml() {
    var doc = "";

    var addMeeting = function(index, element) {
        var xml = meetingItemXml;
        var startDate = getStartDate(element);
        var endDate = getEndDate(element);
        var privacy = $(".isPrivate", element).attr("checked") ? "Private" : "Public";

        xml = replaceVariable(xml, "id", index + 1);
        xml = replaceVariable(xml, "title", $(".title", element).val());
        xml = replaceVariable(xml, "privacy", privacy);
        xml = replaceVariable(xml, "agenda", $(".agenda", element).val());

        xml = replaceVariable(xml, "startDateTime", formatDate(startDate));
        xml = replaceVariable(xml, "endDateTime", formatDate(endDate));
        xml = replaceVariable(xml, "startTimeBuffer", $(".startBuffer", element).val()*60);
        xml = replaceVariable(xml, "endTimeBuffer", 0);

        xml = replaceVariable(xml, "maximumMeetingExtension", "30");
        xml = replaceVariable(xml, "extensionAvailability", "Guaranteed");

        // organizer
        xml = replaceVariable(xml, "firstName", $(".firstName", element).val());
        xml = replaceVariable(xml, "lastName", $(".lastName", element).val());
        xml = replaceVariable(xml, "email", $(".email", element).val());

        xml = replaceVariable(xml, "bookingStatus", "OK");
        xml = replaceVariable(xml, "bookingMessage", "");

        // webex
        xml = replaceVariable(xml, "webexEnabled", "True");
        xml = replaceVariable(xml, "webexUrl", "http:/webex.for.dummies");
        xml = replaceVariable(xml, "webexMeetingNumber", "123456");
        xml = replaceVariable(xml, "webexPassword", "guess");
        xml = replaceVariable(xml, "webexHostKey", "key");

        xml = replaceVariable(xml, "interopBridgeNumber", "");
        xml = replaceVariable(xml, "interopBridgeConferenceId", "");

        xml = replaceVariable(xml, "role", "Slave");

        // manual call in
        xml = replaceVariable(xml, "manualCallInNumber", "");
        xml = replaceVariable(xml, "manualCallInConferenceId", "");
        xml = replaceVariable(xml, "manualCallInPassword", "");

        xml = replaceVariable(xml, "dialNumber", $(".dialInNumber", element).val());
        xml = replaceVariable(xml, "dialProtocol", "SIP");
        xml = replaceVariable(xml, "dialCallRate", "");
        xml = replaceVariable(xml, "dialType", "Video");
        xml = replaceVariable(xml, "dialConnectMode", "OBTP");

        xml = replaceVariable(xml, "encryption", "BestEffort");
        xml = replaceVariable(xml, "recording", "Disabled");

        doc = doc + xml;
    }

    $(".meeting").each(addMeeting);
    doc = replaceVariable(wholeXml, "bookings", doc);
    doc = replaceVariable(doc, "totalRows", $(".meeting").length);

    return doc;
}

function submitBookings() {

    var doc;

    if ($("#editXmlField").is(":visible")) {
        doc = $("#editXmlField").val();
     }

     else {
          var errors = findErrors();
          if (errors > 0) {
              alert('There were ' + errors + " errors in the form. Please correct them before submitting.");
              return false;
          }
        doc = makeXml();
     }

    setCookie("ipEndpoint", $("#endpointIp").val());
    setCookie("timezoneOffset", $("#timezoneOffset").val());
    setCookie("username", $("#username").val());
    setCookie("password", $("#password").val());

    postXml(doc);
}

function setCookie(name, value) {
    var year = 365;
    $.cookie(name, value, {expires: year, path: '/'});
}

function postXml(xml) {
    var endpointIp = "";

    var postData = {
        endpointIp: $("#endpointIp").val(),
        bookingXml: xml,
        username: $("#username").val(),
        password: $("#password").val()
    };

    $.ajax({
        url: "forwardBookingToEndpoint.php",
        type: "POST",
        data: postData,
        success: onResponse,
        fail: onFail,
        error: onError
    });
}

/* ------------------------------ XML Template ------------------------------ */

var wholeXml = ' \
<Bookings status="OK"> \n\
  <ResultInfo> \n\
    <TotalRows>{totalRows}</TotalRows> \n\
  </ResultInfo> \n\
  <LastUpdated>2011-09-01T21:34:15Z</LastUpdated> \n\
  {bookings} \n\
</Bookings> \n\
';

var meetingItemXml = ' \
<Booking item="{id}"> \n\
  <Id>{id}</Id> \n\
  <Title>{title}</Title> \n\
  <Agenda>{agenda}</Agenda> \n\
  <Privacy>{privacy}</Privacy> \n\
  <Organizer> \n\
    <FirstName>{firstName}</FirstName> \n\
    <LastName>{lastName}</LastName> \n\
    <Email>{email}</Email> \n\
  </Organizer> \n\
  <Time> \n\
    <StartTime>{startDateTime}</StartTime> \n\
    <StartTimeBuffer>{startTimeBuffer}</StartTimeBuffer> \n\
    <EndTime>{endDateTime}</EndTime> \n\
    <EndTimeBuffer>{endTimeBuffer}</EndTimeBuffer> \n\
  </Time> \n\
  <MaximumMeetingExtension>{maximumMeetingExtension}</MaximumMeetingExtension> \n\
  <MeetingExtensionAvailability>{extensionAvailability}</MeetingExtensionAvailability> \n\
  <BookingStatus>{bookingStatus}</BookingStatus> \n\
  <BookingStatusMessage>{bookingMessage}</BookingStatusMessage> \n\
  <Webex> \n\
    <Enabled>{webexEnabled}</Enabled> \n\
    <Url>{webexUrl}</Url> \n\
    <MeetingNumber>{webexMeetingNumber}</MeetingNumber> \n\
    <Password>{webexPassword}</Password> \n\
    <HostKey>{webexHostKey}</HostKey> \n\
    <DialInNumbers/> \n\
  </Webex> \n\
  <InteropBridge> \n\
    <Number>{interopBridgeNumber}</Number> \n\
    <ConferenceId>{interopBridgeConferenceId}</ConferenceId> \n\
  </InteropBridge> \n\
  <ManualCallIn> \n\
    <Number>{manualCallInNumber}</Number> \n\
    <ConferenceId>{manualCallInConferenceId}</ConferenceId> \n\
    <ConferencePassword>{manualCallInPassword}</ConferencePassword> \n\
  </ManualCallIn> \n\
  <Encryption>{encryption}</Encryption> \n\
  <Role>{role}</Role> \n\
  <Recording>{recording}</Recording> \n\
  <DialInfo> \n\
    <Calls> \n\
      <Call> \n\
        <Number>{dialNumber}</Number> \n\
        <Protocol>{dialProtocol}</Protocol> \n\
        <CallRate>{dialCallRate}</CallRate> \n\
        <CallType>{dialType}</CallType> \n\
      </Call> \n\
    </Calls> \n\
    <ConnectMode>{dialConnectMode}</ConnectMode> \n\
  </DialInfo> \n\
</Booking> \n\
';



