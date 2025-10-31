package com.asset.asset_management.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.asset.asset_management.entity.Admin;
import com.asset.asset_management.entity.Users;
import com.asset.asset_management.service.AdminService;
import com.asset.asset_management.service.UserService;

@Controller
public class LoginController {
	
	@Autowired
	AdminService adminserv;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/adminLogin")
	public String login()
	{
		System.out.println("in gets");
		return "adminLogin";
	}
	
	@PostMapping("/adminLogin")
	public String validUser(@RequestParam String email,@RequestParam String password,Model model)
	{
		System.out.println("in this");
		if (adminserv.validation(email, password)==true)
		{
			System.out.println("true");
			return "admin";
		}
		else
		{
			System.out.println("falase");
			model.addAttribute("error", "Invalid Crendentials");
			return "adminLogin";
		}
	}
	
	@GetMapping("/adminLogin/viewUsers")
	public String viewUsers(Model model,@RequestParam(name="q", required=false) String q) {

	    List<Users> users;
	    if (q != null && !q.isBlank()) {
	        users = userService.search(q); // implement search later
	    } else {
	        users = userService.findAll(); // basic query
	    }

	    model.addAttribute("users", users);
	    model.addAttribute("q", q);

	    return "viewUsers"; // viewUsers.jsp
	}
	
	@GetMapping("/logout")
	public String logout()
	{
		return "adminLogin";
	}

}
