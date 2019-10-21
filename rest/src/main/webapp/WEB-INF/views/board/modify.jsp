<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
.uploadResult{
	width:100%;
	background-color:gray;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}
.uploadResult ul li{
	list-sytle:none;
	padding:10px;
	align-content:center;
	text-align:center;
}
.uploadResult ul li img{
	width:100px;
}
.uploadResult ul li span{
	color:white;
}
.bigPictureWrapper{
	postion:absolute;
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

<%@include file="../includes/header.jsp"%>

<div class="container-fluid">

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">Board Register</div>
				<div class="card-body">
					<form role="form" action="/board/modify" method="post">
						<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
						<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
						<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
						<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
						<div class="form-group">
							<label>Bno</label> <input class="form-control" name="bno"
								value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title"
								value='<c:out value="${board.title}"/>'>
						</div>
						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name="content"><c:out
									value="${board.content}" /></textarea>
						</div>
						<div class="form-group">
							<label>Writer</label> <input class="form-control" name="writer"
								value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>
						<div class="from-group">
							<label>RegDate</label>
							<input class="form-control" name="regDate" value="<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>" readonly="readonly">
						</div>
						<div class="from-group">
							<label>Update Date</label>
							<input class="form-control" name="updateDate" value="<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>" readonly="readonly">
						</div>
						<button type="submit" data-oper="modify" class="btn btn-primary">Modify</button>
						<button type="submit" data-oper="remove" class="btn btn-warning">Remove</button>
						<button type="submit" data-oper="list" class="btn btn-info">List</button>
					</form>

					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-header">Files</div>
								<div class="card-body">
									<div class="form-group uploadDiv">
										<input type="file" name="uploadFile" multiple>
									</div>
								<div class="card-body">
									<div class="uploadResult">
										<ul>

										</ul>
									</div>
								</div>
								<div class="bigPictureWrapper">
									<div class="bigPicture"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>
<!-- /.container-fluid -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		const formObj = $("form");
		
		$('button').on("click", function(e){
			e.preventDefault();
			const oper = $(this).data("oper");
			console.log(oper);
			
			if(oper === 'remove'){
				formObj.attr("action", "/board/remove");
			} else if(oper === 'list'){
				formObj.attr("action", "/board/list").attr("method", "get");
				const pageNumTag = $("input[name='pageNum']").clone();
				const amountTag = $("input[name='amount']").clone();
				const keywordTag = $("input[name='keyword']").clone();
				const typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			} else if(oper === 'modify'){
				console.log("submit clicked");
				let str = "";
				$(".uploadResult ul li").each(function(i, obj){
					let jobj = $(obj);
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
				});
				formObj.append(str);
			}
			formObj.submit();
		});
		
		const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		const maxSize = 5242880;
		
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
		
		function showUploadResult(uploadResultArr){
			console.log(uploadResultArr);
			if(!uploadResultArr || uploadResultArr.length == 0){return;}
			const uploadUL = $(".uploadResult ul");
			let str = "";
			$(uploadResultArr).each(function(i, obj){
				if(obj.image){
					let fileCallPath = encodeURIComponent(obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
					console.log(fileCallPath);
					str += "<li data-path='" + obj.uploadPath +"' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'></div></li>";
				}else{
					let fileCallPath = encodeURIComponent(obj.uploadPath + obj.uuid + "_" + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					str += "<li data-path='" + obj.uploadPath +"' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></div></li>";
				}
			});
			uploadUL.append(str);
		}
		
		$("input[type='file']").change(function(e){
			const formData = new FormData();
			const inputFile = $("input[name='uploadFile']");
			const files = inputFile[0].files;
			
			for(let i=0; i<files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
		

			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadResult(result);
				}
			});
		});
		
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			if(confirm("Remove this file? ")){
				let targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
	});
	
</script>

<script>
	$(document).ready(function(){
		(function(){
			let bno = "<c:out value='${board.bno}'/>";
	
			$.getJSON("/board/getAttachList", { bno : bno }, function(arr){
				console.log(arr);
				let str = "";
			
				$(arr).each(function(i, attach){
					if(attach.fileType){
						let fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "'data-type='" + attach.fileType + "'><div>";
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'></div></li>";
					} else{
						let fileCallPath = encodeURIComponent(attach.uploadPath + attach.uuid + "_" + attach.fileName);
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "'data-type='" + attach.fileType + "'><div>";
						str += "<span>" + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'></div></li>";
					}
				});
			
				$(".uploadResult ul").html(str);
			});
		})();
	});
</script>

