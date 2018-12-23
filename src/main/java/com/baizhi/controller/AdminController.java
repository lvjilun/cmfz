package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
    ModelAndView loginAdmin(Admin admin, String enCode, HttpSession session, ModelAndView mav) {
        boolean b = adminService.loginAdmin(admin, enCode, session);
        mav.setViewName("redirect:/back/main/main.jsp");
        return mav;
    }

    @RequestMapping("logoutAdmin")
    public @ResponseBody
    ModelAndView logoutAdmin(HttpSession session, ModelAndView mav) {
        session.removeAttribute("loginAdmin");
        session.invalidate();
        mav.setViewName("redirect:/back/login.jsp");
        return mav;
    }
}
