$(document).ready(function(){
	$("#btn-login").click(function(){
		var username = $("#inputUsername").val();
		var password = $("#inputPassword").val();
		if( username != '' && password != ''){
			$.post("http://" + document.location.host + "/new-client",{ login: username, password: password}, function(data) {
				saveFile(data);
				document.location = document.location.href + "/new-client?contest_id=1&SID=" + getCookie("EJSID");
			});
		}
	});
});

function getCookie(name) {
  var matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function saveFile(data) {
  var text = data;
  var filename = "File";
  var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
  saveAs(blob, filename+".txt");
}
