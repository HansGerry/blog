<#assign base=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!--适配移动端-->
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <!--引入CSS-->
    <link rel="stylesheet" href="${base}/css/me.css">
    <!--CDN 引入semantic-ui -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
    <title>标签</title>
</head>
<body>
<!--导航-->
<#include "../common/header.ftl">
<!--导航结束-->

<!--中间内容-->
<div class="m-padded-tb-large <#--m-container-small-->">
    <div class="ui container">
        <!--header-->
        <div class="ui top attached segment">
            <div class="ui middle aligned two column grid">
                <div class="column">
                    <h3 class="ui teal header">标签</h3>
                </div>

                <div class="right aligned column">
                    共<h3 class="ui orange header m-inline-block m-text-thin">${total}</h3>个
                    &nbsp;
                    <a href="${base}/blog/tag/manage" class="ui basic teal button mini">标签管理</a>
                </div>
            </div>
        </div>
        <!--博客标签-->
        <div class="ui attached segment tags">
            <#list tagList as tag>
                <button type="button" class="ui basic label m-margin-tb-tiny">${tag.name}
                    <div class="detail">${tag.count}</div>
                </button>
            </#list>




        </div>

        <!--博客列表-->


        <div class="ui top attached teal segment"></div>
        <div class="ui attached segment contentBlog">
            <#--        博客类容-->
        </div>



        </div>
    </div>
</div>
<!--中间内容结束-->

<#--分页参数隐藏域-->
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="pageSize" value="6">
<#--分页参数隐藏域结束-->
<!--页面底部-->
<#include "../common/footer.ftl">
<!--页面底部结束-->

<!--CDN 引入jquery-->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
<!--CDN 引入semantic-ui-->
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
<#--引入通用js-->
<script src="${base}/js/common.js"></script>
<script>
    $("#tag").addClass("active");
    $(".menu.toggle").click(function () {
        $(".m-item").toggleClass('m-mobile-hide');
    });
    //头像下拉
    $(".ui.dropdown").dropdown();

    $(function () {
        //选中第一个标签
        $(".ui.attached.segment.tags").find("button").eq(0).addClass("teal");
        $(".ui.attached.segment.tags").find("button").eq(0).find("div").addClass("teal");
    });

    $(function () {
       homeBlogList(1);
    });
    function homeBlogList(currentPage) {
        //设置隐藏域中currentPage的值
        $("#currentPage").val(currentPage);

        var data = {};
        data.pageNum = $("#currentPage").val();
        data.pageSize = $("#pageSize").val();
        console.log(data);
        $.ajax({
            type: "get",
            url: "/blog/ajax/home/list",
            data: data,
            dataType: "html",
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                $(".ui.attached.segment.contentBlog").empty();
                $(".ui.attached.segment.contentBlog").html(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $(".loading-box").hide();
                if (XMLHttpRequest.status == 303) {
                    window.location.href = "/login";
                } else {
                    //layer.msg("获取需求列表失败");
                    console.log("获取博客列表失败")
                }
            }
        });

    };
</script>
</body>
</html>