$(document).ready(init);

var g_playerData;
var g_results;

// Enum
var HOMEWIN = 0;
var DRAW    = 1;
var AWAYWIN = 2;

// Points
var WinnerPoint         = 20;
var TopScorerPoint      = 10;
var FinalPoint          = 10;
var SemiFinalPoint      = 5;
var QuarterFinalPoint   = 3;
var QuestionPoint       = 2;
var GroupScorePoint     = 3;
var GroupResultPoint    = 2;

function init() {
    fetchResults();
    $("#scoreDialog").hide();
}

function openScoreDialog(matchNumber) {
    //console.log("show match", matchNumber);
    var match = g_results.groupMatches[matchNumber];
    $(".teamInput", $("#scoreDialog"))[0].innerHTML = match.team1;
    $(".teamInput", $("#scoreDialog"))[1].innerHTML = match.team2;

    var score1 = $(".inputScore", $("#scoreDialog"))[0];
    var score2 = $(".inputScore", $("#scoreDialog"))[1];
    score1.value = match.score1;
    score2.value = match.score2;

    $("#scoreDialog").dialog({
        resizable: false,
        width: 400,
        height: 200,
        modal: true,
        buttons: {
            "Update": function() {
                g_results.groupMatches[matchNumber].score1 = score1.value;
                g_results.groupMatches[matchNumber].score2 = score2.value;
                $(this).dialog("close");
                receiveResults(g_results);
            },
            "Cancel": function() {
                $(this).dialog("close");
            }
        }
    });
}


function fetchResults() {
    $.getJSON('actualresults.json', receiveResults);
}

function fetchPlayerBets() {
    $.getJSON('playerbets.json', receivePlayerBets);
}

function cell(content) {return $("<td>" +content +"</td>");}
function head(content) {return $("<th>" +content +"</th>");}

function receiveResults(data) {
    g_results = data;
    var table = $("<table/>").addClass("box");
    var h = $("<tr/>");
    h.append(head("#"));
    h.append(head("Team 1"));
    h.append(head("Team 2"));
    h.append(head("Score"));
    h.append(head("Guess"));
    h.append(head("Points"));
    table.append(h);

    var groupMatches = data.groupMatches;
    for (var i=0; i<groupMatches.length; i++) {
        var r = $("<tr/>");
        var m = groupMatches[i];
        r.attr("id", "g" + m.matchNumber);
        r.append(cell(m.matchNumber).addClass("matchNumber"));
        r.append(cell(icon(m.team1) + m.team1).addClass("team1"));
        r.append(cell(icon(m.team2) + m.team2).addClass("team2"));
        var divider = matchNotPlayed(m) ? "" : "-";
        var score = cell("<span class='score1'>" + m.score1 + "</span> " +divider +" <span class='score2'>" + m.score2 + "</span>");
        score.click(function() {
            openScoreDialog( parseInt($(".matchNumber", $(this).parent()).html()) -1 );
        });
        r.append(score);
        r.append(cell("<span class='guessScore1'></span> - <span class='guessScore2'></span>"));
        r.append(cell("").addClass("points"));
        table.append(r);
    }
    $("#groupMatches").html(table);

    fetchPlayerBets();
}

function icon(teamName) {
    return "<img src='" + flag(teamName) + "' class='flag' alt='" +teamName +"'/>";
}

function flag(teamName) {
    return "images/" + jQuery.trim(teamName.toLowerCase()) + ".gif";
}

function calculateGroupMatchScore(actualResult, betResult) {
    if (matchNotPlayed(actualResult)) return "";

    var point = 0;
    if (result(actualResult) == result(betResult)) {
        point = GroupResultPoint;
        if (actualResult.score1 == betResult.score1 && actualResult.score2 == betResult.score2)
            point = GroupScorePoint;
    }
    return point;
}

function matchNotPlayed(match) {
    return (match.score1 === "" || match.score2 === "");
}

function result(match) {
    if (match.score1 > match.score2) return HOMEWIN;
    if (match.score1 == match.score2) return DRAW;
    return AWAYWIN;
}

