# main19
### 결과물

### todo
1. 중복 코드 및 다른 파일로 코드 분리하기 (300라인)

### 시행 착오
1. RangeError (index): Invalid value: Valid value range is empty: 0
 - 원인: 인덱스 0 을 사용한 부분을 가져올 수 없으므로 화면을 출력할 수 없는 문제
 - 해결: 삼항연산자 사용하여 길이가 0이면 고정 텍스트 출력하고, 길이가 0이 아니면 인덱스를 출력 

