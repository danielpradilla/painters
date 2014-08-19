

//https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="Palma Gionvanne" Painter commons.wikimedia

searchPainter = function(name) {
  var baseUrl ='https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=';
  var url = baseUrl + name + ' painting commons.wikimedia' + '&callback=?';
  console.log('getting painting for ' + name);
//  console.log(url);
  $.getJSON(url, function(json){
//    console.log(json);
    var results=json.responseData.results;
//    console.log(results[0]);
    if (results[0]){
      setImage(results[0].url,results[0].originalContextUrl);    
    } else {
      setDefaultImage();
    }
  })
}

setImage = function(url, source) {
  var html = '<a target="_blank" href="'+source+'"><img src="'+url+'"/></a>'+
             '<p><a target="_blank" href="'+source+'">Source</a></p>';
  $('#painting').html(html);
}
setDefaultImage = function() {
  $('#painting').html('<p>click on a painter to see a sample</p>');  
}
getPainterName = function(el) {
  return $(el.children[0]).html();
}

initPainterClick = function() {
  console.log('init painter click');
  $('#painterstable tbody tr').on('click',function(){
//    console.log(this);
    painter = getPainterName(this);
    searchPainter(painter);
  });
}
initPainters = function() {
  console.log('init-table');
  setDefaultImage();
  initPainterClick();
}
$(document).ready(function(){


});

