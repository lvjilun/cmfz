<%@page pageEncoding="UTF-8" %>
<script type="text/javascript">
    $(function () {
        $("#addOneAlbumFormBtn").linkbutton({
            onClick: function () {
                $("#addOneAlbumForm").form('submit', {
                    url: "${pageContext.request.contextPath}/album/addOneAlbum",
                    onSubmit: function () {
                        return $("#addOneAlbumForm").form("validate");
                    },
                    success: function (data) {
                        $.messager.show({
                            title: "系统提示",
                            msg: "添加专辑成功，快去添加章节吧！"
                        });
                        $("#addOneAlbumDialog").dialog("close");
                        $("#showAllAlbumTable").treegrid("reload");
                    },
                    error: function (data) {
                        $.messager.show({
                            title: "系统提示",
                            msg: "添加专辑失败，不要灰心哟！"
                        });
                    }
                })
            }
        })
    })
</script>
<div>
    <form id="addOneAlbumForm" method="post" enctype="multipart/form-data">
        <table align="center" border="1">
            <tr align="center">
                <td colspan="2"><h3>专辑添加</h3></td>
            </tr>
            <tr>
                <td>专辑名称：</td>
                <td><input class="easyui-validatebox" type="text" name="title" data-options="required:true"></td>
            </tr>
            <tr>
                <td>评分：</td>
                <td><input class="easyui-validatebox" type="text" name="score" data-options="required:true"></td>
            </tr>
            <tr>
                <td>播音：</td>
                <td><input class="easyui-validatebox" type="text" name="broadcast"/>
                </td>
            </tr>
            <tr>
                <td>上传配图：</td>
                <td><input type="file" name="file"></td>
            </tr>
            <tr>
                <td>集数：</td>
                <td><input class="easyui-validatebox" type="text" name="counts" data-options="required:true"></td>
            </tr>
            <tr>
                <td>出版时间：</td>
                <td><input class="easyui-datebox" type="text" name="pubDate" data-options="required:true"></td>
            </tr>
            <tr>
                <td>描述：</td>
                <td><input class="easyui-validatebox" type="text" name="description" data-options="required:true"></td>
            </tr>
            <tr>
                <td>作者：</td>
                <td><input class="easyui-validatebox" type="text" name="author" data-options="required:true"></td>
            </tr>
            <tr>
                <td><a id="addOneAlbumFormBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">提交</a>
                </td>
                <td><a class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" type="reset">重置</a></td>
            </tr>
        </table>
    </form>
</div>
