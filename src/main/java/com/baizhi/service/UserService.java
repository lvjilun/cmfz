package com.baizhi.service;

import com.baizhi.entity.Province;

import java.util.List;
import java.util.Map;

public interface UserService {
    public Map<String, Integer> SelectByNumber();

    public List<Province> queryAllUserByProvice();
}
