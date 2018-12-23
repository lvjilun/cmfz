<%@page pageEncoding="UTF-8" %>
<script type="text/javascript">
    $(function () {
        // 初始化 专辑下拉列表
        $("#selectAlbum").combobox({
            editable: false,
            url: "${pageContext.request.contextPath}/album/queryAllAlbumSelect",
            valueField: "id",
            textField: "title",
            onLoadSuccess: function (data) {  // data -- [{},{}]
                // 设置下拉列表中的第一项 默认被选中
                $("#selectAlbum").combobox("setValue", data[0].id);
            }
        });
        $("#addOneChapterFormBtn").linkbutton({
            onClick: function () {
                $("#addOneChapterForm").form('submit', {
                    url: "${pageContext.request.contextPath}/chapter/addOneChapter",
                    onSubmit: function () {
                        return $("#addOneChapterForm").form("validate");
                    },
                    success: function (data) {
                        $.messager.show({
                            title: "系统提示",
                            msg: "添加章节成功，快去查看吧！"
                        });
                        $("#addOneChapterDialog").dialog("close");
                        $("#showAllAlbumTable").treegrid("reload");
                    },
                    error: function (data) {
                        $.messager.show({
                            title: "系统提示",
                            msg: "添加章节失败，不要灰心哟！"
                        });
                    }
                })
            }
        })

    })
</script>
<div>
    <form id="addOneChapterForm" method="post" enctype="multipart/form-data">
        <table align="center" border="1">
            <tr align="center">
                <td colspan="2"><h3>章节添加</h3></td>
            </tr>
            <tr>
                <td>对应专辑：</td>
                <td><input id="selectAlbum" class="easyui-combobox" name="albumId" data-options="required:true"></td>
            </tr>
            <tr>
                <td>标题：</td>
                <td><input class="easyui-validatebox" type="text" name="title" data-options="required:true"></td>
            </tr>
            <tr>
                <td>上传文件：</td>
                <td><input type="file" name="file"></td>
            </tr>
            <tr>
                <td><a id="addOneChapterFormBtn" class="easyui-linkbutton"
                       data-options="iconCls:'icon-save',plain:true">提交</a></td>
                <td><a class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" type="reset">重置</a></td>
            </tr>
        </table>
    </form>
</div>
