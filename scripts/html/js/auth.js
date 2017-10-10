$(document).ready(function(){
	$("#btn-login").click(function(){
		var username = $("#inputUsername").val();
		var password = $("#inputPassword").val();
		if( username != '' && password != ''){
			$.post("http://" + document.location.host + "/new-client",{ login: username, password: password}, function(data) {
				alert(data);
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
