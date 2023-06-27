<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language=JavaScript src="../static/js/main.js" charset=UTF-8></script>
</head>
<body>
	<section class="mypostion_wrapper">
        <div class="myposition_info">
        	<div class="myposition">
        		<button id="currentGeoLocation">내 위치 정보 가져오기</button>
        	</div>
        	<div class="myposition_function">
        		<button id="show1KmEvents" onclick="showEventsIn1Km()">1km 반경 이벤트!</button>
	            <button id="show3KmEvents" onclick="showEventsIn3Km()">3km 반경 이벤트!</button>
	            <button id="show5KmEvents" onclick="showEventsIn5Km()">5km 반경 이벤트!</button>
						<div id="nudge"></div>
						<div id="startLat" ></div>
						<div id="startLon"></div>
        	</div>
            <!-- style="display: none;" -->
			<script> 
			/* https://developer.mozilla.org/ko/docs/Web/API/Geolocation_API/Using_the_Geolocation_API 활용*/
			(function() {
		        if('geolocation' in navigator) {
		            /* 위치정보 사용 가능 */
		        } else {
		            /* 위치정보 사용 불가능 */
		        }

		        const currentGeoLocation = document.getElementById("currentGeoLocation");

		        currentGeoLocation.onclick = function() {
		            var startPos;
		            var geoOptions = {
		                timeout: 10 * 1000
		            };
		            var element = document.getElementById("nudge");

		            var showNudgeBanner = function () {
		                nudge.style.display = "block";
		            };

		            var hideNudgeBanner = function () {
		                nudge.style.display = "none";
		            };

		            var nudgeTimeoutId = setTimeout(showNudgeBanner, 5000);

		            var geoSuccess = function (position) {
		                hideNudgeBanner();
		                // We have the location, don't display banner
		                clearTimeout(nudgeTimeoutId);

		                // Do magic with location
		                startPos = position;
		                document.getElementById('startLat').innerHTML = startPos.coords.latitude;
		                document.getElementById('startLon').innerHTML = startPos.coords.longitude;
		                alert("위치 정보를 성공적으로 가져왔습니다. 버튼을 눌러주세요!");
		            };
		            var geoError = function (error) {
		                console.log('Error occurred. Error code: ' + error.code);
		                // error.code can be:
		                //   0: unknown error
		                //   1: permission denied
		                //   2: position unavailable (error response from location provider)
		                //   3: timed out
		                switch (error.code) {
		                    case error.PERMISSION_DENIED:
		                        // The user didn't accept the callout
		                        document.getElementById('nudge').innerHTML = '위치정보 허용 권한이 없습니다';
		                        showNudgeBanner();
		                        break;
		                    case error.POSITION_UNAVAILABLE:
		                        // The user didn't accept the callout
		                        document.getElementById('nudge').innerHTML = '위치 정보를 가져오지 못했습니다';
		                        showNudgeBanner();
		                        break;
		                    case error.TIMEOUT:
		                        // The user didn't accept the callout
		                        document.getElementById('nudge').innerHTML = '시간 초과';
		                        showNudgeBanner();
		                        break;
		                };
		            };

		            navigator.geolocation.getCurrentPosition(geoSuccess, geoError, geoOptions);
		        };
		    })();
		</script>
        </div>
    </section>
    
</body>
</html>