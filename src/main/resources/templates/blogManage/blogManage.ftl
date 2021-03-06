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
    <title>博客管理</title>
</head>
<body>
<!--导航-->
<#include "${base}/common/header.ftl">

<div class="ui menu attached">
    <div class="ui container ">
        <div class="right menu">
            <a href="${base}/blog/add" class="item">发布</a>
            <a href="${base}/blog/manage" class="active teal item">列表</a>
        </div>
    </div>
</div>
<!--导航结束-->

<!--中间内容-->
<div class="m-padded-tb-large<#-- m-container-small-->" <#--style="margin-top: 30px;"-->>

    <div class="ui container">
        <#--消息提示:默认隐藏-->
        <div class="ui success message" hidden>
            <i class="close icon"></i>
            <div class="header center-pill">提示:</div>
            <p></p>
        </div>

        <!--搜索栏-->
        <div class="ui top attached segment">
            <form action="#" method="post" class="ui padded segment form">
                <!--第一行-->
                <div class="inline fields">
                    <div class="field">
                        <input type="text" name="title" placeholder="请输入标题" id="title">
                    </div>
                    <div class="field">
                        <div class="ui search selection dropdown">
                            <!--隐藏域：用于存放选择的值-->
                            <input type="hidden"  name="typeId" id="typeId">
                            <i class="ui dropdown icon"></i>
                            <div class="default text" id="blogType">请选择分类</div>
                            <div class="menu">
                                <!--选项内容-->

                                <#list typeList as type>
                                    <div class="item" data-value="${type.id}">${type.name}</div>
                                </#list>
                            </div>
                        </div>

                    </div>
                    <div class="field">
                        <div class="ui checkbox">
                            <input type="checkbox" name="recommend" id="recommend"  class="hidden">
                            <!--for="recommend" 关联checkbox 点击文字的时候也可以关联-->
                            <label for="recommend">推荐</label>
                        </div>
                    </div>
                    <div class="field">
                        <button type="button" class="ui button teal basic mini searchBlogBtn"><i
                                    class="search icon"></i>搜索
                        </button>
                        <button type="button" class="ui button teal basic mini delFormBtn"><i class="delete icon"></i>
                            清空
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <!--搜索栏结束-->

        <!--表格-->
        <!--celled 加网格线-->
        <div class="ui bottom attached  segment">
            <div class="blogListTable">

                <#--表格区域-->
            </div>
        </div>

        <!--表格结束-->
    </div>
</div>
<!--中间内容结束-->


<#---------------------------弹窗--------------------------------------------->


<#--删除类型弹窗-->
<div class="ui modal mini del">

    <div class="header">
        提示
    </div>
    <div class="content">
        <#--删除Id隐藏域-->
        <input type="hidden" value="" id="blogId">
        <i class="archive icon large"></i> 确定要删除吗？
    </div>

    <div class="actions " style="text-align: center;">
        <button type="button" class="ui approve red button" id="delBtn" >确定</button>
        <button class="ui cancel button">取消</button>
    </div>
</div>
<#--删除类型弹窗结束-->


<#---------------------------弹窗结束--------------------------------------------->



<#--分页参数隐藏域-->
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="pageSize" value="10">
<#--分页参数隐藏域结束-->

<!--页面底部-->
<#include "${base}/common/footer.ftl">
<!--页面底部结束-->

<!--CDN 引入jquery-->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
<!--CDN 引入semantic-ui-->
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
<#--引入通用js-->
<script src="${base}/js/common.js"></script>
<#--引入layer.js-->
<script src="${base}/lib/layer/layer.js"></script>
<script>

    $(function () {
        blogList(1);
    })
    $(".menu.toggle").click(function () {
        $(".m-item").toggleClass('m-mobile-hide');
    })
    $(".ui.dropdown").dropdown();

    $(".delFormBtn").click(function () {
        //清空检索表单
        $('.ui.segment.form')[0].reset();
        $('.text').html("请选择分类");
        $('.text').addClass("default");
    });


    $(".searchBlogBtn").click(function () {

        blogList(1);
    });


    function blogList(currentPage) {
        //设置隐藏域中currentPage的值
        $("#currentPage").val(currentPage);

        //搜索的值

        var t = $(".ui.form").serializeArray();
        var data = {};
        //form表单数据转json
        $.each(t, function () {
            if (this.name === "recommend" && this.value === "on") {
                data [this.name] = true;
            }else {
                data [this.name] = this.value;
            }
        });
        data.pageNum = $("#currentPage").val();
        data.pageSize = $("#pageSize").val();
        console.log(data);
        var loading =null;
        $.ajax({
            type: "post",
            url: "/blog/ajax/list",
            data: JSON.stringify(data),
            dataType: "html",
            contentType: 'application/json;charset=UTF-8',
            beforeSend:function(){
                loading= layer.load(1);
            },
            complete:function(){
                layer.close(loading);
            },
            success: function (data) {
                $(".blogListTable").empty();
                $(".blogListTable").html(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $(".loading-box").hide();
                if (XMLHttpRequest.status == 303) {
                    window.location.href = "/login";
                } else {
                    $(".success.message p").html("获取博客列表失败");
                    $(".success.message").closest('.message').transition('show');
                    console.log("获取博客列表失败")
                }
            }
        });

    };

    //删除博客
    $("#delBtn").click(function () {
        var blogId = $("#blogId").val();
        $.ajax({
            type: "delete",
            url: "/blog/delete/"+blogId,
            dataType: "json",
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                if (data.code == 200) {
                    blogList(1);
                    $(".success.message p").html(data.msg);
                    $(".success.message").closest('.message').transition('show');

                    layer.msg(data.msg,{icon:1});

                } else if (data.code == 601) {
                    $(".success.message p").html(data.msg);
                    $(".success.message").closest('.message').transition('show');
                    layer.msg(data.msg,{icon:2});
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $(".loading-box").hide();
                if (XMLHttpRequest.status == 303) {
                    window.location.href = "/login";
                } else {
                    $(".success.message p").html("删除博客列表失败");
                    $(".success.message").closest('.message').transition('show');
                }
            }
        });
    });


</script>
</body>
</html>