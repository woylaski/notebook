<h1>{{term.term}}</h1>

<form method="POST" action="/save/{{term.term}}">

    <p>
        <input type="text" name="term" value="{{term.term}}" />
    </p>
    <p>
        <textarea name="explanation">{{term.explanation}}</textarea>
    </p>
    <p>
        Username:
        <input type="text" name="username" value="{{username}}" />
    </p>

    <p>
        <input type="submit" />
    </p>
</form>

%rebase mainlayout
