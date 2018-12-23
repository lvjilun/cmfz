package com.baizhi.controller;

import com.baizhi.entity.Banner;
import com.baizhi.entity.BannerPageDto;
import com.baizhi.service.BannerService;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;

@RestController
@RequestMapping("/banner")
@Log4j
public class BannerController {
    @Autowired
    private BannerService bannerService;

    @RequestMapping("/queryAllBanner")
    public @ResponseBody
    BannerPageDto queryAllBanner(int page, int rows) {
        return bannerService.queryAllBanner(page, rows);
    }

    @RequestMapping("/updateOneBanner")
    public @ResponseBody
    void updateOneBanner(Banner banner) {
        bannerService.updateOneBanner(banner);
    }

    @RequestMapping("/deleteOneBannerById")
    public @ResponseBody
    boolean deleteOneBannerById(Integer id, HttpSession session) {
        //1.首先完成用户头像的上传
        ServletContext sc = session.getServletContext();
        //指定在tomcat中要上传的位置
        String realPath = sc.getRealPath("/upload");
        boolean result = bannerService.deleteOneBannerById(id, realPath);
        return result;
    }

    @RequestMapping("/addOneBanner")
    public @ResponseBody
    boolean addOneBanner(Banner banner, HttpSession session, MultipartFile file) throws Exception {
        //1.首先完成用户头像的上传
        ServletContext sc = session.getServletContext();
        //指定在tomcat中要上传的位置
        String realPath = sc.getRealPath("/upload");
        String oldName = file.getOriginalFilename();
        String newName = System.currentTimeMillis() + oldName;
        //目标文件
        File upFile = new File(realPath + "/" + newName);
        //上传
        file.transferTo(upFile);
        banner.setImgPath(newName);
        banner.setUploadDate(new Date());
        boolean result = bannerService.addOneBanner(banner);
        return result;
    }
}
