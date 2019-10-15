<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<style>
.uploadResult{
	width:100%;
	background-color:gray
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.uploadResult ul li img{
	width:20px;
}
.bigPictureWrapper{
	position:absolute;
	display:none;
	justify-content:center;
	align-items:center;
	top:0%;
	width:100%;
	height:100%;
	background-color:gray;
	z-index:100;
	background:rgba(255,255,255,0.5);
}
.bigPicture{
	position:relative;
	display:flex;
	justify-content:center;
	align-items:center;
}
.bigPicture img{
	width:600px;
}

</style>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>
<button id="uploadBtn">Upload</button>

<div class="uploadResult">
	<ul>
	
	</ul>
</div>
	
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>


<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
 
<script>
	$(document).ready(function(){
		
		const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		const maxSize = 5242880;
		const cloneObj = $(".uploadDiv").clone();
		const uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(arr){
			let str = "";
			$(arr).each(function(i, obj){
				if(!obj.image){
					let fileCallPath = encodeURIComponent(obj.uploadPath + obj.uuid + "_" + obj.fileName);
					console.log(fileCallPath);
					str += "<li><a href='/controller/download?fileName=" + fileCallPath + "'><img src='resources/img/attach.png'>" + obj.fileName + "</a></li>";
				} else{
					let fileCallPath = encodeURIComponent(obj.uploadPath + "s_" + obj.uuid + "_" + obj.fileName);
					let originPath = (obj.uploadPath + obj.uuid + "_" + obj.fileName).replace(new RegExp(/\\/g), "/");
					str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/controller/display?fileName=" + fileCallPath + "'>" + obj.fileName + "</a></li>";
				}
			});
			uploadResult.append(str);
		}
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다");
				return false;
			}
			return true;
		}
		
		$("#uploadBtn").on("click", function(e){
			const formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			let files = inputFile[0].files;
			console.log(files);
			
			for(let i=0; i<files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "/controller/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				dataType : "JSON",
				success : function(result){
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			});
		});
		
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
			setTimeout(() =>{
				$(this).hide();
			}, 1000);
		});
	});
</script>

<script>
	function showImage(fileCallPath){
		//console.log(fileCallPath);
		$(".bigPictureWrapper").css("display","flex").show();
		$(".bigPicture").html("<img src='/controller/display?fileName=" + encodeURI(fileCallPath) + "'>").animate({width:'100%', height:'100%'}, 1000);
	}
</script>
</body>
</html>