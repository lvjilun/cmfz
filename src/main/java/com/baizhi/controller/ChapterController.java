package com.baizhi.controller;

import com.baizhi.entity.Chapter;
import com.baizhi.service.ChapterService;
import com.baizhi.util.GetMp3TrackLength;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DecimalFormat;

@RestController
@RequestMapping("chapter")
public class ChapterController {
    @Autowired
    private ChapterService chapterService;

    @RequestMapping("/addOneChapter")
    public void addOneChapter(Chapter chapter, HttpSession session, MultipartFile file) throws Exception {
//        获取文件位置
        ServletContext servletContext = session.getServletContext();
        String realPath = servletContext.getRealPath("/music");
        String originalFilename = file.getOriginalFilename();
        String newName = System.currentTimeMillis() + originalFilename;
        File upFile = new File(realPath + "/" + newName);
        file.transferTo(upFile);
        String sizeFormat = new DecimalFormat("0.00").format((double) file.getSize() / 1024 / 1024);
        chapter.setSize(sizeFormat + "MB");
        chapter.setDownloadUrl(newName);
        GetMp3TrackLength gtl = new GetMp3TrackLength();
        int mp3TrackLength = gtl.getMp3TrackLength(upFile);
        double v = (double) mp3TrackLength / 60;
        if (v > 1) {
            String timeformat = new DecimalFormat("0.00").format(v);
            chapter.setDuration(timeformat + "分钟");
        } else {
            double v1 = v * 60;
            String timeformat = new DecimalFormat("0.00").format(v1);
            chapter.setDuration(timeformat + "秒");
        }
        chapterService.addOneChapter(chapter);
    }

    @RequestMapping("/downloadChapter")
    public void downloadChapter(String url, HttpSession session, HttpServletResponse response) throws Exception {
        String path = session.getServletContext().getRealPath("/music");
        //File file = new File(path + "\\" + url);
        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(url, "UTF-8"));
        response.setContentType("audio/mpeg");
        //读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(path + "\\" + url);
        //创建输出流
        OutputStream out = response.getOutputStream();
        //创建缓冲区
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while ((len = in.read(buffer)) > 0) {
            //输出缓冲区的内容到浏览器，实现文件下载
            out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        //关闭输出流
        out.close();
    }

}
