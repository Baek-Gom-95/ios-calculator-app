# 계산기 프로젝트(개인)
작성자: 쿼카

# Queue란?
큐란 대기열이라는 의미이다. 우리가 병원진료할떄 번호표를 뽑고 대기를하면 먼저 오신 손님부터 순서대로 진료를 받는구조와 같이 먼저 들어온 데이터가 먼저나가게되는 구조이다.

# Queue를 구현하는 List 자료구조 방식은 어떤게 좋을까 ?
- Array
[특징]
- 연속적인 메모리위치에 저장되거나 메모리에 연속적인 방식으로 순서대로 저장이된다.
- 배열이 선언되자마자 컴파일 타입에 할당됩니다. 정적메모리 할당
- stack에 할당된다.
[장점]
- 인덱스가 있어 값에 접근하는게 쉽다. O(1)
[단점]
- 배열을 선언할때 크기를 정해야한다.
- 값을 삽입/삭제시 index의 재배치를 해야하는 비효율이 존재함, O(n)

- Linked List
[특징]
- Array에서 삽입/삭제시 index의 재배치를 해야하는 단점을 보안하는 목적으로 만들어졌으며
[data: 0|next: 0x00]->[data: 1|next: 0x01]->[data: 2|next: 0x02]..
이런 방식으로 data와 next라는 다음주소를 가지며 요소들이 서로 연결된 집합이다.
- 새 노드가 추가될때 같이 런타임시 메모리가 할당됩니다. (동적 메모리할당)
- heap과 stack 두 곳에 메모리 할당이된다.
[장점]
- 노드에는 값과 다음 노드를 가르키는 포인터가 존재한다.
- 새 요소를 메모리의 아무곳에나 저장할 수 있다. (포인터만 바꿔주면된다.)

[단점]
- 값을/삽입삭제할때 더 빠르다.
- data와 next그리고 head와 tail까지사용하기때문에 Array에 비해 메모리를 더 많이 사용한다.
- 값을 찾을때 첫번째 인덱스부터 순차적으로 접근해야한다. O(n)


- Deque(Double - Ended Queue 의 줄임말임)
[특징]
- 한쪽에서만 삽입, 다른한쪽에서만 삭제가가능 했떤 큐와 달리 양쪽 front, rear에서 삽입 삭제가 모두 가능한 큐를 의미한다.
[장점]
- 데이터의 삽입 삭제가 빠르고, 앞, 뒤에서 삽입 삭제 모두 가능함
[단점]
- 중간에서의 삽입 삭제가 어려움
- Array는 하나의 배열로 값을 다루지만 더블스택은 reversed된 배열을 하나더 가지게되어 index재배치하는 비효율을 개선해줄 수 있는 방법이다. 시간복잡도도 O(1)


