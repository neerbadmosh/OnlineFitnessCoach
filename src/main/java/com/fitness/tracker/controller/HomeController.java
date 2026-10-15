package com.fitness.tracker.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("message", "Welcome to Fitness Tracker Application!");
		model.addAttribute("description", "Your journey to a healthier lifestyle starts here.");
		model.addAttribute("techStack", "Spring Boot + Hibernate + JSP + MySQL");
		model.addAttribute("appStatus", "Running Successfully with Spring Boot!");
		return "welcome";
	}
	
	@GetMapping("/welcome")
	public String welcome(Model model) {
		model.addAttribute("message", "Welcome to Fitness Tracker Application!");
		model.addAttribute("description", "Your journey to a healthier lifestyle starts here.");
		model.addAttribute("techStack", "Spring Boot + Hibernate + JSP + MySQL");
		model.addAttribute("appStatus", "Running Successfully with Spring Boot!");
		return "welcome";
	}
}