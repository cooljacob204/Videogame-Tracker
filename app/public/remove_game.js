function remove_game(url){
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
        window.location.replace('/games')
      } else {
        document.body.innerHTML = this.response // allows erb to render an error
      }
    }
  };

  xhttp.open("DELETE", url, true);
  xhttp.send();
}