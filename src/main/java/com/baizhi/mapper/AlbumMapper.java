package com.baizhi.mapper;

import com.baizhi.entity.Album;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface AlbumMapper extends Mapper<Album> {
    public List<Album> queryAllAlbum(@Param("page") int pageNum, @Param("rows") int pageSize);

    public Album queryOneAlbumById(Integer id);
}
