<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!-- 引入 ECharts 文件 -->
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/echarts.min.js"></script>
<script type="text/javascript" src="../../js/china.js"></script>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 100%;height: 100%;margin-top: 30px;margin-left: 30px">

</div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    option = {
        title: {
            text: '持明法洲App活跃用户'
        },
        tooltip: {},
        legend: {
            data: ['活跃用户']
        },
        xAxis: {
            data: []
        },
        yAxis: {},
        series: [{
            name: '销量',
            type: 'bar',
            data: []
        }]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    // 异步加载统计信息
    $.post("${pageContext.request.contextPath }/user/activeUser", function (data) {
        //console.log(data);
        //var i = 0;
        var array1 = new Array();
        var array2 = new Array();
        for (var key in data) {
            array1.push(key);
            array2.push(data[key]);
            //array1[i] = key;
            //array2[i] = data[key];
            //i++;
        }
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption({
            xAxis: {
                data: array1
            },
            series: [{
                // 根据名字对应到相应的系列
                name: '活跃用户',
                data: array2
            }]
        });
    }, "json");
</script>
