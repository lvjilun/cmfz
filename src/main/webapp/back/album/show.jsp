<%@page pageEncoding="UTF-8" %>
<script type="text/javascript">
    $(function () {
        $("#showOneAlbumForm").form('load', '${pageContext.request.contextPath}/album/queryOneAlbumById?id=' +${param.id})
    })
</script>
<div>
    <form id="showOneAlbumForm" method="post">
        <table align="center" border="1">
            <tr align="center">
                <td colspan="2"><h3>专辑详情展示页</h3></td>
            </tr>
            <tr>
                <td colspan="2"><input class="easyui-validatebox" type="hidden" name="id"></td>
            </tr>
            <tr>
                <td>专辑名称：</td>
                <td><input type="text" name="title" readonly></td>
            </tr>
            <tr>
                <td>评分：</td>
                <td><input class="easyui-validatebox" type="text" name="score" data-options="required:true" readonly>
                </td>
            </tr>
            <tr>
                <td>播音：</td>
                <td><input class="easyui-validatebox" type="text" name="broadcast" readonly/>
                </td>
            </tr>
            <tr>
                <td>配图：</td>
                <td><img src="${pageContext.request.contextPath}/upload/${param.albumImage}" style="height: 60px"
                         readonly></td>
            </tr>
            <tr>
                <td>集数：</td>
                <td><input class="easyui-validatebox" type="text" name="counts" data-options="required:true" readonly>
                </td>
            </tr>
            <tr>
                <td>出版时间：</td>
                <td><input class="easyui-validatebox" type="text" name="pubDate" data-options="required:true" readonly>
                </td>
            </tr>
            <tr>
                <td>描述：</td>
                <td><input class="easyui-validatebox" type="text" name="description" data-options="required:true"
                           readonly></td>
            </tr>
            <tr>
                <td>作者：</td>
                <td><input class="easyui-validatebox" type="text" name="author" data-options="required:true" readonly>
                </td>
            </tr>
        </table>
    </form>
</div>
