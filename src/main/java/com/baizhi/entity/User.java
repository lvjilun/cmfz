package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "user")
public class User implements Serializable {
    @Id
    @KeySql(useGeneratedKeys = true)
    private Integer id;
    private String phone;
    private String password;
    private String userImg;
    private String dharmaName;
    private String name;
    private Integer sex;
    //省份
    private Integer province;
    private Integer city;
    private String signature;
    private Date regDate;
    private String salt;
    private Integer status;
}
