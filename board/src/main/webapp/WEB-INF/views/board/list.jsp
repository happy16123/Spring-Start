<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
  <div id="wrapper">

    <%@include file="../includes/siderbar.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Tables</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Data Table Example</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                	<tr>
                		<th>#번호</th>
                		<th>제목</th>
                		<th>작성자</th>
                		<th>작성일</th>
                		<th>수정일</th>
                	</tr>
                </thead>
                
                <c:forEach items="${list}" var="board">
                	<tr>
                		<td><c:out value="${board.bno}" /></td>
                		<td><c:out value="${board.title}" /></td>
                		<td><c:out value="${board.writer}" /></td>
                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>              	
                	</tr>
                </c:forEach>
              </table>
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

        <p class="small text-center text-muted my-5">
          <em>More table examples coming soon...</em>
        </p>

      </div>
      <!-- /.container-fluid -->
	<%@include file="../includes/footer.jsp" %>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

</body>

</html>
