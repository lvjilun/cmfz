package com.baizhi.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.entity.Album;
import com.baizhi.entity.AlbumPageDto;
import com.baizhi.service.AlbumService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;

    @RequestMapping("/queryAllAlbum")
    public AlbumPageDto queryAllAlbum(int page, int rows) {
        AlbumPageDto albumPageDto = albumService.queryAllAlbum(page, rows);
        System.out.println(albumPageDto);
        return albumPageDto;
    }

    @RequestMapping("queryOneAlbumById")
    public Album queryOneAlbumById(Integer id) {
        return albumService.queryOneAlbumById(id);
    }

    @RequestMapping("addOneAlbum")
    public Boolean addOneAlbum(Album album, HttpSession session, MultipartFile file) throws Exception {
        //1.首先专辑的配图上传
        ServletContext sc = session.getServletContext();
        //指定在tomcat中要上传的位置
        String realPath = sc.getRealPath("/upload");
        String oldName = file.getOriginalFilename();
        String newName = System.currentTimeMillis() + oldName;
        //目标文件
        File upFile = new File(realPath + "/" + newName);
        //上传
        file.transferTo(upFile);
        album.setAlbumImage(newName);
        return albumService.addOneAlbum(album);
    }

    @RequestMapping("queryAllAlbumSelect")
    public List<Album> queryAllAlbumSelect() {
        return albumService.queryAllAlbumSelect();
    }

    @RequestMapping("downloadAlbum")
    public void downloadAlbum(String url, HttpServletResponse response) throws Exception {
        String filename = "用户信息"
                + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())
                + ".xls";
        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
        response.setCharacterEncoding("UTF-8");
        // 设置下载时客户端Excel的名称，此处需要用到charset=utf-8来转换编码，否则中文会被过滤掉
        response.setContentType("application/ms-excel;charset=utf-8");
        List<Album> albumList = albumService.queryAllAlbumAndChapter();
        for (Album album : albumList) {
            String path = "D:/IDE/project/cmfz/src/main/webapp/upload/" + album.getAlbumImage();
            album.setAlbumImage(path);
        }
        Workbook sheets = ExcelExportUtil.exportExcel(new ExportParams("吉祥妙音专辑", "章节"), Album.class, albumList);
        try {
            sheets.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
