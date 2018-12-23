<%@page pageEncoding="UTF-8" %>
<script type="text/javascript">
    $(function () {
        $("#addBannerFormSubBtn").linkbutton({
            onClick: function () {
                $("#addBannerForm").form('submit', {
                    url: "${pageContext.request.contextPath}/banner/addOneBanner",
                    onSubmit: function () {
                        return $("#addBannerForm").form("validate");
                    },
                    success: function (data) {
                        $.messager.show({
                            title: "系统提示",
                            msg: "添加轮播图成功！"
                        });
                        $("#addBannerDialog").dialog("close");
                        $("#showAllBannerTable").edatagrid("reload");
                    },
                    error: function (data) {
                        $.messager.show({
                            title: "系统提示",
                            msg: "添加轮播图失败！"
                        });
                    }
                })
            }
        })
    })
</script>
<div>
    <form id="addBannerForm" method="post" enctype="multipart/form-data">
        <table align="center" border="1">
            <tr align="center">
                <td colspan="2"><h3>轮播图管理</h3></td>
            </tr>
            <tr>
                <td>标题：</td>
                <td><input class="easyui-validatebox" type="text" name="title" data-options="required:true"></td>
            </tr>
            <tr>
                <td>图片上传：</td>
                <td><input type="file" name="file"></td>
            </tr>
            <tr>
                <td>活动链接：</td>
                <td><input class="easyui-validatebox" type="text" name="netPath" data-options="required:true"></td>
            </tr>
            <tr>
                <td>状态：</td>
                <td><input class="easyui-combobox" name="status" data-options="
                        valueField: 'label',
                        textField: 'value',
                        data: [{
                            label: '1',
                            value: '已展示'
                        },{
                            label: '0',
                            value: '未展示'
                        }],
                        value:'0'"
                />
                </td>
            </tr>
            <tr>
                <td>描述：</td>
                <td><input class="easyui-validatebox" type="text" name="description" data-options="required:true"></td>
            </tr>
            <tr>
                <td><a id="addBannerFormSubBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">提交</a>
                </td>
                <td><a class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" type="reset">重置</a></td>
            </tr>
        </table>
    </form>
</div>