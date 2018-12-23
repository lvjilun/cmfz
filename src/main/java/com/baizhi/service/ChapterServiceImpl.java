package com.baizhi.service;

import com.baizhi.entity.Chapter;
import com.baizhi.mapper.ChapterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Transactional
@Service
public class ChapterServiceImpl implements ChapterService {
    @Autowired
    private ChapterMapper chapterMapper;

    @Override
    public void addOneChapter(Chapter chapter) {
        String uuid = UUID.randomUUID().toString().replace("-", "");
        chapter.setId(uuid);
        chapterMapper.insertSelective(chapter);
    }

}
