package com.erian.ict.microgrid.controller;

import com.erian.ict.microgrid.service.ConverterHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
@EnableScheduling
@CrossOrigin
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    ConverterHandler converterHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(converterHandler, "/conv").setAllowedOrigins("*");
    }
}

