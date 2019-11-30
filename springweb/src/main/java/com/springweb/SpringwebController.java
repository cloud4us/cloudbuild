package com.springweb;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SpringwebController {
	
	@GetMapping
	public String getIndex() {
		return "Hello, Spring Web!";
	}
}
