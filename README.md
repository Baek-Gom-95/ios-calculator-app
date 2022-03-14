# 계산기 프로젝트
> 프로젝트 기간 2022.03.14 ~ 2022.03.25 </br>
팀원 : [@마이노](https://github.com/Mino777) / 리뷰어 : [@Steven](https://github.com/stevenkim18)

## 키워드
- Protocols
- Extensions
- Error Handling
- Closures
- Advanced Operators
- Inheritance
- Subscripts
- Queue, DoubleStack
- Unit Test
- UML
- TDD

# Ground Rules
- 프로젝트에 집중하는 시간: 10:00 ~ 22:00
- 밥먹는 시간: 12 ~ 14 / 18 ~ 19:30
- 공식적인 휴일: 주말

### 프로젝트 주요 목표
- UML을 토대로 한 TDD 경험
- Protocol 활용
- Testable한 코드 작성

### Commit 제목 규칙
- 기능(feat): 새로운 기능을 추가
- 버그(fix): 버그 수정
- 리팩토링(refactor): 코드 리팩토링
- 형식(style): 코드 형식, 정렬, 주석 등의 변경(동작에 영향을 주는 코드 변경 없음)
- 테스트(test): 테스트 추가, 테스트 리팩토링(제품 코드 수정 없음, 테스트 코드에 관련된 모든 변경에 해당)
- 문서(docs): 문서 수정(제품 코드 수정 없음)
- 기타(chore): 빌드 업무 수정, 패키지 매니저 설정 등 위에 해당되지 않는 모든 변경(제품 코드 수정 없음)

## [STEP 1]

## UML
![](https://user-images.githubusercontent.com/54234176/158206284-bd69aab5-20cc-4beb-8f45-0e14fbcc4d66.png)

### 고민한 점
1. 자료구조 결정
- 기획서에 List 자료구조를 활용해 Queue Type 구현 해보라는 챌린지가 있었습니다.
- 그래서 찾아보니, 연결 리스트와 더블스택을 활용한 Queue 구현이 가장 자료가 많았습니다.
- 그럼 Array로 구현안하고 왜 굳이 다른 선형 자료구조를 만들어서 구현을 할까 라는 의문점이 생겼습니다.
- Array로 구현할 시, dequeue 기능의 경우 removeFirst메서드의 시간 복잡도가 O(n)이 되어 (앞으로 당겨줘야하는 작업) 좀 더 효율적으로 사용할 수 있다 라는 아이디어가 있었습니다.
- 연결 리스트와 더블스택 모두 시간 복잡도는 O(1)로 동일하지만, 공간 복잡도 측면에서 더블스택이 효율적입니다. ( 연결 리스트의 경우 참조를 해야하기 때문에 더블스택에 비해 메모리 접근 시간이 상대적으로 느림 )
- 따라서 더블 스택으로 구현해보기로 결정 해보았습니다.

### 해결한 점

## [STEP 2]

### 고민한 점

### 해결한 점

## [STEP 3]

### 고민한 점

### 해결한 점
