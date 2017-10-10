$(document).ready(function(){
	$("#btn-login").click(function(){
		var username = $("#inputUsername").val();
		var password = $("#inputPassword").val();
		if( username != '' && password != ''){
			$.post("http://" + document.location.host + "/new-client",{ login: username, password: password}, function(data) {
				alert(data);
			});
		}
	});
});
