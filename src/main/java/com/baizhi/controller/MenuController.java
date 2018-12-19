package com.baizhi.controller;

import com.baizhi.entity.Menu;
import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("menu")
public class MenuController {
    @Autowired
    private MenuService menuService;
    @RequestMapping("queryAllParentMenu")
    public List<Menu> queryAllParentMenu(){
        return menuService.queryAllParentMenu();
    }
    @RequestMapping("queryAllchildrenByPid")
    public List<Menu> queryAllchildrenByPid(Integer pid){
        return menuService.queryAllChildrenByPid(pid);
    }
}
