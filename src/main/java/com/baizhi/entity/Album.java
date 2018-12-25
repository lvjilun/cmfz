package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import cn.afterturn.easypoi.excel.annotation.ExcelIgnore;
import cn.afterturn.easypoi.excel.annotation.ExcelTarget;
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
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "album")
@ExcelTarget(value = "teacher")
public class Album implements Serializable {
    @Id
    @KeySql(useGeneratedKeys = true)
    @ExcelIgnore
    private Integer id;
    @Excel(name = "专辑标题", needMerge = true)
    private String title;
    @ExcelIgnore
    private Double score;
    @ExcelIgnore
    private String broadcast;
    @ExcelIgnore
    private Integer counts;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    @Excel(name = "出版时间", format = "YYYY年MM月dd日", width = 20, needMerge = true)
    private Date pubDate;
    @Excel(name = "专辑描述", needMerge = true)
    private String description;
    @Excel(name = "配图", type = 2, width = 40, height = 40, needMerge = true)
    private String albumImage;
    @Excel(name = "作者", needMerge = true)
    private String author;
    @Transient
    @ExcelCollection(name = "下属章节")
    private List<Chapter> children;
}
