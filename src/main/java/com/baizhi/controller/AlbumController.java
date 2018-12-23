package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.entity.AlbumPageDto;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
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
}
