function test(url){
  var form = document.createElement('form');
  form.method = 'post'
  form.action = url;
  document.body.appendChild(form)
  form.submit();
}