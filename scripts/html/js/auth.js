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
    var file = new Blob([data], {type: "txt"});
    if (window.navigator.msSaveOrOpenBlob) // IE10+
        window.navigator.msSaveOrOpenBlob(file, "file");
    else { // Others
        var a = document.createElement("a"),
                url = URL.createObjectURL(file);
        a.href = url;
        a.download = "file";
        document.body.appendChild(a);
        a.click();
        setTimeout(function() {
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);  
        }, 0); 
    }
}
