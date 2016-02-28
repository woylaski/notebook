<h1>New term</h1>

<form method="POST" action="/savenew">

    <p>
        Term:
        <input type="text" name="term" value="" />
    </p>
    <p>
        Description:
        <textarea name="explanation"></textarea>
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
