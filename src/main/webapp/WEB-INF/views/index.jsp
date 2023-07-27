<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유기동물 정보 조회</title>
<style>
* {
	box-sizing: border-box;
}
form {
	display: inline-block;
	margin: 30px 0;
}
select {
	padding: 5px 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-right: 10px;
}

.animal-info {
	display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  margin-top: 20px;
}
button {
	padding: 5px 10px;
	background-color: #000;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	padding: 10px;
	margin-right: 10px;
	
	
}
.animal-info img {
	display: block;
	margin: 10px auto;
	max-width: 100%;
	height: auto;
}
.animal-card {
  width: 47%;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  background-color: #fff;
  box-shadow: 0px 2px 6px 1px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
  position: relative;
}
.animal-card-hr {
  margin-top: 10px;
  margin-bottom: 10px;
  border-top: 1px solid #ccc;
}
</style>
</head>
<body>
	<div style="text-align: center">
		<h1>
			유기동물 정보 조회 <small>(OPEN API 활용)</small>
		</h1>
		<div>
			<form action="/index">
				<input type="date" name="bgnde"/> ~<input type="date" name="endde">
				<select name="upr_cd">
					<option value=""${param.upr_cd eq '' ? 'selected' : '' }>전국</option>
					<c:forEach items="${sidos }" var="obj">
						<option value="${obj.orgCd }" ${param.upr_cd eq obj.orgCd  ? 'selected' : '' }>${obj.orgdownNm }</option>
					</c:forEach>
				</select> <select name="upkind">
					<option value="" ${param.upkind eq '' ? 'selected' : '' }>전체</option>
					<option value="417000"
						${param.upkind eq '417000' ? 'selected' : '' }>개</option>
					<option value="422400"
						${param.upkind eq '422400' ? 'selected' : '' }>고양이</option>
					<option value="429900"
						${param.upkind eq '429900' ? 'selected' : '' }>기타</option>
				</select>
				<button type="submit">조회</button>
			</form>
			<div style="text-align: right;">
			<c:forEach begin="1" end="10" var="p">
				<a href="/?pageNo=${p }">${p }</a>
			</c:forEach>
			</div>
		</div>
		<div>총${total } 건의 유기동물정보가 존재합니다.</div>
		<div class="animal-info" >
			<c:forEach items="${datas }" var="obj">
				<div class="animal-card" onclick="location.href='/detail?no=${obj.desertionNo}'" style="cursor: pointer;">
					<b>${obj.happenDt }</b>
					<hr class="animal-card-hr"/>
					${obj.kindCd } | (${obj.specialMark })
					<hr class="animal-card-hr"/>
					${obj.orgNm } ${obj.happenPlace } <img src="${obj.filename }" class="animal-info img">
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>