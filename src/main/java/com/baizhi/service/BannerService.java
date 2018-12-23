package com.baizhi.service;


import com.baizhi.entity.Banner;
import com.baizhi.entity.BannerPageDto;

public interface BannerService {
    public BannerPageDto queryAllBanner(int page, int rows);

    public void updateOneBanner(Banner banner);

    public boolean deleteOneBannerById(Integer id, String realPath);

    public boolean addOneBanner(Banner banner);
}
