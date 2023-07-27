<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 부트스트랩 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
body {
	margin: 0;
	background-color: #f8f9fa;
	font-family: "나눔바른고딕", "Nanum Barun Gothic", "돋움", Dotum, sans-serif;
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 20px;
	margin-top: 30px;
}

.card {
	width: 100%;
	margin-bottom: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.card img {
	max-height: 360px;
	max-width: 100%;
}

.card-body {
	padding: 20px;
	text-align: center;
	background-color: #fff;
}

#map {
	width: 100%;
	height: 400px;
	margin: 20px 0;
}

.comment-info__textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
	resize: none;
}

button[type="submit"] {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
	background-color: #0069d9;
}
</style>
</head>
<body style="margin: 0px">
	<div class="container">
		<div class="row justify-content-center">
			<!-- 동물 정보 영역 -->
			<div class="col-lg-6">
				<div class="card mb-3">
					<img src="${item.popfile}"
						style="max-height: 360px; max-width: 100%;">
					<div class="card-body">
						<h5 class="card-title">${item.noticeNo}</h5>
						<p class="card-text">${item.kindCd}</p>
						<p class="card-text">${item.colorCd}</p>
						<p class="card-text">나이: ${item.age}</p>
						<p class="card-text">몸무게: ${item.weight}</p>
						<p class="card-text">성별: ${item.sexCd}</p>
						<p class="card-text">중성화: ${item.neuterYn}</p>
					</div>
				</div>
			</div>


		<%-- 동물에 대한 코멘트 영역 --%>
		<div style="flex: 1;">
			<div>
				<form action="/write">
					<input type="hidden" name="target" value="${item.desertionNo }" />
					<textarea name="body" class="comment-info__textarea"
						placeholder="응원의 한마디를 해주세요"></textarea>
					<input type="password" name="pass" />
					<button type="submit">응원하기</button>
				</form>
			</div>
			<div>
				<h4>
					응원의 한마디 (${fn:length(messages) }건) <button id="refresh" style="cursor: pointer;">↺</button>
				</h4>
				<div id="messages">
				<c:forEach items="${messages}" var="m">
					<div style="padding: 4px; border: 1px solid #cccccc">
						${m.body }</div>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>

			<div id="map" style="width: 500px; height: 400px; margin: auto;">
				<c:choose>
					<c:when test="${empty address }">
			지도정보를 확보 하지 못해 랜더링에 실패하였습니다
		</c:when>
					<c:otherwise>
			지도를 불러옵니다.
		</c:otherwise>
				</c:choose>
			</div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=18bfc4ce33fb91dc550feca1fba1c1b5"></script>
<script>
		const getMessages = function() {
			const xhr = new XMLHttpRequest();
			xhr.open("get", "/api/message?no=${param.no}", true);
			xhr.send();
			xhr.onreadystatechange=function(){
				if(this.readyState===4) {
					const json = JSON.parse(this.responseText);	// 아마 객체 배열일 듯
					const messages = document.querySelector("#messages");
					messages.innerHTML = "";
					console.log(json.result);
					for(let o of json.items) {
						console.log(o);
						messages.innerHTML += "<p>"+o.body+"</p>";
					}
				}
			}
		};
	document.querySelector("#refresh").onclick= getMessages;
	</script>
	
	
	
	<c:if test="${!empty address }">
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b57386b9cc5f6324527b513877e5fcd"></script>
	<script>
		let pos = new kakao.maps.LatLng(${address.lng}, ${address.lat}); //지도의 중심좌표.
		
		let container = document.querySelector('#map'); //지도를 담을 영역의 DOM 레퍼런스
		let options = { //지도를 생성할 때 필요한 기본 옵션
			center : pos, 
			level : 4
		//지도의 레벨(확대, 축소 정도)
		};

		let map = new kakao.maps.Map(document.querySelector('#map'), options); //지도 생성 및 객체 리턴
		
		let marker = new kakao.maps.Marker({
		    position: pos
		});
		
		marker.setMap(map);
		
		
	</script>
	</c:if>
	</div>
</body>
</html>