# STEP1 PR 받으면서 배운것들
- 테스트파일을 새로만들었을때 @testable 을 붙여주는이유는 새로운 테스트파일을 만들었을때 생긴 Target은 별도의 모듈로 인식하기때문이다. 코드들이 public, open으로 설정되어있지않는한 접근할 수 없다. 기본적으로 test하는 타입은 Internal타입으로 설계가 되어있어서 외무 타킷이나 모듈에서는 확인할 수 가 없는 상황이다. 그런데 @testable을 사용하게되면 접근 범위에 제한받지않고 모듈에 타킷설정을 해주는 거기 때문에 Internal로 설정된 타입들도 읽어올 수 있다. 꼭 저렇게 해야할까 ? 저렇게 하지않고도 public으로 설정해줄 수도 있겠지만 그러면 불필요한 접근제어 범위를 넓혀 외부에서 접근할 수 있기떄문에 안전하지않다는것이다. 
- CalculateItemQueue내 store프로퍼터 타입은 의존성 주입을 프로토콜로 하는것이 더 유연할 수 있다. 왜냐하면 지금은 자료구조를 LinkedList로 사용하지만 double stack이나 array로 바뀌었다고했을때 프로토콜만 수정하면되고 CalculateItemQueue내부는 수정할 필요가 없기때문이다. 하지만 현재는 제네릭이 들어가있는 상태라서 삽질을 많이 해야할 수도 있어서 메모해놓고 나중에 적용해볼예정이다.
- 테스트할때의 타입별로 파일을 분리하는것이 좋다. 그래야 구분되기 때문.
- 테스트를 위한 테스트코드를 짜면안됩니다. 값을 넣었을때와 안넣었을때 결괏값이 다르면, 즉 분기가될 수 있는 상황이면 케이스를 그에맞게 설정해서 테스트하는것이좋으나 당연한 값이 나오는케이스를 추가하면 안된다. 그리고 기능테스트를 시도했을때 더이상에 테스트할 필요가 없다고 판단되면 굳이 억지로 만들지않고 다른 기능을 테스트하면 될것같다.
- TDD방식은 테스트를 위해 메서드를 추가하는일은 없어야한다. 그래야 테스트를 해도 로직이 변경되지않는 코드라는것을 증명할 수 있기때문이다.
- 제네릭을 사용할때 요소에 calculateItem을 채택시키는 이유
Any 라는 타입이 있는데 말 그대로 어떤 타입이든 들어올 수 있습니다. 하지만 이 타입을 사용하게 되면 어떤 타입이 들어올지 모르기 때문에 매번 런타임에 확인해야한다는 단점이있다. 따라서 CalculateItem을 채택한 타입만 들어올 수 있도록 제약사항이 필요한것이다.
- [연산프로퍼티를 사용하는 기준](https://www.swiftbysundell.com/tips/computed-properties-vs-methods/)
- Mutating
- Final키워들를 붙여줌으로써의 이점
코드를 읽을는 입장에서 상속이 없는 코드이구나라는 전제로 읽을 수 있어 가독성이 좋아진다.
그리고 final을 붙였을때 하위클래스의 최종 메서드, 속성 또는 하위 스크립트를 재정의하려는 모든 시도는 컴파일 시간오류로 보고가 되기때문에 final을 붙임으로써 컴파일 시간을 줄일 수 있어 성능에 도움이된다는 이유도 있다.[공식문서](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html#:~:text=%ED%81%B4%EB%9E%98%EC%8A%A4%20%EC%A0%95%EC%9D%98(%20)%EC%97%90%EC%84%9C%20%ED%82%A4%EC%9B%8C%EB%93%9C%20final%EC%95%9E%EC%97%90%20%EC%88%98%EC%A0%95%EC%9E%90%EB%A5%BC%20%EC%9E%91%EC%84%B1%ED%95%98%EC%97%AC%20%EC%A0%84%EC%B2%B4%20%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A5%BC%20final%EB%A1%9C%20%ED%91%9C%EC%8B%9C%ED%95%A0%20%EC%88%98%20%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4%20.%20%EC%B5%9C%EC%A2%85%20%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A5%BC%20%ED%95%98%EC%9C%84%20%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A1%9C%20%EB%A7%8C%EB%93%A4%EB%A0%A4%EB%8A%94%20%EB%AA%A8%EB%93%A0%20%EC%8B%9C%EB%8F%84%EB%8A%94%20%EC%BB%B4%ED%8C%8C%EC%9D%BC%20%EC%8B%9C%EA%B0%84%20%EC%98%A4%EB%A5%98%EB%A1%9C%20%EB%B3%B4%EA%B3%A0%EB%90%A9%EB%8B%88%EB%8B%A4.classfinal%20class)
- 사용하지않는 주석은 삭제한다.
- 테스트코드작성할떄 강제언랩핑을 하는이유 ?
테스트할때 수월하게 하기 위함입니다.
강제옵셔널이아닌 기본옵셔널 ? 표시도 가능했으나 이럴 경우에는 값을 사용할때마다 옵셔널로 맞춰서 비교해주거나 옵셔널을 벗겨서 값을 꺼내와야한다는 점이있고
기능을 테스트하기위해 값이 있다는 전제하에 하기때문에 어느정도 생략할 수 있고 만일 런타임이 발생하면 로직을 수정해줄 수 도 있다는 점이 있다.
- setUpWithError와 tearDownWithError메서드의 역할
setUpWithError메서드는 test case가 실행되기 전마다 호출되어 각 테스트가 모두 같은 상태와 조건에서 실행할 수 있게해주고
tearDownWithError메서드는 test실행이 끝난 후 마다 호출되는 메서드이며 setUpWithError에서 설정한 값들을 해제할때 사용합니다.
- 외부에서 프로퍼티를 보여줄 필요가없으면 private을 하고 되도록이면 외부에서는 프로퍼티에 값에 접근할 순있되 설정은 못하게끔 설계하는것이 안전합니다.

- 1급객체로 보이기때문과 (타입과 반환타입) 이 같아서 가능하다
```swift
let numbers: [Int] = [1, 2, 3]    
    numbers.forEach(sut.append(data:))
```
 
## 리뷰어 조언(@울라프)
- 속도는 중요하지않다. 어떠한 이유로 코드를 작성했고 그 이유가 얼마나 설득력이있는지가 나중에 면접해서 할얘기가 있는지 없는지를 만들어준다. 울라프도 부트캠프를 했었는데 허송세월을 보낸것같다고 얘기를 해주셨다. 왜냐하면 코드작성하는데에만 급급했기때문이다. 그런데 나보다 느렸지만 공부하면서 이유를 찾던 사람은 면접때 할 얘기가 많아서 오히려 그런사람들이 더 빨리 취업을 했다. 그러니 공부하는것이 가장 핵심적인 포인트라서 속도에 스트레스받을 필요가 없다는것이다.

# 학습키워드
- @testable
- final
- setUpWithError, tearDownWithError
- !
- private(set)
- LinkedList, Queue
- computed Property
- divide file
- Generic
- Protocol

# 공부해야할 키워드
- mutating
- 1급객체
- 큐의 특징

# 참고했던 블로그
처음에 참고했던 code [슈프림](https://tngusmiso.tistory.com/20)
이후에 참고한 code [개발자 소들이](https://babbab2.tistory.com/86?category=908011)
https://velog.io/@nnnyeong/%EC%9E%90%EB%A3%8C%EA%B5%AC%EC%A1%B0-%EC%8A%A4%ED%83%9D-Stack-%ED%81%90-Queue-%EB%8D%B1-Deque#%ED%81%90-queue
