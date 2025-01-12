<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>카카오맵 연동</title>
    <script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58a4a5cfbc781b2348261bdd16809813&libraries=services"></script>
</head>
<body>
<div id="map" style="width:100%; height:400px;"></div>
<script>
    // 지도 초기화 함수
    function initMap(latitude, longitude) {
        const mapContainer = document.getElementById('map'); // 지도를 표시할 div
        const mapOption = {
            center: new kakao.maps.LatLng(latitude, longitude), // 중심 좌표
            level: 3 // 확대 레벨
        };

        // 지도 생성
        const map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 생성
        const markerPosition = new kakao.maps.LatLng(latitude, longitude);
        const marker = new kakao.maps.Marker({
            position: markerPosition
        });

        marker.setMap(map); // 지도에 마커 표시
        
        window.onload = function () {
            console.log("Initializing map on window load...");
            const defaultLatitude = 37.5665;
            const defaultLongitude = 126.9780;
            initMap(defaultLatitude, defaultLongitude);
        };

        // 인포윈도우 추가
        const infowindow = new kakao.maps.InfoWindow({
            content: `<div style="padding:5px;">위치 정보<br>(${latitude}, ${longitude})</div>`
        });
        infowindow.open(map, marker);

        // 지도 클릭 이벤트
        kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
            const latlng = mouseEvent.latLng;

            alert('클릭한 위치의 좌표는 ' + latlng.getLat() + ', ' + latlng.getLng() + '입니다.');

            // 클릭한 위치로 마커 이동
            marker.setPosition(latlng);
            infowindow.setContent(
                `<div style="padding:5px;">새로운 위치<br>(${latlng.getLat()}, ${latlng.getLng()})</div>`
            );
        });
    }

    // DOMContentLoaded 이벤트
    document.addEventListener("DOMContentLoaded", function () {
        console.log("Initializing map...");
        const defaultLatitude = 37.5665; // 기본값 서울
        const defaultLongitude = 126.9780; // 기본값 서울

        // 지도 초기화 호출
        initMap(defaultLatitude, defaultLongitude);
    });
</script>
</body>
</html>
