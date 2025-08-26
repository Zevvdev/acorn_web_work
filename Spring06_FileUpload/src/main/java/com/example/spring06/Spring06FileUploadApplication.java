package com.example.spring06;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

/*
 * 직접 만든 custom.properties 파일을 spring이 읽도록 설정
 * 
 * @PropertySource(value="커스텀 properties 파일의 위치")
 * classpath: 는 resources 위치를 가리킨다.
 */
@PropertySource(value="classpath:custom.properties")
@SpringBootApplication
public class Spring06FileUploadApplication {

	public static void main(String[] args) {
		SpringApplication.run(Spring06FileUploadApplication.class, args);
	}

}
