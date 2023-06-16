# main21

### 1.geo_location
1. geolocator 라이브러리 사용
2. 버튼 클릭 시, 내 위치의 위도와 경도를 가져오기 위한 설정

### 2.openweathermap_call_api
1. https://openweathermap.org/ , 날씨 정보 api 사용
2. 네트워크 통해서 json data 를 가져오기 위해 http 라이브러리 설치 
3. Uri.(parse, https 등등), response.body, jsonDecode 각각의 기능 이해
4. 아래 날씨 정보 3가지 (weather, wind, id)를 출력하기
5. ![img.png](img.png)
7. Current weather data 를 활용할 것이며
- Call current weather data 를 사용하기 전에 테스트 하기 위한 글 하단에 sample data 를 활용한다
- https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key} 
8. API key 는 사이트에서 생성하면 된다

### 3.