<%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/14
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>医药终端管理系统</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<body style="overflow-x: hidden; overflow-y: auto;">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black"
             style="color: #f3f4f5 !important;font-weight: 555;font-size: 20px;">医药终端管理系统
        </div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <%--缩放--%>
            <li class="layui-nav-item " lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>

        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <a href="javascript:;">
                    <img src="https://www.woodwhale.top/upload/2021/06/photo_20200911095909-bfcabf13025c43c1b3335b3ac9e5de39.jpeg"
                         class="layui-nav-img">
                    admin
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">仪表盘</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item layui-nav-itemed ">
                    <a href="javascript:;">仓库管理</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a
                                onclick="jump2Page('${pageContext.request.contextPath}/jsp/warehouse/dashboard.jsp')">仪表盘</a>
                        </dd>
                        <dd><a id="warehouse-info-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/warehouse/info.jsp')">仓库信息</a>
                        </dd>
                        <dd><a id="warehouse-item-info-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/warehouse/stock.jsp')">仓库库存</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">供货商管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="supplier-info-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/supplier/info.jsp')">供货商信息</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">材料管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="item-info-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/item/info.jsp')">材料信息</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">材料操作</a>
                    <dl class="layui-nav-child">
                        <dd><a id="purchase-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/operation/purchase.jsp')">仓库进货</a>
                        </dd>
                        <dd><a id="outflow-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/operation/outflow.jsp')">仓库出货</a>
                        </dd>
                        <dd><a id="dispatch-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/operation/dispatch.jsp')">两仓互调</a>
                        </dd>
                        <dd><a id="history-button"
                               onclick="jump2Page('${pageContext.request.contextPath}/jsp/operation/history.jsp')">台账历史</a>
                        </dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe id="mainContent" width="100%" height="100%" style="background-color: #fefefe;"
                allowTransparency="true"></iframe>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        <div style="text-align: center;font-size: 14px;">2022 ©吴宇涵 数学与计算机科学学院 软件工程201班</div>
    </div>
</div>

</body>
</html>


<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/res/js/main.js"></script>
<script>
    layui.use(['element', 'layer', 'util'], () => {
        let element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.$
        // 点击弹出信息
        util.event('lay-header-event', {
            menuRight: () => {
                layer.open({
                    type: 1,
                    content: '<div style="padding: 15px;">一个简单的仓库管理系统</div>' +
                        '<div style="padding: 15px;">by woodwhale</div>',
                    area: ['260px', '100%'],
                    offset: 'rt',
                    anim: 1,
                    shadeClose: true,
                    resize: false
                });
            }
        });
        // 给iframe进行onload事件处理
        $('#mainContent').on('load', () => {
            // 禁止回退监听
            history.pushState(null, null, document.URL);
            window.addEventListener('popstate', () => {
                history.pushState(null, null, document.URL);
            });
        })
    });
    // 默认跳转到仪表盘
    jump2Page("${pageContext.request.contextPath}/jsp/warehouse/dashboard.jsp")
</script>
