package com.baizhi.service;

import com.baizhi.entity.Province;
import com.baizhi.mapper.UserMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@Log4j
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Map<String, Integer> SelectByNumber() {
        Map<String, Integer> map = new HashMap<>();
        map.put("一周内", userMapper.selectCountByRegDate(7));
        map.put("两周内", userMapper.selectCountByRegDate(14));
        map.put("两月内", userMapper.selectCountByRegDate(60));
        map.put("半年内", userMapper.selectCountByRegDate(180));
        return map;
    }

    @Override
    public List<Province> queryAllUserByProvice() {
        List<Province> list = userMapper.queryAllUserByProvice();
        log.info(list);
        return list;
    }
}
