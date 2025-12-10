package com.asset.asset_management.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.asset.asset_management.entity.Asset;
import com.asset.asset_management.entity.Request;
import com.asset.asset_management.entity.Users;
import com.asset.asset_management.repo.AllocationRepo;
import com.asset.asset_management.repo.AssetRepo;
import com.asset.asset_management.repo.RequestRepo;
import com.asset.asset_management.repo.UserRepo;
import com.asset.asset_management.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	AllocationRepo allocationRepo;
	
	@Autowired
	AssetRepo assetRepo;
	
	@Autowired
	RequestRepo requestRepo;
	
	@Autowired
	UserRepo userRepo;
	
	
	@GetMapping("/userLogin")
	public String userLogin()
	{
		return "userLogin";
	}

	@PostMapping("/userLogin")
	public String validUser(@RequestParam String email,@RequestParam String password,HttpSession session,Model model)
	{

		if (userService.validation(email, password)==true)
		{
			session.setAttribute("loggedIn", true);
	        session.setAttribute("role", "USER");
	        session.setAttribute("user", userService.getUser(email));
	        session.setAttribute("userId", userService.getUser(email).getUserId());
	        session.setAttribute("userName", userService.getUser(email).getFullName());
	        session.setAttribute("email", userService.getUser(email).getEmail());
	        session.setAttribute("department", userService.getUser(email).getDepartment().getName());
	        session.setAttribute("phone",userService.getUser(email).getPhone());
	        model.addAttribute("currentAssetName",assetRepo.findById(allocationRepo.findByuserId(userService.getUser(email).getUserId()).getAssetId()).get().getAssetName());

			return "user";
		}
		else
		{
			System.out.println("false");
			model.addAttribute("error", "Invalid Crendentials");
			return "userLogin";
		}
	}
	
	@GetMapping("/user/profile")
	public String userProfile()
	{
		
		return "userProfile";
	}
	
	@GetMapping("/user")
	public String userProfileredirect()
	{
		
		return "user";
	}
	
	@GetMapping("/user/requestAsset")
	public String assetRequest(Model model)
	{
		model.addAttribute("request", new Request());
		model.addAttribute("availableAssets",assetRepo.findByStatus("Available"));
		return "requestAsset";
	}
	
	@GetMapping("/requests")
	public String viewRequests(HttpSession session, Model model) {
	    String role = (String) session.getAttribute("role");
	    List<Request> requests;

	    if ("ADMIN".equalsIgnoreCase(role)) {
	        requests = requestRepo.findAll(); // all requests
	    } else {
	        int userId = (int) session.getAttribute("userId");
	        requests = requestRepo.findByUser_UserId(userId); // only this user's requests
	    }

	    model.addAttribute("requests", requests);
	    return "viewRequests"; // single JSP page
	}
	
	@PostMapping("/user/requestAsset")
	public String saveRequest(HttpSession session, @ModelAttribute Request request )
	{
	    Users sessionUser = (Users) session.getAttribute("user");
        Asset asset = assetRepo.findById(request.getAssetId()).get();
	    Users user = userRepo.findById(sessionUser.getUserId())
	                 .orElseThrow(() -> new RuntimeException("User not found"));

	    request.setUser(user);
	    request.setAsset(asset);
	    request.setRequestDate(LocalDate.now());
	    request.setStatusH("pending");

	    System.out.println(request);
	    
	    requestRepo.save(request);
	    return "redirect:/user";
	}
	@GetMapping("/user/changePassword")
	public String changePassword()
	{
		
		return "changePassword";
	}
	
	@Transactional
	@PostMapping("/user/changePassword")
	public String changePasswordpost(Model model,@RequestParam String email,@RequestParam String oldpassword,@RequestParam String newpassword,@RequestParam String confirmpassword)
	{
		if(userService.validation(email, oldpassword))
		{
			if(newpassword.equals(confirmpassword))
			{
			 userService.getUser(email).setPasswordH(confirmpassword);
			}
			else {
				model.addAttribute("error","passwords dont match please re-enter");
				return "redirect:/user/changePassword?error=nomatch";
			}
			return "redirect:/user/changePassword?success=success";
		}
		else
		{
			return "redirect:/user/changePassword?error=invalid";
		}

	}
	
	@GetMapping("/userlogout")
	public String logout(HttpSession session) {
	    session.invalidate(); 
	    return "redirect:/userLogin";
	}
	
}
