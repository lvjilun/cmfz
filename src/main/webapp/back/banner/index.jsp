<%@page pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="../../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../themes/icon.css">
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/datagrid-detailview.js"></script>
<script type="text/javascript" src="../../js/jquery.edatagrid.js"></script>
<script type="text/javascript" src="../../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
    $(function () {
        /*var toolbar = [{
            iconCls: 'icon-add',
            text: "添加",
            plain:true,
            handler: function () {
                alert('编辑按钮')
            }
        }, '-', {
            text: "修改",
            plain:true,
            iconCls: 'icon-edit',
            handler: function () {
                //获取选中行
                var row = $("#showAllBannerTable").edatagrid("getSelected");
                if (row != null) {
                    //编辑指定行
                    var index = $("#showAllBannerTable").edatagrid("getRowIndex", row);
                    $("#showAllBannerTable").edatagrid("editRow", index);
                } else {
                    alert("请先选中行")
                }


            }
        }, '-', {
            text: "删除",
            plain:true,
            iconCls: 'icon-remove',
            handler: function () {
                alert('帮助按钮')
            }
        }, '-', {
            text: "保存",
            plain:true,
            iconCls: 'icon-save',
            handler: function () {
                $("#showAllBannerTable").edatagrid("saveRow")

            }
        }]*/
        $("#showAllBannerTable").edatagrid({
            fit: true,
            fitColumns: true,
            url: "${pageContext.request.contextPath}/banner/queryAllBanner",
            columns: [[
                {field: 'id', title: '编号', width: 100, align: 'center'},
                {field: 'title', title: '标题', width: 100, align: 'center'},
                {field: 'imgPath', title: '图片', width: 100, align: 'center'},
                {field: 'netPath', title: '超链接', width: 180, align: 'center'},
                {
                    field: 'status', title: '状态', width: 100, align: 'center', editor: {
                        type: "text",
                        options: {required: true}
                    },
                    formatter: function (value, row, index) {
                        if (value == 1) {
                            return "已展示";
                        } else {
                            return "未展示";
                        }
                    }
                },
                {field: 'uploadDate', title: '上传时间', width: 100, align: 'center'}
            ]],
            view: detailview,
            detailFormatter: function (rowIndex, rowData) {
                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/upload/' + rowData.imgPath + '" style="height:50px;"></td>' +
                    '<td style="border:0">' +
                    '<p>描述: ' + rowData.description + '</p>' +
                    '<p>日期: ' + rowData.uploadDate + '</p>' +
                    '</td>' +
                    '</tr></table>';
            },
            updateUrl: "${pageContext.request.contextPath}/banner/updateOneBanner",
            title: "轮播图管理",
            iconCls: "icon-man",
            pagination: true,
            toolbar: '#addBannerTools',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            pageNumber: 1

        });
        $("#updateBannerBtn").linkbutton({
            onClick: function () {
                //获取选中行
                var row = $("#showAllBannerTable").edatagrid("getSelected");
                if (row != null) {
                    //编辑指定行
                    var index = $("#showAllBannerTable").edatagrid("getRowIndex", row);
                    $("#showAllBannerTable").edatagrid("editRow", index);
                } else {
                    $.messager.show({
                        title: '系统提示',
                        msg: '请先选择要修改的行',
                        showType: 'slide'
                    });
                }
            }
        })
        $("#saveBannerBtn").linkbutton({
            onClick: function () {
                $("#showAllBannerTable").edatagrid("saveRow")
                $.messager.show({
                    title: '系统提示',
                    msg: '修改成功',
                    showType: 'slide'
                });
            }
        })
        $("#deleteBannerBtn").linkbutton({
            onClick: function () {
                var row = $("#showAllBannerTable").edatagrid("getSelected");
                if (row != null) {
                    $.post(
                        "${pageContext.request.contextPath}/banner/deleteOneBannerById?id=" + row.id,
                        function (data) {
                            if (data) {
                                $.messager.show({
                                    title: '系统提示',
                                    msg: '删除成功',
                                    showType: 'slide'
                                });
                                $("#showAllBannerTable").edatagrid("reload");
                            } else {
                                $.messager.show({
                                    title: '系统提示',
                                    msg: '删除失败',
                                    showType: 'slide'
                                });
                            }
                        }
                    )

                } else {
                    $.messager.show({
                        title: '系统提示',
                        msg: '请先选择要删除的行',
                        showType: 'slide'
                    });
                }
            }
        })
        $("#addBannerBtn").linkbutton({
            onClick: function () {
                $("#addBannerDialog").dialog({
                    title: "轮播图添加",
                    width: 400,
                    height: 500,
                    href: 'add.jsp',
                    closed: true
                });
                $("#addBannerDialog").dialog("open");
            }
        })


    })

    function bannerOperation(value, row, index) {
        return "<a href='javascrpt:void(0)' onClick='updated(" + row.id + ")'>修改</a> <a href='javascrpt:void(0)' onClick='deleted(" + row.id + ")'>删除</a>";
    }
</script>
<table id="showAllBannerTable">
    <%--<thead>
    <tr>
        <th data-options="field:'vv',checkbox:true"></th>
        <th data-options="field:'id',width:1,align:'center'">编号</th>
        <th data-options="field:'title',width:1,align:'center'">标题</th>
        <th data-options="field:'imgPath',width:1,align:'center'">图片</th>
        <th data-options="field:'netPath',width:1,align:'center'">超链接</th>
        <th data-options="field:'uploadDate',width:1,align:'center'">上传时间</th>
        <th data-options="field:'description',width:1,align:'center'">描述</th>
        <th data-options="field:'status',width:1,align:'center'">是否展示</th>
        <th data-options="field:'xxx',formatter:bannerOperation">操作</th>
    </tr>
    </thead>--%>
</table>
<div id="addBannerTools">
    <a id="addBannerBtn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a id="updateBannerBtn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
    <a id="deleteBannerBtn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
    <a id="saveBannerBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
</div>
<%--添加轮播图--%>
<div id="addBannerDialog"></div>