.pragma library

function safeHtml(str) {
	return (str === undefined) ? "undefined" : str
		.replace(/&/g, "&amp;")
		.replace(/"/g, "&quot;")
		.replace(/'/g, "&#39;")
		.replace(/</g, "&lt;")
		.replace(/>/g, "&gt;");
}

function format(str) {
	var fg = 0;
	var bg = 1;
	var bold = false;
	var italic = false;
	var underline = false;

	var textSpans = [];
	var current = "";

	function nextTextSpan() {
		if (current !== "") {
			textSpans.push({ fg: fg, bg: bg, bold: bold, italic: italic, underline: underline, text: current });
			current = "";
		}
	}

	for (var i = 0; i < str.length; i++) {
		switch (str[i]) {
			case "\x03":
				nextTextSpan();

				var nextColors = str.substr(i + 1, 5).match(/^(\d\d?)(?:,(\d\d?))?/);
				if (nextColors !== null) {
					fg = parseInt(nextColors[1]);
					if (nextColors[2] !== undefined) {
						bg = parseInt(nextColors[2]);
					}
					i += nextColors[0].length;
				}
				else {
					fg = 0;
					bg = 1;
				}
				break;

			case "\x0f":
				nextTextSpan();

				fg = 0;
				bg = 1;
				bold = false;
				italic = false;
				underline = false;
				break;

			case "\x02":
				nextTextSpan();

				bold = true;
				break;

			case "\x1d":
				nextTextSpan();

				italic = true;
				break;

			case "\x1f":
				nextTextSpan();

				underline = true;
				break;

			default:
				current += str[i];
				break;
		}
	}

	nextTextSpan();

	var result = textSpans.reduce(function (previous, current) {
		return previous +
			'<span style="white-space: pre-wrap; ' +
			'color: red; ' +
			'background-color: green; ' +
			(current.bold ? 'font-weight: bold; ' : '') +
			(current.italic ? 'font-style: italic; ' : '') +
			(current.underline ? 'text-decoration: underline; ' : '') +
			'">' +
			current.text +
			'</span>';
	}, "");

	return result;
}

function display(message) {
	switch (message.objectType) {
		case "ReceivedMessage":
			switch (message.messageType) {
				default:
					return format(
						safeHtml(
							">>> " +
							"[" + message.messageType.cls + "." + message.messageType.name + "] " +
							"<" + message.prefix + "> "
						) +
						Object.keys(message.parameters).map(function (key) { return safeHtml(key) + ": " + safeHtml(message.parameters[key]); }).join(", ")
					);
			}

		case "SentMessage":
			switch (message.messageType) {
				default:
					return format(
						safeHtml(
							"<<< " +
							"[" + message.messageType.cls + "." + message.messageType.name + "] " +
							"<" + message.prefix + "> "
						) +
						Object.keys(message.parameters).map(function (key) { return safeHtml(key) + ": " + safeHtml(message.parameters[key]); }).join(", ")
					);
			}
	}
}
