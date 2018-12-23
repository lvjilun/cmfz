package com.baizhi.service;

import com.baizhi.entity.Album;
import com.baizhi.entity.AlbumPageDto;
import com.baizhi.mapper.AlbumMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class AlbumServiceImpl implements AlbumService {
    @Autowired
    private AlbumMapper albumMapper;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public AlbumPageDto queryAllAlbum(int page, int rows) {
        AlbumPageDto apd = new AlbumPageDto();
        List<Album> albumList = albumMapper.queryAllAlbum(page, rows);
        System.out.println(albumList);
        apd.setRows(albumList);
        apd.setTotal(albumMapper.selectCount(new Album()));
        return apd;
    }

    @Override
    public Album queryOneAlbumById(Integer id) {
        return albumMapper.queryOneAlbumById(id);
    }

    @Override
    public Boolean addOneAlbum(Album album) {
        int result = albumMapper.insertSelective(album);
        if (result != 1) {
            return false;
        } else {
            return true;
        }
    }

    @Override
    public List<Album> queryAllAlbumSelect() {
        return albumMapper.selectAll();
    }
}
