package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelIgnore;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "chapters")
public class Chapter implements Serializable {
    @Id
    @KeySql(useGeneratedKeys = true)
    @ExcelIgnore
    private String id;
    @Excel(name = "标题")
    private String title;
    @Excel(name = "大小")
    private String size;
    @Excel(name = "时长")
    private String duration;
    @ExcelIgnore
    private String downloadUrl;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    @Excel(name = "上传日期", format = "YYYY年MM月dd日", width = 20)
    private Date uploadDate;
    @ExcelIgnore
    private Integer albumId;
    @Transient
    @ExcelIgnore
    private Album album;
}
