# main21

## 1.geo_location
1. geolocator 라이브러리 사용
2. 버튼 클릭 시, 내 위치의 위도와 경도를 가져오기 위한 설정


## 2.openweathermap_call_api - sample 데이터 사용
1. https://openweathermap.org/ , 날씨 정보 api 사용
2. 네트워크 통해서 json data 를 가져오기 위해 http 라이브러리 설치 
3. Uri.(parse, https 등등), response.body, jsonDecode 각각의 기능 이해
4. 아래 날씨 정보 3가지 (weather, wind, id)를 출력하기
5. ![img.png](img.png)
7. Current weather data 를 활용할 것이며
- Call current weather data 를 사용하기 전에 테스트 하기 위한 글 하단에 sample data 를 활용한다
- https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key} 
8. API key 는 사이트에서 생성하면 된다
9. fixme: LateInitializationError: Field 'products' has not been initialized.

## 시행 착오 - 2번 프로젝트
1. late final products 변수 설정 시, 앱 실행하면 products 는 비었으므로 UI 를 나타내지 못해 에러 뜬 뒤,
 initState 에 의해 앱 실행하면서 setState 처리한 부분에 products 가 설정되어 rebuild 되면서
 화면이 보여지고 있다. products 비었으면 빈 화면보여주고 데이터가 채워지면 화면 보여주려 한다.
2. Map<String, dynamic>? products 처리하여 null 올 수 있게 만들고
3. UI 에서 ${products['weather'][0]['description']} 대신 ${products?['weather'][0]['description']} 
 처리하여 데이터가 있을 때에만 화면에 나타내도록 설정하였다.


## 3. real_openweathermap_call_api - 실제 데이터 사용
![](../../../Users/krism/AppData/Local/Temp/image.png)
### 앱 실행 즉시 현재 user 의 접속 위치와 대략적인 온도를 나타낸다
