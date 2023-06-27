
// 뒤로 돌아가기
function goBack() {
        window.history.back();
      }
      
      
// 회원가입 완료 창 안내  
function onSubmitForm(event) {
    event.preventDefault();
    alert("회원가입이 완료되었습니다");
    event.target.submit();
}

// 패스워드 재확인 안내
function checkPassword() {
	            const password = document.getElementById("password");
	            const password_check = document.getElementById("password_check");
	
	            if (password.value !== password_check.value) {
	               	alert("비밀번호가 다릅니다."); 
	            }
}

function insertMap(container, location) {
  // 지도를 담을 영역의 DOM 레퍼런스
  var mapContainer = container;

  // 지도를 생성할 때 필요한 기본 옵션
  var mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 4, // 지도의 레벨(확대, 축소 정도)
  };

  // 지도 생성 및 객체 리턴
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  // 주소로 좌표를 검색합니다
  geocoder.addressSearch(location, function (result, status) {
    if (status === kakao.maps.services.Status.OK) {
      var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

      // 결과값으로 받은 위치를 마커로 표시합니다
      var marker = new kakao.maps.Marker({
        map: map,
        position: coords,
      });
	// 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">여기에 있어요!</div>'
	    });
	    infowindow.open(map, marker);
      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
      map.setCenter(coords);
    } else {
      alert("지도 검색 결과를 찾을 수 없습니다. 주소 정보를 확인하십시오.");
    }
  });
}

function showEventDetails(eventItem) {
  const modal = document.querySelector("#eventModal");
  const modalBody = modal.querySelector(".modal-body");

  // 이벤트 정보 가져오기
  const title = eventItem.querySelector(".eventInfo_title").textContent;
  const content = eventItem.querySelector(".eventInfo_content").textContent;
  const imageSrc = eventItem.querySelector(".eventInfo_img").src;
  const location = eventItem.querySelector("p:first-child").textContent;
  const period = eventItem.querySelector("p:nth-child(2)").textContent;

  // 이벤트 정보를 모달에 채워 넣기
  modalBody.innerHTML = `
  	<div class="event-modal-content-wrapper">
	    <h3 class="event-modal-title">${title}</h3>
	    <p class="event-modal-location">${location}</p>
	    <p class="event-modal-period">${period}</p>
    	<p class="event-modal-content">${content}</p>
    </div> 
    <img src="${imageSrc}" alt="이미지" class="eventInfo_img event-modal-img">
    <div id="map" class="event-modal-map" data-location="${location}"></div>
  `;

   // 모달이 표시되면 지도 삽입 및 카카오 맵 API 사용
  $("#eventModal").one("shown.bs.modal", function () {
    const mapContainer = document.querySelector("#map");
    const location = mapContainer.dataset.location;
    // 지도를 삽입하고 마커를 표시하는 함수를 호출합니다
    insertMap(mapContainer, location);
    });


  // 모달을 표시할때마다 이벤트리스너가 중복되어 추가되는 것을 방지하기 위해 이벤트리스너를 한 번만 실행
  $("#eventModal").one("shown.bs.modal", function (){
      const mapContainer = document.querySelector("#map");
      const location = mapContainer.dataset.location;
      insertMap(mapContainer, location);
  });

  // 모달 보이기
  $('#eventModal').modal('show');
}

	//카카오맵 API로 주소로 위도, 경도 찾기 
    function getLatLngByLocation(address, callback) {
        let geocoder = new kakao.maps.services.Geocoder();

        geocoder.addressSearch(address, function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
                let lat = result[0].y;
                let lng = result[0].x;
                callback({lat: lat, lng: lng});
            } else {
                console.log("[ERROR] 주소로 좌표 변환 실패");
                callback(null);
            }
        });
    }

    //두 좌표 간 거리 계산
    function getDistanceByCoord(coord1, coord2) {
        function toRad(value) {
            return value * (Math.PI / 180);
        }

        let R = 6371; // 지구의 반지름
        let dLat = toRad(coord2.lat - coord1.lat);
        let dLng = toRad(coord2.lng - coord1.lng);
        let a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(toRad(coord1.lat)) * Math.cos(toRad(coord2.lat)) *
            Math.sin(dLng / 2) * Math.sin(dLng / 2);

        let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        console.log(R*c);
        return R * c;
    }
    
    function showFilteredEvents(distanceLimit) {
		//현재 내 위치 (위도, 경도)
        let startLat = parseFloat(document.getElementById('startLat').textContent);
        let startLon = parseFloat(document.getElementById('startLon').textContent);
		//이벤트를 진행하는 가게의 주소
        let eventCards = document.getElementsByClassName('event-card');
        let eventStoreLocations = document.getElementsByClassName('event-storeLocation');
		//이벤트의 수만큼 반복한다.
        for (let i = 0; i < eventCards.length; i++) {
			// 가게의 주소값을
            let eventStoreLocation = eventStoreLocations[i].textContent;
			//위도, 경도로 바꾼다.
            getLatLngByLocation(eventStoreLocation, function (storeCoord) {
                let currentCoord = {lat: startLat, lng: startLon};
                //나의 위치로부터 거리를 연산
                let distance = getDistanceByCoord(currentCoord, storeCoord);
                console.log(distance);
				// limit 에 따라 이벤트가 표시된다.
                if (distance <= distanceLimit) {
                    eventCards[i].style.display = 'block';
                } else {
                    eventCards[i].style.display = 'none';
                }
            });
        }
    }

    function showEventsIn1Km() {
        showFilteredEvents(1); // 1km
        alert("1km 반경 내에서 진행하는 이벤트를 가져옵니다!");
    }
    function showEventsIn3Km() {
        showFilteredEvents(3); // 3km
        alert("3km 반경 내에서 진행하는 이벤트를 가져옵니다!");
    }
    function showEventsIn5Km() {
        showFilteredEvents(5); // 5km
        alert("5km 반경 내에서 진행하는 이벤트를 가져옵니다!");
    }