function loadPlayer(playerName) {
    var player = findPlayer(playerName);

    $(".points").removeClass("correctScore correctResult incorrect");
    $(".points").html("");
    $(".userbet").html("");

    for (var i=0; i<player.groupMatches.length; i++) {
        var match = player.groupMatches[i];
        var row = $("#g" + match.matchNumber);
        $(".guessScore1", row).html(match.score1);
        $(".guessScore2", row).html(match.score2);

        var actual = g_results.groupMatches[i];
        var points = calculateGroupMatchScore(actual, match);
        var style = (points == GroupScorePoint ? "correctScore" : (points == GroupResultPoint ? "correctResult" : "incorrect"));
        //$(".points", row).removeClass("correctScore correctResult incorrect").addClass(style);
        $(".points", row).addClass(style);
        $(".points", row).html(points);
    }
    $("#infoBox").html("Showing results for player <b>" + playerName +"</b>");

    for (var q=0; q<player.quarterFinals.length; q++) {
        insertKnockoutTeam($("#quarterFinals"), player.quarterFinals[q].team1, QuarterFinalPoint);
        insertKnockoutTeam($("#quarterFinals"), player.quarterFinals[q].team2, QuarterFinalPoint);
    }

    for (var q=0; q<player.semiFinals.length; q++) {
        insertKnockoutTeam($("#semiFinals"), player.semiFinals[q].team1, SemiFinalPoint);
        insertKnockoutTeam($("#semiFinals"), player.semiFinals[q].team2, SemiFinalPoint);
    }

    insertKnockoutTeam($("#finals"), player.finals.team1, FinalPoint);
    insertKnockoutTeam($("#finals"), player.finals.team2, FinalPoint);


    insertKnockoutTeam($("#winner"), player.winner, WinnerPoint);

    $(".playerAnswer", $("#topScorer")).html(player.topScorer);

    var topscorerPointCell = $(".points", $("#topScorer"));
    if (stringContains(g_results.topScorer , player.topScorer)) {
        topscorerPointCell.addClass("correctScore");
        topscorerPointCell.html(TopScorerPoint);
    }
    else {
        topscorerPointCell.removeClass("correctScore");
        topscorerPointCell.html(0);
    }

    loadPlayerQuestions(player);
}

function loadPlayerQuestions(player) {

    $(".answerPoints").removeClass("correctScore");

    for (var i=0; i<player.questions.length; i++) {
        var ans = player.questions[i].answer;
        var row = $("#q"+ (i+1));
        $(".playerAnswer", row).html(ans);

        var point = 0;
        var correct = $(".correctAnswer", row).html();
        if (stringContains(ans, correct)) {
            point = QuestionPoint;
            $(".answerPoints", row).addClass("correctScore");
        }
        $(".answerPoints", row).html(point);
    }

}

function insertKnockoutTeam(table, teamId, potentialScore) {
    var teams = $(".team", table);
    teams.each(function(index, element) {
        var team = $(this).text();
        if (team == teamId) {
            $(this).siblings(".userbet").html(icon(teamId) + teamId);
            $(this).siblings(".points").html(potentialScore);
            $(this).siblings(".points").addClass("correctScore");
        }
    });
}

function findPlayer(playerName) {
    for (var i=0; i<g_playerData.length; i++) {
        if (g_playerData[i].player == playerName)
            return g_playerData[i];
    }
    console.log("Error: Could not find player " + playerName);
}

