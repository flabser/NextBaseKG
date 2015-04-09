/* author John - Lab of the future */
var req
function dragAndDropAttach(){
	jQuery.event.props.push('dataTransfer');
	var data = {
		type : 'rtfcontent',
		formsesid : $("input[name=formsesid]").val()
	};
	$("body").ajaxSend(function(e, xhr, settings){
		alert("На сервер только что был отправлен ajax-запрос страницы " + settings.url);
	});
	$('#drop-files').bind('drop',function(e) {
		var files = e.dataTransfer.files;
		$.each(files,function(index, file){
			var boundary = String(Math.random()).slice(2),
				boundaryMiddle = '--' + boundary + '\r\n',
				boundaryLast = '--' + boundary + '--\r\n',
				body = ['\r\n'];
			for (var key in data) {
				body.push('Content-Disposition: form-data; name="'+key+'"\r\n\r\n'+data[key]+'\r\n');
			}
			var fileReader = new FileReader();
			fileReader.onload = (function(file) {
				return function(e) {
					body.push('Content-Disposition: form-data; name="rtfcontent"; filename="'+UrlDecoder._utf8_encode(file.name)+'"\r\nContent-Type: '+file.type +'\r\n\r\n'+ this.result+'\r\n');
					body = body.join(boundaryMiddle) + boundaryLast;
					var xhr = new XMLHttpRequest();
					xhr.open('POST', 'Uploader', true);
					xhr.setRequestHeader('Content-Type','multipart/form-data; boundary=' + boundary);
					xhr.onreadystatechange = function() {
					if (this.readyState != 1) return;
						filename=file.name
						req = $.get("Uploader",processStateChange);
					}
					xhr.sendAsBinary(body);
				};
			})(files[index]);
			fileReader.readAsDataURL(file);
			//fileReader.readAsBinaryString(file,"UTF-8");
		})
	})
}