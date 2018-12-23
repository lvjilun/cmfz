package com.baizhi.entity;

import java.io.Serializable;
import java.util.List;

public class BannerPageDto implements Serializable {
    private Integer total;
    private List<Banner> rows;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<Banner> getRows() {
        return rows;
    }

    public void setRows(List<Banner> rows) {
        this.rows = rows;
    }
}
