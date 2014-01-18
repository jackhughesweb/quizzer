(function() {

  FastClick.attach(document.body);
  
  var link_url = $('#gameinfo').data('link-url');
  var faye = new Faye.Client('http://192.168.1.14:9292/faye');
  faye.subscribe('/g/' + link_url + '/questions', function (data) {
    var jsonData = $.parseJSON(data);
    $('#gamecontent').html('<a href="#" class="btn answerbtn btn-large" id="btn1" data-question-id="' + jsonData.id + '" data-answer="' + jsonData.correct_answer + '">' + jsonData.correct_answer + '</a><br><br><a href="#" class="btn answerbtn btn-large" id="btn2" data-question-id="' + jsonData.id + '" data-answer="' + jsonData.altone_answer + '">' + jsonData.altone_answer + '</a><br><br><a href="#" class="btn answerbtn btn-large" id="btn3" data-question-id="' + jsonData.id + '" data-answer="' + jsonData.alttwo_answer + '">' + jsonData.alttwo_answer + '</a><br><br><a href="#" class="btn answerbtn btn-large" id="btn4" data-question-id="' + jsonData.id + '" data-answer="' + jsonData.altthree_answer + '">' + jsonData.altthree_answer + '</a>');
  });

  faye.subscribe('/g/' + link_url + '/end', function (data) {
    $('#gamecontent').html(''); 
  });

  $('#gamecontent').on("click", ".answerbtn", function(e) { 
    var link_url = $('#gameinfo').data('link-url');
    $.post('http://192.168.1.14:3000/g/' + link_url + '/questions/answer', { question_id: $(this).data('question-id'), answer: $(this).data('answer') } );
    $('#gamecontent').html('<p>Waiting...</p><div class="spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>');
    e.preventDefault();
  });

}).call(this);
