package com.example.spring01;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import com.example.spring01.service.HomeService;
import com.example.spring01.service.HomeServiceImpl;

import jakarta.annotation.PostConstruct;
/*
 * 	Spring 프레임워크를 사용해서 Java Application 을 만드는 이유?
 * 
 * 유지보수를 편하게 하려고..
 * 
 * 어떤 원리로 유지보수가 편할까?
 * 
 * 1. 핵심 의존 객체를 직접 생성(new)하지 않는다.
 * 		- 객체 생성과 관리를 Spring 프레임워크에 맡긴다.
 * 
 * 2. 필요한 객체가 있다면 Dependency Injection (DI) 방식으로 받아서 사용한다.
 * 
 * 3. Interface type (핵심 의존객체의 type) 을 적극 활용한다.
 * 
 * 위의 3가지 원칙을 지키면 '객체들 간 의존관계가 느슨해짐' -> 유지보수가 편하게 된다.
 */

@SpringBootApplication
public class Spring01HelloApplication {
	
	// 필요한 핵심의존 객체를 필드로 선언하고 DI되도록 설정 (Interface type 으로 선언)
	@Autowired HomeService service;
	
	// 이 클래스로 객체가 생성된 이후에 호출하고 싶은 메소드에 @PostConstruct 메소드 붙여놓으면 됨
	@PostConstruct
	public void test() {
		service.clean("주뎅이");
		// 어딘가 구멍 뚫고 싶다면?
		service.hole("바닥");
	}
	
	public static void main(String[] args) {
		// SpringApplication.run() 메소드를 호출하면 Spring 프레임워크가 준비됨
		ApplicationContext container = 
				SpringApplication.run(Spring01HelloApplication.class, args);
		
		// "원숭이" 집 청소하려면?
		// HomeServiceImpl service1 = new HomeServiceImpl();
		// service1.clean("monkey");
		
		// Spring 이 관리하는 객체 중 HomeService type 객체를 얻어낸다.
		HomeService service2 = container.getBean(HomeService.class);
		service2.clean("monkey"  );
	}

}