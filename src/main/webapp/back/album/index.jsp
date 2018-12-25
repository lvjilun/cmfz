<%@page pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="../../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../themes/icon.css">
<style type="text/css">
    .audioDiv {
        width: 80px;
        height: 20px;
    }
</style>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/datagrid-detailview.js"></script>
<script type="text/javascript" src="../../js/jquery.edatagrid.js"></script>
<script type="text/javascript" src="../../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
    $(function () {
        $("#showAllAlbumTable").treegrid({
            title: "妙音专辑管理",
            iconCls: "icon-man",
            fitColumns: true,
            fit: true,
            pagination: true,
            pageSize: 3,
            pageList: [3, 6, 9, 12],
            pageNumber: 1,
            scrollbarSize: 0,
            toolbar: "#addAlbumToolBar",
            url: "${pageContext.request.contextPath}/album/queryAllAlbum",
            idField: 'id',
            treeField: 'title',
            columns: [[
                {field: 'title', title: '名称', width: 100},
                {field: 'size', title: '大小', width: 50, align: 'center'},
                {field: 'duration', title: '时长', width: 50, align: 'center'},
                {field: 'downloadUrl', title: '下载地址', width: 100, align: 'center', formatter: loadFormatter},
                {field: 'uploadDate', title: '上传时间', width: 50, align: 'center'}
            ]],
            onLoadSuccess: function () {
                // $('#showAllAlbumTable').treegrid("collapseAll");
                // $('#showAllAlbumTable').treegrid("expand");
            },
            onDblClickRow: function (row) {
                if (row.children == null) {
                    $("#doubleClickPlayDialog").dialog({
                        title: "自动播放",
                        width: 400,
                        height: 200,
                        closed: true
                    });
                    $("#doubleClickPlayDialog").dialog("open");
                    $("#audio_url").prop("src", "${pageContext.request.contextPath}/music/" + row.downloadUrl)
                } else {
                    $.messager.show({
                        title: '系统提示',
                        msg: '你选择的不是章节，请选择章节哟~',
                        showType: 'slide'
                    });
                }
            }
        })
        $("#showOneAlbumBtn").linkbutton({
            onClick: function () {
                var result = $("#showAllAlbumTable").treegrid("getSelected");
                if (result.children == null) {
                    $.messager.show({
                        title: '系统提示',
                        msg: '你选择的不是专辑，请选择专辑哟~',
                        showType: 'slide'
                    });
                } else {
                    $("#showOneAlbumDialog").dialog({
                        width: 400,
                        height: 400,
                        title: "专辑详情展示页面",
                        closed: false,
                        href: "show.jsp?id=" + result.id + "&albumImage=" + result.albumImage,
                    })
                }
            }
        })
        $("#addOneAlbumBtn").linkbutton({
            onClick: function () {

                $("#addOneAlbumDialog").dialog({
                    width: 400,
                    height: 500,
                    title: "专辑添加页面",
                    closed: false,
                    href: "addAlbum.jsp",
                })
            }
        })
        $("#addOneChapterBtn").linkbutton({
            onClick: function () {

                $("#addOneChapterDialog").dialog({
                    width: 400,
                    height: 500,
                    title: "章节添加页面",
                    closed: false,
                    href: "addChapter.jsp",
                })
            }
        })
        $("#downloadChapterBtn").linkbutton({
            onClick: function () {
                var result = $("#showAllAlbumTable").treegrid("getSelected");
                if (result != null) {
                    if (result.children == null) {
                        location.href = "${pageContext.request.contextPath}/chapter/downloadChapter?url=" + result.downloadUrl
                    } else {
                        $.messager.show({
                            title: '系统提示',
                            msg: '你选择的不是章节，请选择章节哟~',
                            showType: 'slide'
                        });
                    }
                } else {
                    $.messager.show({
                        title: '系统提示',
                        msg: '您还未选择，请选择章节哟~',
                        showType: 'slide'
                    });
                }
            }
        })
        $("#downloadXlsBtn").linkbutton({
            onClick: function () {
                location.href = "${pageContext.request.contextPath}/album/downloadAlbum";
            }
        })
    })

    function albumOperation(value, row, index) {
        return "<a href='javascrpt:void(0)' onClick='deleted(" + row.id + ")'>删除</a>";
    }

    function albumImageFormatter(value, row, index) {
        return "<img src='${pageContext.request.contextPath}/upload/" + row.albumImage + "' style='height:50px;'/>";
    }

    function loadFormatter(valule, row, index) {
        if (row.children == null) {
            //return "<audio style='height:30px;width:220px'controls='controls' src='${pageContext.request.contextPath}/music/"+row.downloadUrl+"'/>";
            var path = "${pageContext.request.contextPath}/music/" + row.downloadUrl;
            return "<audio style='height:50px;width:220px' controls='controls' src='" + path + "'/>";
        } else {
            return "";
        }
    }
</script>
<table id="showAllAlbumTable">
    <%-- <thead>
     <tr>
         <th data-options="field:'vv',checkbox:true"></th>
         <th data-options="field:'id',width:1,align:'center'">编号</th>
         <th data-options="field:'title',width:2,align:'center'">标题</th>
         <th data-options="field:'author',width:1,align:'center'">作者</th>
         <th data-options="field:'broadcast',width:1,align:'center'">播音</th>
         <th data-options="field:'albumImage',width:1,align:'center',formatter:albumImageFormatter">配图</th>
         <th data-options="field:'score',width:1,align:'center'">评分</th>
         <th data-options="field:'pubDate',width:2,align:'center'">出版时间</th>
         <th data-options="field:'description',width:2,align:'center'">描述</th>
         <th data-options="field:'xxx',formatter:albumOperation">操作</th>
     </tr>
     </thead>--%>
</table>
<div id="addAlbumToolBar">
    <a id="showOneAlbumBtn" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true">专辑详情</a>
    <a id="addOneAlbumBtn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">专辑添加</a>
    <a id="addOneChapterBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">章节添加</a>
    <a id="downloadChapterBtn" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">音频下载</a>
    <a id="downloadXlsBtn" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true">表格导出</a>
</div>
<%--专辑详情展示页面--%>
<div id="showOneAlbumDialog"></div>
<%--添加专辑页面--%>
<div id="addOneAlbumDialog"></div>
<%--添加章节页面--%>
<div id="addOneChapterDialog"></div>
<%--（上传）导入章节数据页面--%>
<div id="uploadChapterDialog"></div>
<%--双击自动播放页面--%>
<div id="doubleClickPlayDialog">
    <audio id="audio_url" src="" controls="controls" autoplay="autoplay" loop="loop">

    </audio>
</div>