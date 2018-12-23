package com.baizhi.service;

import com.baizhi.entity.Banner;
import com.baizhi.entity.BannerPageDto;
import com.baizhi.mapper.BannerMapper;
import com.github.pagehelper.PageHelper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.io.File;
import java.util.List;

@Service
@Transactional
@Log4j
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerMapper bannerMapper;

    @Override
    public BannerPageDto queryAllBanner(int page, int rows) {
        PageHelper.startPage(page, rows);
        Example example = new Example(Banner.class);
        example.setOrderByClause("id desc");
        List<Banner> bannerList = bannerMapper.selectByExample(example);
        BannerPageDto bpd = new BannerPageDto();
        int count = bannerMapper.selectCount(new Banner());
        bpd.setTotal(count);

//        PageInfo<Banner> pageInfoBanner = new PageInfo<>(bannerList);
//        List<Banner> list = pageInfoBanner.getList();
        bpd.setRows(bannerList);
        return bpd;
    }

    @Override
    public void updateOneBanner(Banner banner) {
        bannerMapper.updateByPrimaryKeySelective(banner);
    }

    @Override
    public boolean deleteOneBannerById(Integer id, String realPath) {
        Banner banner = bannerMapper.selectByPrimaryKey(id);
        String namePath = realPath + "/" + banner.getImgPath();
        File file = new File(namePath);
        boolean deleteResult = file.delete();
        int result = bannerMapper.deleteByPrimaryKey(id);
        if (result != 1) {
            return false;
        } else {
            return true;
        }
    }

    @Override
    public boolean addOneBanner(Banner banner) {
        int i = bannerMapper.insertSelective(banner);
        if (i != 1) {
            return false;
        } else {
            return true;
        }
    }
}
