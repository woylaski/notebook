<?php

go();

function go() {
    $url = "https://www.google.com/calendar/feeds/1ntrljg0md6jtiu2p8j9lphdr0%40group.calendar.google.com/private-00ba4770f910e27bab88039fb41fc6ca/basic";

    $str = file_get_contents($url);
    echo "<pre>$str</pre>";
}



?>
