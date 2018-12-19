package com.baizhi.service;

import com.baizhi.entity.Admin;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface AdminService {
    public List<Admin> queryAllAdmin();

    public boolean loginAdmin(Admin admin, String enCode, HttpSession session);
}
