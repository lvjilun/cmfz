package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("queryAllAdmin")
    public @ResponseBody
    List<Admin> queryAllAdmin() {
        return adminService.queryAllAdmin();
    }

    @RequestMapping("loginAdmin")
    public @ResponseBody
    void loginAdmin(Admin admin, String enCode, HttpSession session) {
        boolean b = adminService.loginAdmin(admin, enCode, session);
    }

    @RequestMapping("logoutAdmin")
    public String logoutAdmin(HttpSession session) {
        session.removeAttribute("loginAdmin");
        session.invalidate();
        return "redirect:login.jsp";
    }
}
