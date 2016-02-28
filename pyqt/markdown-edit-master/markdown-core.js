.pragma library;

/*** Prototype additions ***/

String.repeat = function (chr, count) {
    return new Array (count +1).join (chr);
}

String.prototype.contains = function (str) {
    return (this.indexOf (str) > -1);
}

String.prototype.startsWith = function (str) { // check if string starts with a given sub-string
    return (str && str.length <= this.length ? (this.substr (0, str.length) === str) : false);
}

String.prototype.normalize = function () { // replace WIN CRLF or MAC CR with LINUX LF
    return this.replace (/\r\n/gmi, '\n').replace (/\r/gmi, '\n');
}

String.prototype.detab = function () { // replace TABS with 4 UNBREAKABLE SPACES
    return this.replace (/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;");
}

String.prototype.entitize = function () { // replace HTML special chars with XML entities
    return this.replace (/&/g, "&amp;").replace (/</g, "&lt;").replace (/>/g, "&gt;");
}

String.prototype.first = function () {
    return this [0];
}

String.prototype.last = function () {
    return this [this.length -1];
}

Array.prototype.first = function () {
    return this [0];
}

Array.prototype.last = function () {
    return this [this.length -1];
}

/*** Classes for primitive tokens ***/

function HashTag (count) {
    this.count = Number (count || 1);
}

function UnderScore (count) {
    this.count = Number (count || 1);
}

function Asterisk (count) {
    this.count = Number (count || 1);
}

function Hyphen (count) {
    this.count = Number (count || 1);
}

function WhiteSpace (count) {
    this.count = Number (count || 1);
}

function RawText (text) {
    this.text   = String (text || "");
    this.count  = Number (this.text.length);
}

function Digits (digits) {
    this.digits = String (digits || "");
    this.count  = Number (this.digits.length);
}

function GreaterThan (count) {
    this.count = Number (count || 1);
}

function LessThan (count) {
    this.count = Number (count || 1);
}

function BackQuote (count) {
    this.count = Number (count || 1);
}

function Tilde (count) {
    this.count = Number (count || 1);
}

function Pipe (count) {
    this.count = Number (count || 1);
}

function NewLine (count) {
    this.count = Number (count || 1);
}

/*** ***/

function Bullet (nesting, numbering) {
    this.nesting   = Number  (nesting   || -1);
    this.numbering = Boolean (numbering || false);
}

function Code (code) {
    this.code = String (code || "");
}

function FencedBlock (block, language) {
    this.block    = String (block    || "");
    this.language = String (language || "");
}

function Link (name, url) {
    /*** Named link : capturing match (/\[([^\]]*)\]\(([^\)]*)\)/) = ["fullmatch", "name", "url"] ***/
    /*** Auto link : capturing match (/<([^>]*)>/) = ["fullmatch", "url"] ***/
    this.name = String (name || "");
    this.url  = String (url  || "");
}

function Image (title, url) {
    /*** Image : capturing match (/\!\[([^\]]*)\]\(([^\)]*)\)/) = ["fullmatch", "title", "url"] ***/
    this.title = String (title || "");
    this.url   = String (url   || "");
}

function Quote (nesting) {
    this.nesting = Number (nesting || -1);
}


function Strikeout () {

}

function TableColumn () {

}


/********************************************************************/

function md2html (arg) {
    var md  = ('\n\n\n' + (arg.normalize () || "") + '\n\n\n'); // Make sure text begins and ends with a couple of newlines
    var ret = "";
    var lst = [];

    // tokenize MarkDown
    var tmp;
    var cnt = 0;
    var txt = "";
    var pos = 0;
    while (pos < md.length) {
        var chr = md [pos];
        console.log (">", "pos=", pos, "chr=", (chr !== "\n" ? chr : "\\n"));

        var token    = null;
        var consumed = 0;

        if (chr === "#") { // HashTag
            if ((tmp = md.substr (pos).match (/#+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new HashTag (cnt);
                consumed = cnt;
            }
        }
        else if (chr === "*") { // Asterisk
            if ((tmp = md.substr (pos).match (/\*+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new Asterisk (cnt);
                consumed = cnt;
            }
        }
        else if (chr === "_") { // UnderScore
            if ((tmp = md.substr (pos).match (/_+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new UnderScore (cnt);
                consumed = cnt;
            }
        }
        else if (chr === "-") { // Hyphen
            if ((tmp = md.substr (pos).match (/-+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new Hyphen (cnt);
                consumed = cnt;
            }
        }
        else if (chr === " ") { // WhiteSpace
            if ((tmp = md.substr (pos).match (/ +/)) !== null) {
                cnt      = tmp [0].length;
                token    = new WhiteSpace (cnt);
                consumed = cnt;
            }
        }
        else if (chr === "`") { // BackQuote
            if ((tmp = md.substr (pos).match (/`+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new BackQuote (cnt);
                consumed = cnt;
            }
        }
        else if (chr === "<") { // LessThan
            if ((tmp = md.substr (pos).match (/<+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new LessThan (cnt);
                consumed = cnt;
            }
        }
        else if (chr === ">") { // GreaterThan
            if ((tmp = md.substr (pos).match (/>+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new GreaterThan (cnt);
                consumed = cnt;
            }
        }
        else if (chr === "\n") { // NewLine
            if ((tmp = md.substr (pos).match (/\n+/)) !== null) {
                cnt      = tmp [0].length;
                token    = new NewLine (cnt);
                consumed = cnt;
            }
        }
        else if (chr.match (/\d/)) { // Digits
            if ((tmp = md.substr (pos).match (/([\d\.]+)/)) !== null) {
                cnt      = tmp [0].length;
                token    = new Digits (tmp [1]);
                consumed = cnt;
            }
        }
        if (token !== null) {
            console.log (">>>", "token=", JSON.stringify (token), "consumed=", consumed);
            if (txt !== "") {
                lst.push (new RawText (txt));
                txt = "";
            }
            lst.push (token);
            pos += consumed;
        }
        else {
            txt += chr;
            pos++;
        }
    }
    console.log ("lst=", JSON.stringify (lst));

    // convert tokens to HTML
    var tag      = "";
    var tags     = [];
    var newline  = false;
    var verbatim = false;
    for (var idx = 0; idx < lst.length; idx++) {
        var currTag   = tags.last ();

        var beforePrevToken = lst [idx -2];
        var prevToken       = lst [idx -1];
        var currToken       = lst [idx];
        var nextToken       = lst [idx +1];
        var afterNextToken  = lst [idx +2];

        var used = false;

        switch (currToken.constructor) {
        case NewLine:
            if (!verbatim) {
                if (currTag === "h1" || currTag === "h2" || currTag === "h3" || currTag === "h4" || currTag === "h5" || currTag === "h6") {
                    // header line ends here
                    currTag = tags.pop ();
                    ret += ("</" + currTag + ">");
                    used = true;
                }
                else if (currTag === "li") {
                    // list item ends here
                    currTag = tags.pop ();
                    ret += ("</" + currTag + ">");
                    used = true;
                    // the list block ends here
                    currTag = tags.pop (); // should be ul / ol
                    ret += ("</" + currTag + ">");
                    used = true;
                }
                else if (currTag === "blockquote") {
                    // blockquote ends here
                    currTag = tags.pop ();
                    ret += ("</" + currTag + ">");
                    used = true;
                }
                else {
                    // simple line return in-text
                    ret += "<br />";
                    used = true;
                }
            }
            newline = true;
            break;

        case Asterisk:
            if (!verbatim) {
                if (newline && nextToken.constructor === WhiteSpace) {
                    // unordered bullet list item starts here
                    if (currTag !== "ul") {
                        // open list block
                        currTag = "ul";
                        tags.push (currTag);
                        ret += ("<" + currTag + ">");
                    }
                    // open list item
                    currTag = "li";
                    tags.push (currTag);
                    ret += ("<" + currTag + ">");
                    used = true;
                }
                else {
                    // emphasis
                    if (currToken ["count"] === 1) {
                        if (currTag !== "em") {
                            // emphasis starts here
                            currTag = "em";
                            tags.push (currTag);
                            ret += ("<" + currTag + ">");
                        }
                        else {
                            // emphasis end here
                            currTag = tags.pop ();
                            ret += ("</" + currTag + ">");
                        }
                        used = true;
                    }
                    else if (currToken ["count"] === 2) {
                        if (currTag !== "strong") {
                            // strong starts here
                            currTag = "strong";
                            tags.push (currTag);
                            ret += ("<" + currTag + ">");
                        }
                        else {
                            // strong end here
                            currTag = tags.pop ();
                            ret += ("</" + currTag + ">");
                        }
                        used = true;
                    }
                    else {
                        if (nextToken.constructor === NewLine) {
                            // horizontal ruler
                            ret += ("<hr />");
                            used = true;
                        }
                    }
                }
            }
            newline = false;
            break;

        case UnderScore:
            if (!verbatim) {
                if (currToken.count === 1) {
                    if (currTag !== "em") {
                        // emphasis starts here
                        currTag = "em";
                        tags.push (currTag);
                        ret += ("<" + currTag + ">");
                    }
                    else {
                        // emphasis end here
                        currTag = tags.pop ();
                        ret += ("</" + currTag + ">");
                    }
                    used = true;
                }
                else if  (currToken.count === 2) {
                    if (currTag !== "strong") {
                        // strong starts here
                        currTag = "strong";
                        tags.push (currTag);
                        ret += ("<" + currTag + ">");
                    }
                    else {
                        // strong end here
                        currTag = tags.pop ();
                        ret += ("</" + currTag + ">");
                    }
                    used = true;
                }
                else {
                    if (nextToken.constructor === NewLine) {
                        // horizontal ruler
                        ret += ("<hr />");
                        used = true;
                    }
                }
            }
            newline = false;
            break;

        case Hyphen:
            if (!verbatim && newline && nextToken.constructor === WhiteSpace) {
                // unordered bullet list item starts here
                if (currTag !== "ul") {
                    // open list block
                    currTag = "ul";
                    tags.push (currTag);
                    ret += ("<" + currTag + ">");
                }
                // open list item
                currTag = "li";
                tags.push (currTag);
                ret += ("<" + currTag + ">");
                used = true;
            }
            newline = false;
            break;

        case HashTag:
            if (!verbatim && newline) {
                // header line starts here
                currTag = ("h" + currToken ["count"]);
                tags.push (currTag);
                ret += ("<" + currTag + ">");
                used = true;
            }
            newline = false;
            break;

        case BackQuote:
            if (currToken.count === 1) {
                if (currTag === "code") {
                    // 'code' tag end here
                    currTag = tags.pop (currTag);
                    ret += ("</" + currTag + ">");
                    verbatim = false;
                    used = true;
                }
                else {
                    // 'code' tag starts here
                    currTag = ("code");
                    tags.push (currTag);
                    ret += ("<" + currTag + ">");
                    verbatim = true;
                    used = true;
                }
            }
            else {
                if (currTag === "pre") {
                    // 'pre' tag end here
                    currTag = tags.pop (currTag);
                    ret += ("</" + currTag + ">");
                    verbatim = false;
                    used = true;
                }
                else {
                    // 'pre' tag starts here
                    currTag = ("pre");
                    tags.push (currTag);
                    ret += ("<" + currTag + ">");
                    verbatim = true;
                    used = true;
                }
            }
            newline = false;
            break;

        case Digits:
            if (!verbatim && newline && nextToken.constructor === WhiteSpace) {
                if (currToken ["digits"].last () === ".") {
                    // numbered list item starts here
                    if (currTag !== "ol") {
                        // open list block
                        currTag = "ol";
                        tags.push (currTag);
                        ret += ("<" + currTag + ">");
                    }
                    // open list item
                    currTag = "li";
                    tags.push (currTag);
                    ret += ("<" + currTag + ">");
                    used = true;
                }
            }
            newline = false;
            break;

        case GreaterThan:
            if (!verbatim && newline) {
                // quote block starts here
                currTag = "blockquote";
                tags.push (currTag);
                ret += ("<" + currTag + ">");
                used = true;
            }
            newline = false;
            break;

        case LessThan:
            newline = false;
            break;

        case RawText:
            newline = false;
            break;

        case WhiteSpace:
            // do nothing
            break;

        default:
            console.warn ("Unhandled token type :", currToken.constructor.name);
            break;
        }

        if (!used) {
            switch (currToken.constructor) {
            case Asterisk:    ret += String.repeat ("*", currToken ["count"]); break;
            case UnderScore:  ret += String.repeat ("_", currToken ["count"]); break;
            case Hyphen:      ret += String.repeat ("-", currToken ["count"]); break;
            case HashTag:     ret += String.repeat ("#", currToken ["count"]); break;
            case GreaterThan: ret += String.repeat ("&gt;", currToken ["count"]); break;
            case LessThan:    ret += String.repeat ("&lt;", currToken ["count"]); break;
            case WhiteSpace:  ret += String.repeat (" ", currToken ["count"]); break;
            case NewLine:     ret += String.repeat ("\n", currToken ["count"]); break;
            case Digits:      ret += currToken ["digits"]; break;
            case RawText:     ret += currToken ["text"]; break;
            }
        }

    }

    // post process HTML code for polishing
    ret = ret.replace (/<\/ul><ul>/g, "");
    ret = ret.replace (/<\/ol><ol>/g, "");

    console.log ("ret=", ret);

    // return HTML fragment
    return ret;
}
