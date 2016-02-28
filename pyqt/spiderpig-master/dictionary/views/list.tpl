
<a href="/create">Create new</a>

<p>All terms:

<ul>
%for term in allTerms:
    <li><a href="/show/{{term.term}}">{{term.term}}</a> - {{term.explanation}}</li>
%end
</ul>

<a href="/create">Create new</a>

%rebase mainlayout
