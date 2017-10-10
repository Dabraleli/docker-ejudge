$(document).ready(function(){
	$("#btn-login").click(function(){
		var username = $("#inputUsername").val();
		var password = $("#inputPassword").val();
		if( username != '' && password != ''){
			$.post("http://37.75.251.35:20128/new-client",{ login: username, password: password}, function(data) {
			});
		}
	});
});
