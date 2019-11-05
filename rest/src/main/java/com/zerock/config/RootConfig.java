package com.zerock.config;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.GeneralSecurityException;
import java.text.ParseException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = "com.zerock.service")
@ComponentScan(basePackages = "com.zerock.task")
@MapperScan(basePackages = {"com.zerock.mapper"})
@EnableTransactionManagement
@EnableScheduling
public class RootConfig {

	@Bean
	public DataSource dataSource() {
		HikariConfig hikari = new HikariConfig();
		hikari.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikari.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:xe");
		hikari.setUsername("scott");
		hikari.setPassword("tiger");
		
		HikariDataSource dataSource = new HikariDataSource(hikari);
		
		return dataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception{
		SqlSessionFactoryBean session = new SqlSessionFactoryBean();
		session.setDataSource(dataSource());
		
		return (SqlSessionFactory)session.getObject();
	}
	
	@Bean
	public PlatformTransactionManager transactionManager() throws URISyntaxException, GeneralSecurityException, ParseException, IOException{
		return new DataSourceTransactionManager(dataSource());
	}
}
