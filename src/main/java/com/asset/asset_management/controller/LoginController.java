package com.asset.asset_management.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.asset.asset_management.entity.Admin;
import com.asset.asset_management.entity.Allocation;
import com.asset.asset_management.entity.Asset;
import com.asset.asset_management.entity.Request;
import com.asset.asset_management.entity.Users;
import com.asset.asset_management.repo.AdminRepo;
import com.asset.asset_management.repo.AllocationRepo;
import com.asset.asset_management.repo.AssetRepo;
import com.asset.asset_management.repo.DepartmentRepo;
import com.asset.asset_management.repo.RequestRepo;
import com.asset.asset_management.repo.UserRepo;
import com.asset.asset_management.service.AdminService;
import com.asset.asset_management.service.AssetService;
import com.asset.asset_management.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class LoginController {
	
	@Autowired
	AdminService adminserv;
	
	@Autowired
	UserService userService;
	
	@Autowired
	AssetService assetService;
	
	@Autowired
	DepartmentRepo deptRepo;
	
	@Autowired
	AssetRepo assetRepo;
	
	@Autowired
	AllocationRepo allocationRepo;
	
	@Autowired
	AdminRepo adminRepo;
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	RequestRepo requestRepo;

	@GetMapping("/adminLogin")
	public String login()
	{
		System.out.println("in gets");
		return "adminLogin";
	}
	
	@PostMapping("/adminLogin")
	public String validUser(@RequestParam String email,@RequestParam String password,HttpSession session, Model model)
	{
		
		if (adminserv.validation(email, password)==true)
		{
	        session.setAttribute("loggedIn", true);
	        session.setAttribute("role", "ADMIN");
	        session.setAttribute("userId", adminserv.getAdmin(email).getAdmin_id());
	        session.setAttribute("userName", adminserv.getAdmin(email).getFull_name());
	        session.setAttribute("email", adminserv.getAdmin(email).getEmail());
	        session.setAttribute("phone", adminserv.getAdmin(email).getPhone());
	        model.addAttribute("kpiUsers", userRepo.count());
	        model.addAttribute("kpiAllocations",allocationRepo.count());
	        model.addAttribute("kpiRequests",requestRepo.countPendingRequests());
	        model.addAttribute("kpiAssets", assetRepo.count());
			return "admin";
		}
		else
		{
			System.out.println("falase");
			model.addAttribute("error", "Invalid Crendentials");
			return "adminLogin";
		}
	}
	
	@GetMapping("/admin/profile")
	public String adminProfile()
	{
		return "adminProfile";
	}
	
	@GetMapping("/admin")
	public String admin()
	{
		return "admin";
	}
	
	@GetMapping("/adminLogin/viewUsers")
	public String viewUsers(Model model,@RequestParam(name="q", required=false) String q,@RequestParam(value = "departmentId", required = false) Integer departmentId) {

	    List<Users> users;
        if (departmentId != null) {
            // filter by department
            users = userService.findByDepartment_DepartmentId(departmentId);
        } else if (q != null && !q.trim().isEmpty()) {
            // simple search by name or email (add this repo method if not present)
            users = userService.search(q);
        } else {
            // default: show all users
            users = userService.findAll();
        }

        model.addAttribute("departments",deptRepo.findAll());
	    model.addAttribute("users", users);
	    model.addAttribute("q", q);

	    return "viewUsers"; // viewUsers.jsp
	}
	
	@GetMapping("/admin/changePassword")
	public String changePassword()
	{
		
		return "changePassword";
	}
	
	@Transactional
	@PostMapping("/admin/changePassword")
	public String changePasswordpost(Model model,@RequestParam String email,@RequestParam String oldpassword,@RequestParam String newpassword,@RequestParam String confirmpassword)
	{
		if(adminserv.validation(email, oldpassword))
		{
			if(newpassword.equals(confirmpassword))
			{
			adminserv.getAdmin(email).setPassword_hash(confirmpassword);
			}
			else {
				model.addAttribute("error","passwords dont match please re-enter");
				return "redirect:/admin/changePassword?error=nomatch";
			}
			return "redirect:/admin/changePassword?success=success";
		}
		else
		{
			return "redirect:/admin/changePassword?error=invalid";
		}

	}
	
	@GetMapping("/admin/assets/view")
	public String viewAssets(@RequestParam(required = false) String q, Model model) {

	    List<Asset> assets;

	    if (q != null && !q.isBlank()) {
	       assets=assetService.search(q);
	    } else {
	        assets = assetService.findAll();
	    }


	    model.addAttribute("assets", assets);


	    model.addAttribute("q", q);
		return "viewAssets";
	}
	
	@GetMapping("/logout")
	public String logout()
	{
		return "adminLogin";
	}

	@GetMapping("/admin/adduser")
	public String addNewUser(Model model) {
	    model.addAttribute("user", new Users());
	    return "adduser";
	}

	@GetMapping("/admin/delete/{id}")
	public String deleteUser(@PathVariable("id") Integer id) {

	    userService.deleteuser(id);


	    return "redirect:/adminLogin/viewUsers";
	}
	
	@GetMapping("/admin/assets/allocate")
	public String allocateAsset(Model model)
	{
		List<Users> users=userService.findAll();
		List<Asset> assets=assetService.findAll();
		model.addAttribute("assets",assets);
		model.addAttribute("users",users);
		return "allocation";
	}
	
	@GetMapping("/admin/assets/add")
	public String addAsset(Model model)
	{
		model.addAttribute("asset",new Asset());
		return "addAsset";
	}
	
	@PostMapping("/admin/assets/save")
	public String saveAsset(@ModelAttribute Asset asset)
	{
		assetRepo.save(asset);
		return "redirect:/admin/assets/view";
	}
	
	@Transactional
	@PostMapping("/admin/allocation/save")
	public String allocateAssetPost(@ModelAttribute Allocation allocation,HttpSession session)
	{
		Asset asset=assetRepo.findById(allocation.getAssetId()).get();
		Users user=userRepo.findById(allocation.getUserId()).get();
		Integer adminIdInt = (Integer) session.getAttribute("userId");
		Long adminId = adminIdInt.longValue();
		if(asset.getStatusA().equals("Assigned"))
		{
			System.out.println(asset);
			System.out.println(user);
			System.out.println(allocation);
			return "redirect:/admin/assets/allocate?error=assigned";
		}
		else if(allocationRepo.findByuserId(user.getUserId())!=null && (allocationRepo.findByuserId(user.getUserId())).getStatus().equals("Active"))
		{
			return "redirect:/admin/assets/allocate?error=userhasAsset";
		}
		else
		{
			allocation.setAllocatedByAdminId(adminId);
			allocation.setAllocatedBy(adminRepo.findById(adminIdInt).get());
			allocation.setAsset(asset);
			allocation.setUser(user);
			System.out.println(asset);
			System.out.println(user);
			System.out.println(allocation);
			allocationRepo.deleteByAssetId(allocation.getAssetId());
			asset.setStatusA("Assigned");
			allocationRepo.save(allocation);

		}
		return "redirect:/admin/assets/view";
	}
	
	@GetMapping("/admin/requests")
	public String viewRequests(HttpSession session, Model model) {
	    List<Request> requests;

	        requests = requestRepo.findAll();


	    model.addAttribute("requests", requests);
	    return "viewRequests";
	}
	
	@PostMapping("/admin/users/save")
	public String saveNewUser(@ModelAttribute Users user) {
	    System.out.println(user.toString());
	    userService.addUser(user);
	    System.out.println(user.toString());
	    return "redirect:/adminLogin/viewUsers";
	}
	
	@Transactional
	@PostMapping("/admin/assets/return/{assetID}")
	public String returnAsset(@PathVariable int assetID)
	{
		Asset asseto=assetRepo.findById(assetID).get();
		allocationRepo.findByAssetId(assetID).setExpectedReturnDate(LocalDate.now());
		allocationRepo.findByAssetId(assetID).setStatus("Returned");
		allocationRepo.deleteByAssetId(assetID);
		asseto.setStatusA("Available");
		return "redirect:/admin/assets/view";
	}
	
	
	

	
	
}
