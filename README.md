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
  1) 테스트코드가 실행되기 위해서 프레임워크가 동작
  2) 동작하는 과정에서 필요한 객체들이 스프링에 등록
  3) 의존성 주입이 필요한 객체는 자동으로 주입이 이루어짐

  ## 4. Database 연동
  - Oracle 설치 및 JDBC 연동