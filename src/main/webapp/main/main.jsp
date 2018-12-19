<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>持名法州主页</title>
<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">   
<script type="text/javascript" src="../js/jquery.min.js"></script>   
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>  
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function(){
        /* 菜单，ajax异步请求获取数据*/
        $.post(
            "${pageContext.request.contextPath}/menu/queryAllParentMenu",
            function(data){
                $.each(data,function(i,item){
                    var id = item.id;
                    var title1 = item.title;
                    //加载一级菜单
                    if(i==0){
                        $('#aa').accordion('add', {
                            title: item.title,
                            iconCls:item.iconcls,
                            selected: true,
                            //添加子树 、二级菜单
                            content:'<div style="padding:10px 0px"><ul id="tree' + id + '"></ul></div>',
                        });
                    }else{
                        $('#aa').accordion('add', {
                            title: item.title,
                            iconCls:item.iconcls,
                            selected: false,
                            content: '<div style="padding:10px 0px"><ul id="tree' + id + '"></ul></div>',
                        });
                    };
                //    发送异步请求，请求二级菜单内容
                    $.post(
                        "${pageContext.request.contextPath}/menu/queryAllchildrenByPid?pid="+id,
                        function(data){
                            $("#tree" + id).tree({

                                data: data,
                                animate: true,
                                //iconCls: icon-blank,
                                //在树节点加图片
                                 formatter:function(node){
                                     return node.title;
                                 },
                                lines: true, //显示虚线效果
                                onClick: function(node) { // 在用户点击一个子节点即二级菜单时触发addTab()方法,用于添加tabs
                                    //if (node.url) {//判断url是否存在，存在则创建tabs
                                        console.log(node);
                                        if (node) {
                                            addTab(node);
                                        }
                                    //}
                                }
                        });

                });
            });
            });
    })
    function addTab(node) {
        //var t=$.trim(t);
        var tabExitOrNot = $('#tt').tabs('exists', node.title);//判断此选项卡是否已存在
        console.log(tabExitOrNot);
        if(tabExitOrNot == true) {
            $('#tt').tabs('select', node.title);
            return;
        }
        //添加选项卡
        $('#tt').tabs('add', {
            title: node.title,
            content: '<iframe scrolling="auto" frameborder="0" src="${pageContext.request.contextPath}'+ node.url +'" style="width:100%;height:600px;"></iframe>',
            iconCls:node.iconcls,
            closable: true,
           /* tools:[{
                iconCls:'icon-mini-refresh',
                handler:function(){
                    alert('refresh');
                }
            }]*/

        });
    }

</script>

</head>
<body class="easyui-layout">   
    <div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    	<div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px" >持名法州后台管理系统</div>
    	<div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎您:${sessionScope.loginAdmin.name} &nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/logoutAdmin" class="easyui-linkbutton" data-options="iconCls:'icon-01'">退出系统</a></div>
    </div>   
    <div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    	<div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体" >&copy;百知教育 htf@zparkhr.com.cn</div>
    </div>   
       
    <div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    	<div id="aa" class="easyui-accordion" data-options="fit:true">

        </div>
    </div>   
    <div data-options="region:'center'">
    	<div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">   
		    <div title="主页" data-options="iconCls:'icon-neighbourhood',"  style="background-image:url(image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
		</div>  
    </div>   
</body> 
</html>