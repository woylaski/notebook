$(document).ready(init);

function init() {
}

function search() {
    var query = $("#searchTerm").val();
    window.location = '/search/' + query;
}
