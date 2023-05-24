### 1.scaffold_messenger 공유하기
ScaffoldMessenger.of(context).showSnackBar() 적용

### 2.scaffold_messenger 를 한페이지 내에서만 처리하는 방법
1.ScaffoldMessenger.of(context).showSnackBar() 적용하고
2.ScaffoldMessenger.of(context) 를 Builder() 위젯으로 감싸고
3.상단 Scaffold 를 ScaffoldMessenger 로 감싼다.