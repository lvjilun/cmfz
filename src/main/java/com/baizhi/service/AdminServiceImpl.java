package com.baizhi.service;

import com.baizhi.entity.Admin;
import com.baizhi.exce.LoginException;
import com.baizhi.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.List;

@Transactional
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public List<Admin> queryAllAdmin() {
        return adminMapper.selectAll();
    }

    @Override
    public boolean loginAdmin(Admin admin, String enCode, HttpSession session) {
        String code = (String) session.getAttribute("vcode");
        if (enCode == null || "".equals(enCode)) {
            throw new LoginException("验证码为空");
        }
        if (!enCode.equals(code)) {
            throw new LoginException("请输入正确的验证码");
        }
        if (admin.getName() == null || "".equals(admin.getName())) {
            throw new LoginException("用户名为空");
        }
        Admin admin1 = adminMapper.selectOne(admin);
        if (admin.getPassword() == null || "".equals(admin.getPassword())) {
            throw new LoginException("密码为空");
        }
        if (!admin1.getPassword().equals(admin.getPassword())) {
            throw new LoginException("请输入正确的密码");
        }
        session.setAttribute("loginAdmin", admin1);
        return true;
    }
}
