<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
					<div class="form-group">
						<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Text area</label> <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>
					<button data-oper="modify" class="btn btn-primary">Modify</button>
					<button data-oper="list" class="btn btn-info">List</button>
					
					<form id="operForm" action="/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
						<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
						<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
						<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
						<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">
					<i class="fa fa-comments fa-fw"></i> Reply
					<button id="addReplyBtn" class="btn btn-primary btn-xs float-right">New Reply</button>
				</div>

				<div class="card-body">
					<ul class="chat">
					</ul>
				</div>
				
				<div class="card-footer">
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLable">Reply Modal</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label>
						<input class="form-control" name="reply" value="new Reply">
					</div>
					<div class="form-group">
						<label>Replyer</label>
						<input class="form-control" name="replyer" value="replyer">
					</div>
					<div class="form-group">
						<label>Reply Date</label>
						<input class="form-control" name="replyDate" value=''>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="modalModBtn" class="btn btn-warning">Modify</button>
					<button type="button" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
					<button type="button" id="modalRegisterBtn" class="btn btn-primary">Register</button>
					<button type="button" id="modalCloseBtn" class="btn btn-info">Close</button>
				</div>
			</div>
		</div>
	</div>


</div>
<!-- /.container-fluid -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		const bnoValue = "<c:out value='${board.bno}'/>";
		const replyUL = $(".chat");

		showList(1);

		function showList(page){
			replyService.getList({bno : bnoValue, page : page || 1}, function(replyCnt, list){
				console.log("replyCnt : " + replyCnt);
				console.log("list : " + list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				let str="";
				if(list == null || list.length == 0){
					replyUL.html("");
					return;
				}
				for(let i=0; i<list.length; i++){
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
					str += "<small class='float-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				replyUL.html(str);
				showReplyPage(replyCnt);
			});
		}
		
		const modal = $("#myModal");
		const modalInputReply = modal.find("input[name='reply']");
		const modalInputReplyer = modal.find("input[name='replyer']");
		const modalInputReplyDate = modal.find("input[name='replyDate']");
		const modalModBtn = $("#modalModBtn");
		const modalRemoveBtn = $("#modalRemoveBtn");
		const modalRegisterBtn = $("#modalRegisterBtn");
		
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalRegisterBtn.show();
			modal.modal("show");
		});
		
		$(".chat").on("click", "li", function(e){
			const rno = $(this).data("rno"); 
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				modal.modal("show");
			});
		});
		
		modalRegisterBtn.on("click", function(e){
			const reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
				};
			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				//showList(1);
				showList(-1);
			});
		});
		
		modalModBtn.on("click", function(e){
			const reply = {rno : modal.data("rno"), reply : modalInputReply.val()};
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			const rno = modal.data("rno");
			replyService.remove(rno, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});

	
		let pageNum = 1;
		const replyPageFooter = $(".card-footer");
	
		function showReplyPage(replyCnt){
			let endNum = Math.ceil(pageNum / 10.0) * 10;
			let startNum = endNum - 9;
		
			let prev = startNum != 1;
			let next = false;
		
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt / 10.0);
			}
		
			if(endNum * 10 < replyCnt){
				next = true;
			}
		
			let str = "<ul class='pagination float-right'>";
		
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>'";
			}
		
			for(let i=startNum; i<=endNum; i++){
				const active = pageNum == i ? "active" : "";
			
				str += "<li class='page-item'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
		
			if(next){
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>'";
			}
		
			str += "</ul>";
			console.log(str);
			replyPageFooter.html(str);
		}
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
		
			let targetPageNum = $(this).attr("href");
			console.log("targetPageNum : " + targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
		
	});

</script>

<script type="text/javascript">
	$(document).ready(function(){
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});
	
</script>

