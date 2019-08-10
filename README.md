# 정리

## 1. 환경설정 및 파일수정
  - java 1.8, springframework 5.0.7, tomcat 9
  - web.xml, servelt-context.xml, root-context.xml 삭제
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
  - 편리한 MVC 구조
  - WAS의 종속적이지 않은 개발 환경