function calculateScore(player) {
    var score = 0;
    for (var i=0; i<player.groupMatches.length; i++) {
        var bet = player.groupMatches[i];
        var match = g_results.groupMatches[i];
        var p = calculateGroupMatchScore(match, bet);
        score += p;
    }

    for (var q=0; q < player.quarterFinals.length; q++) {

        var qPoints = QuarterFinalPoint;
        for (var r=0; r < g_results.quarterFinals.length; r++) {
            if (player.quarterFinals[q].team1 == g_results.quarterFinals[r].team1)
                score += qPoints;
            if (player.quarterFinals[q].team1 == g_results.quarterFinals[r].team2)
                score += qPoints;
            if (player.quarterFinals[q].team2 == g_results.quarterFinals[r].team1)
                score += qPoints;
            if (player.quarterFinals[q].team2 == g_results.quarterFinals[r].team2)
                score += qPoints;
        }
    }

    for (var q=0; q < player.semiFinals.length; q++) {

        var qPoints = SemiFinalPoint;
        for (var r=0; r < g_results.semiFinals.length; r++) {
            if (player.semiFinals[q].team1 == g_results.semiFinals[r].team1)
                score += qPoints;
            if (player.semiFinals[q].team1 == g_results.semiFinals[r].team2)
                score += qPoints;
            if (player.semiFinals[q].team2 == g_results.semiFinals[r].team1)
                score += qPoints;
            if (player.semiFinals[q].team2 == g_results.semiFinals[r].team2)
                score += qPoints;
        }
    }

    if (stringContains(g_results.topScorer, player.topScorer))
        score += TopScorerPoint;

    var qPoints = FinalPoint;
    if (player.finals.team1 == g_results.finals.team1)
        score += qPoints;
    if (player.finals.team1 == g_results.finals.team2)
        score += qPoints;
    if (player.finals.team2 == g_results.finals.team1)
        score += qPoints;
    if (player.finals.team2 == g_results.finals.team2)
        score += qPoints;


    var qPoints = WinnerPoint;
    if (player.winner == g_results.winner)
        score += qPoints;

    score += calculateQuestionScore(player);


    return score;
}

function stringContains(pattern, wholeString) {
    var pat = new RegExp(pattern, "gi");
    var result = pat.test(wholeString);
    return result;
}


function calculateQuestionScore(player) {
    var points = 0;
    for (var i=0; i < g_results.questions.length; i++) {
        var correct  = g_results.questions[i].answer;
        var answer = player.questions[i].answer;
        if (stringContains(answer, correct))
            points += QuestionPoint;
    }
    return points;
}

function loadScores() {
    loadGroupScores();
    loadKnockoutScores();
    loadTopScorer();
    loadQuestions();
}

function loadTopScorer() {
    var table = $("<table/>").addClass("box");
    table.append("<tr><th>Top scorer</th><th>Player answer</th><th>Points</th></tr>");

    var tr = $("<tr/>");
    tr.append(cell(g_results.topScorer));
    tr.append(cell("").addClass("playerAnswer"));
    tr.append(cell("").addClass("points"));

    table.append(tr);

    $("#topScorer").html(table);
}

function loadQuestions() {
    var table = $("<table/>").addClass("box");
    table.append("<tr><th>Question</th><th>Correct answer</th><th>Player</th><th>Points</th></tr>")

    var q = g_results.questions;
    for (var i=0; i<q.length; i++) {
        var tr = $("<tr/>").attr("id", "q" + (i+1));
        tr.append(cell(q[i].question));
        tr.append(cell(q[i].answer).addClass("correctAnswer"));
        tr.append(cell("").addClass("playerAnswer"));
        tr.append(cell("").addClass("answerPoints"));
        table.append(tr);
    }

    $("#questions").html(table);
}

function loadGroupScores()  {
    var scores = calculateAllScores();
    var table = $("<table/>").addClass("box");
    table.append("<tr><th>#</th><th>Player</th><th>Points</th><th></th></tr>")

    for (var i=0; i<scores.length; i++) {
        var tr = $("<tr/>");
        var name = scores[i].name;
        tr.append($("<td>").html(i+1));
        tr.append($("<td class='name'/>").html(name));
        tr.append($("<td class='playerPoints'/>").html(scores[i].points));
        var ldap = $("<td><a href='http://wwwin-tools.cisco.com/dir/details/" +name +"' target='ldap'>LDAP</a></td>");
        tr.append(ldap);
        tr.click(playerClicked);

        table.append(tr);
    }
    $("#highscore").html(table);    
}

