package com.example.spring07.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration //설정에 관련된 bean 이라고 알려준다
@EnableWebSecurity //Spring Security를 설정하기 위한 어노테이션
public class SecurityConfig {

	/*
	 * 1. 메소드에 @bean 어노테이션 붙이면 spring이 자동으로 해당 메소드를 호출하고
	 * 2. 매개변수에 필요한 type 객체가 있으면 
	 * 		spring bean container에서 알아서 해당 type 객체를 찾아서 전달해준다.
	 * 3. 또한 메소드가 리턴해주는 객체를 spring bean container 에서 관리해준다.
	 * 
	 */
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception{
		//security를 통과하는 white list
		String[] whiteList = {"/", "/user/loginform", "/user/login-fail", "/user/expired"}; 
		
		httpSecurity
		.csrf(csrf->csrf.disable()) //csrf 검증 사용하지 않기
		.authorizeHttpRequests(config->
			config
			.requestMatchers(whiteList).permitAll() //whiteList 는 무조건 받아들이고
			.requestMatchers("/admin/**").hasRole("ADMIN")
			.requestMatchers("/staff/**").hasAnyRole("ADMIN", "STAFF")
			.anyRequest().authenticated() //다른 모든 요청은 인증을 진행한다.
		)
		.formLogin(config ->
			config
				//인증을 거치지 않은 사용자를 리다일렉트시킬 경로 설정
				.loginPage("/user/required-loginform")
				//로그인 폼의 action (로그인 처리는 spring security가 대신 해준다)
				.loginProcessingUrl("/user/login")
				//로그인 폼의 사용자명 입력란의 name 속성값 <input type="text" name="userName" >
				.usernameParameter("userName")
				//로그인 폼의 비밀번호 입력란의 name 속성값 <input type="password" name="password" >
				.passwordParameter("password")
				//로그인 성공시 forward 이동될 url (login welcome 응답)
				//.successForwardUrl("/user/login-success")
				//로그인 성공시 동작하는 핸들러 객체 등록하기
				.successHandler(new AuthSuccessHandler())
				//계정, 비밀번호 문제로 로그인 실패시 forward 이동될 url (실패되었다고 응답)
				.failureForwardUrl("/user/login-fail")
				.permitAll() // 위의 요청은 whiteList에 없어도 요청 가능하도록 설정
		)
		.logout(config ->
			config
				//로그아웃시 요청할 url (spring security 가 대신 처리해준다)
				.logoutUrl("/user/logout")
				//로그아웃 후에 리다일렉트 이동할 url
				.logoutSuccessUrl("/")
				.permitAll()
		)
		.exceptionHandling(config ->
			config.accessDeniedPage("/user/denied")
		)
		.sessionManagement(config ->
			config
				//최대 세션 허용 갯수 설정 (다중 기기 로그인 허용 여부)
				.maximumSessions(1)
				//로그인이 해제되었을 때 이동할 url
				.expiredUrl("/user/expired")
		);
		
		return httpSecurity.build();
	}
	
	//비밀번호를 암호화 해주는 객체를 bean 으로 만든다.
	@Bean
	PasswordEncoder passwordEncoder() { 
		//여기서 리턴해주는 객체도 bean 으로 된다.
		return new BCryptPasswordEncoder();
	}
	//인증 메니저 객체를 bean 으로 만든다. (Spring Security 가 자동 로그인 처리할때도 사용되는 객체)
	@Bean
	AuthenticationManager authenticationManager(HttpSecurity http,
			BCryptPasswordEncoder encoder, UserDetailsService service) throws Exception{
		//적절한 설정을한 인증 메니저 객체를 리턴해주면 bean 이 되어서 Spring Security 가 사용한다 
		return http.getSharedObject(AuthenticationManagerBuilder.class)
				.userDetailsService(service)
				.passwordEncoder(encoder)
				.and()
				.build();
	}

}
