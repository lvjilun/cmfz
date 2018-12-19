package com.baizhi.service;


import com.baizhi.entity.Menu;
import com.baizhi.mapper.MenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> queryAllParentMenu() {
        return menuMapper.queryAllParentMenu();
    }

    @Override
    public List<Menu> queryAllChildrenByPid(Integer pid) {
        return menuMapper.queryAllChildrenByPid(pid);
    }
}