function loadKnockoutScores() {

    var q = g_results.quarterFinals;
    var s = g_results.semiFinals;
    var f = g_results.finals;
    var w = g_results.winner;

    var table = $("<table/>").addClass("box");
    $("#knockoutMatches").html(table);

    table.append("<tr><th>Quarterfinals</th><th>User bet</th><th>Points</th></tr>")
    table.attr("id", "quarterFinals");

    for (var i=0; i<q.length; i++) {
        var tr = $("<tr>");
        tr.append($("<td>" + icon(q[i].team1) + q[i].team1 + "</td>").addClass("team"));
        tr.append(cell("").addClass("userbet"));
        tr.append(cell("").addClass("points"));
        table.append(tr);

        var tr2 = $("<tr>");
        tr2.append($("<td>" + icon(q[i].team2) + q[i].team2 + "</td>").addClass("team"));
        tr2.append(cell("").addClass("userbet"));
        tr2.append(cell("").addClass("points"));

        table.append(tr2);
    }

    var table = $("<table/>").addClass("box");

    table.append("<tr><th>Semifinals</th><th>User bet</th><th>Points</th></tr>")
    table.attr("id", "semiFinals");

    for (var i=0; i<s.length; i++) {
        var tr = $("<tr>");
        tr.append($("<td>" + icon(s[i].team1) + s[i].team1 + "</td>").addClass("team"));
        tr.append(cell("").addClass("userbet"));
        tr.append(cell("").addClass("points"));
        table.append(tr);

        var tr2 = $("<tr>");
        tr2.append($("<td>" + icon(s[i].team2) + s[i].team2 + "</td>").addClass("team"));
        tr2.append(cell("").addClass("userbet"));
        tr2.append(cell("").addClass("points"));

        table.append(tr2);
    }
    $("#knockoutMatches").append(table);

    var table = $("<table/>").addClass("box");
    table.append("<tr><th>Finals</th><th>User bet</th><th>Points</th></tr>")
    table.attr("id", "finals");

        var tr = $("<tr>");
        tr.append($("<td>" + icon(f.team1) + f.team1 + "</td>").addClass("team"));
        tr.append(cell("").addClass("userbet"));
        tr.append(cell("").addClass("points"));
        table.append(tr);

        var tr2 = $("<tr>");
        tr2.append($("<td>" + icon(f.team2) + f.team2 + "</td>").addClass("team"));
        tr2.append(cell("").addClass("userbet"));
        tr2.append(cell("").addClass("points"));

        table.append(tr2);

    $("#knockoutMatches").append(table);

    var table = $("<table/>").addClass("box");
    table.append("<tr><th>Winner</th><th>User bet</th><th>Points</th></tr>")
    table.attr("id", "winner");
    var tr = $("<tr>");
    tr.append($("<td>" + icon(w) + w + "</td>").addClass("team"));
    tr.append(cell("").addClass("userbet"));
    tr.append(cell("").addClass("points"));
    table.append(tr);
    $("#knockoutMatches").append(table);

}

function playerClicked() {
    var name = $(".name", this).html();

    $(".highlight").removeClass("highlight"); // remove all
    $("td", this).addClass("highlight");

    loadPlayer(name);
}

function calculateAllScores() {
    var scores = [];
    for (var i=0; i<g_playerData.length; i++) {
        var player = g_playerData[i];
        scores.push({name: player.player, points: parseInt(calculateScore(player))});
    }

    scores.sort(function(a, b) {
       //return parseInt(a.points) < parseInt(b.points); // doesn't work in IE
       return parseInt(b.points) - parseInt(a.points);
    });
    return scores;
}

function receivePlayerBets(data) {
    g_playerData = data;
    console.log(g_results);
    console.log(g_playerData);
    loadScores();
}

/*
How are the points calculated?
Not all the details are completely finalized, but it will be something like the following:

In the group play:
2 points for choosing correct result (team 1 wins, draw or team 2 wins)
1 point for correct score (2-3, 0-0) etc

Dont put the team points in the spreadsheets, these are calculated automatically.

In the knock-out stages you don't get points for correct match score, just for having corret teams. Just enter a score that gives the correct winner (eg 1-0 to the team that you think will win). Obviously there cannot be a draw in the knock-out stages.

3 points for any quarter finalist you chose correctly.
5 points for any semifinalist you chose correctly.
10 points for any finalist you chose correctly.
20 points for correct winner.
*/
