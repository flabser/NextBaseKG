
var app ={
	name:null
}
function changeSystemSettings(el){
	valCookie=$(el).val();
	$.cookie($(el).attr("id"), valCookie,{
		path:"/",
		expires:30
	});
	window.location.reload();
}

function makeCookie(){
	var username="",
		password="",
		expireAt= new Date;
	expireAt.setMonth(expireAt.getMonth() + 1);
	username=$("#login").val();
	password=$("#pwd").val();
	document.cookie=app.name+"="+username+"$"+password+"; path=/; expires="+expireAt.toGMTString();
}

function key(event){
	if (event.keyCode==13){ 
		ourSubmit();
	}
}

function getCookie(name) {
	if($.cookie('lang') == null){
		$.cookie('lang', "RUS",{
			path:"/",
			expires:30
		});
	}
	if($.cookie('skin') == null){
		$.cookie('skin', "classic",{
			path:"/",
			expires:30
		});
	}
    var dc = document.cookie,
    	prefix = name + "=",
    	begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    }else{
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
        end = dc.length;
    }
    text=unescape(dc.substring(begin + prefix.length, end));
    document.form.login.value=text.split("$")[0];
    document.form.pwd.value=text.split("$")[1];
}

function ourSubmit(type){
	if($("#login").val() == ""){
		infoDialog("Введите имя пользователя")
		return;
	}else{
		if($("#pwd").val() =="" && type=="default"){
			infoDialog("Заполните пароль")
			return;
		}
		$("form").submit();
	}
}