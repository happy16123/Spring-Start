# 정리

## 1. 환경설정 및 파일수정
  - java 1.8, springframework 5.0.7, tomcat 9, Lombok, junit 4.12
  - maven-war-plugin 추가
  - xml을 사용하지 않기 때문에 AbstractAnnotationConfigDispatcherServletInitializer 상속받는 클래스 생성

## 2. 스프링의 주요 특징
  - POJO 기반의 구성
    - 일반적인 java 코드를 이용해 객체를 구성하는 방식 그대로 사용
    - 특정 라이브러리나 컨테이너 기술에 종속적이지 않다
  - 의존성 주입(DI)를 통한 객체 간의 관계 구성
    - 어떤 객체가 필요한 객체를 외부에서 밀어 넣는다
    - ApplicationContext가 필요한 객체를 생성하고, 주입하는 역할
    - ApplicationContext가 관리하는 객체들을 빈(Bean)이라고 함
    - 빈과 빈 사이의 의존관계를 처리하는 방식으로 xml, annotation, java 방식이 있다
  - AOP 지원
    - 반복코드를 줄이고 핵심 비즈니스 로직에만 집중할 수 있음
  - 편리한 MVC 구조
  - WAS의 종속적이지 않은 개발 환경

## 3. 의존성 주입 테스트
  - xml 설정
    - root-context.xml에서 객체를 설정하는 설정 파일
    - 파일 내 namespaces 탭에 context 항목 체크
  - java 설정
    - RootConfig로 만들어 놓은 클래스에 @ComponentScan 어노테이션을 이용해서 처리
  - lombok onMethod 사용시 jdk버전에 따라 차이가 있음
    - jdk7 : @Setter(onMethod = @__({@AnnotationsGoHere}))
    - jdk8 : @Setter(onMethod_ = {@AnnotationsgoHere})

### 3-1. 테스트 코드 작성
  - @ContextConfiguration
    - xml : root-context.xml 경로 지정
    - java : 클래스파일 지정
  1. 테스트코드가 실행되기 위해서 프레임워크가 동작
  2. 동작하는 과정에서 필요한 객체들이 스프링에 등록
  3. 의존성 주입이 필요한 객체는 자동으로 주입이 이루어짐

## 4. Database 연동
  - Oracle 설치 및 JDBC 연동
  - Mybatis 라이브러리 추가
  - Mapper는 SQL과 그에 대한 처리를 지정하는 역할
    - xml과 interface + annotation 형태로 작성 할 수 있음
    - @MapperScan을 이용해서 처리
  - xml 매퍼와 같이 쓰기
    - sql을 처리할 때 어노테이션을 이용하는 방식이 압도적으로 편리하지만 sql이 길어지거나 복잡할때에는 xml 방식을 선호하게 됨
    - xml 파일 위치와 xml 파일에 지정하는 namespace 속성이 중요
      1. Mapper 인터페이스가 있는 곳에 작성
      2. resources 구조에 폴더를 만들어 작성 
          - Mapper 인터페이스와 같은 이름을 이용하는 것이 좋음
          - 폴더를 하나씩 생성하는 것이 좋음. 한번에 만들면 제대로 인식이 안되는 문제가 발생
    - id 값은 메서드의 이름과 동일하게 작성
    - resultType 값은 인터페이스에 선언된 메소드의 리턴 타입과 동일하게 작성

### 4-1. log4jdbc 라이브러리 추가
  - PreparedStatement에 사용된 '?'가 어떤 값으로 처리되었는지 확인이 필요
  - 라이브러리 추가 후
    1. 로그설정 파일을 추가하는 작업
    2. JDBC연결 정보를 수정

## 5. MVC의 기본 구조
  - 프로젝트 구조
    - Spring MVC => servlet-context.xml, ServletConfig.class
    - Spring Core, MyBaits => root-context.xml, RootConfig.class
  - WebConfig : AbstractAnnotationConfigDispatcherServletInitalizer 상속
  - ServletConfig : @EnableWebMvc 어노테이션과 WebMvcConfigurer 인터페이스를 구현
    - WebMvcConfigurerAdapter 추상클래스는 5.0버전부터 Deprecated 되었음

### 5.1 Controller
  - HttpServletRequest, HttpServletResponse를 거의 사용할 필요 없이 필요한 기능 구현
  - 다양한 타입의 파라미터 처리, 다양한 타입의 리턴 타입 사용 가능
  - 전송 방식에 대한 처리를 어노테이션으로 처리 가능
  - 상속, 인터페이스 대신 어노테이션만으로도 필요한 설정 가능
  - @RequestMapping의 변화
    - 4.3버전부터는 @GetMapping, @PostMapping 축약형의 표현이 등장
    - GET, POST 뿐만아니라 PUT, DELETE 등 방식이 많이 사용됨(Restful)
  - 파라미터 수집
    - request.getParameter() 이용의 불폄함을 없애줌
    - @RequestParam 어노테이션으로 전달되는 파라미터를 받을 수 있음
    - 객체, 리스트, 배열 등 여러타입으로 받을수 있음
    - @InitBinder
      - 파라미터의 수집을 다른 용어로 'binding(바인딩)' 이라고 함
      - 변환이 가능한 데이터는 자동으로 되지만 파라미터를 변환해서 처리해야 하는 경우 @InitBinder를 사용
      