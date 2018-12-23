package com.baizhi.service;

import com.baizhi.entity.Album;
import com.baizhi.entity.AlbumPageDto;

import java.util.List;

public interface AlbumService {
    public AlbumPageDto queryAllAlbum(int page, int rows);

    public Album queryOneAlbumById(Integer id);

    public Boolean addOneAlbum(Album album);

    public List<Album> queryAllAlbumSelect();
}
