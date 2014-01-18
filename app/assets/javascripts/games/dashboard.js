$(function() {
  var link_url = $('#gameinfo').data('link-url');
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/g/' + link_url + '/players/new', function (data) {
    var jsonData = $.parseJSON(data);
    $('#playertabledata').append('<tr><td>' + jsonData.name + '</td></tr>');
  });
  faye.subscribe('/g/' + link_url + '/answers', function (data) {
    var jsonData = $.parseJSON(data);
    console.log(jsonData);
    $('#answertable span[data-player-id=' + jsonData.id + ']').remove();
  });
});