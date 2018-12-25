package com.baizhi.controller;

import com.baizhi.entity.Province;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/activeUser")
    public @ResponseBody
    Map<String, Integer> activeUser() {
        return userService.SelectByNumber();
    }

    @RequestMapping("queryAllUserByProvice")
    public @ResponseBody
    List<Province> queryAllUserByProvice() {
        return userService.queryAllUserByProvice();
    }
}
