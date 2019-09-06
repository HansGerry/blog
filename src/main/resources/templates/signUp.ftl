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
    <title>注册</title>
    <style type="text/css">

        body > .grid {
            height: 100%;
        }

        .image {
            margin-top: -100px;
        }

        .column {
            max-width: 450px;
        }
    </style>
</head>
<body>
<!--导航-->


<!--导航结束-->

<!--中间内容-->

<div class="ui middle aligned center aligned grid">
    <div class="column">
        <h2 class="ui teal image header">
            <img src="${base}/images/s.png" class="image">
            <div class="content">
                Sign-up your account
            </div>
        </h2>
        <form class="ui large form">
            <div class="ui stacked segment">
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="username" id="username" placeholder="Username" data-content="">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="lock icon"></i>
                        <input type="password" name="password" id="password" placeholder="Password" data-content="">
                    </div>
                </div>
                <button type="button" class="ui fluid large teal button" id="loginBtn">Sign Up</button>
            </div>

            <div class="ui error message"></div>

        </form>

        <div class="ui message">
            Have account? <a href="${base}/login">Log In</a> <br>
            <a href="/">游客浏览</a>
        </div>
    </div>
</div>

<!--中间内容结束-->


<#--验证提示信息-->
div.
<#--验证提示信息结束-->

<!--页面底部-->

<!--页面底部结束-->

<!--CDN 引入jquery-->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
<!--CDN 引入semantic-ui-->
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
<#--引入通用js-->
<script src="${base}/js/common.js"></script>
<script>
    $(".menu.toggle").click(function () {
        $(".m-item").toggleClass('m-mobile-hide');
    })
    $(".ui.dropdown").dropdown();
</script>


<script>

    //form表单验证
    $(document).ready(function() {
            $('.ui.form')
                .form({
                    on:"blur",
                    inline:true,
                    fields: {
                        email: {
                            identifier  : 'username',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter your e-mail'
                                },
                                {
                                    type   : 'email',
                                    prompt : 'Please enter a valid e-mail'
                                }
                            ]
                        },
                        password: {
                            identifier  : 'password',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter your password'
                                },
                                {
                                    type   : 'length[6]',
                                    prompt : 'Your password must be at least 6 characters'
                                }
                            ]
                        }
                    }
                })
            ;
        });

    // $("#loginBtn").click(function () {
    //     var username=$("#username").val();
    //     var password=$("#password").val();
    //
    //
    //     var data = {};
    //
    //     data.username=username;
    //     data.password=password;
    //     console.log(data);
    //     $.ajax({
    //         type: "post",
    //         url: "/ajax/login",
    //         contentType: "application/json;charset=UTF-8",
    //         data: JSON.stringify(data),
    //         sync:false,
    //         dataType: "json",
    //         success: function (data){
    //             console.log("success")
    //             if(data.code==200){
    //                 window.location.href="/home"
    //             }
    //             if(data.code==300){
    //                 console.log(data.msg)
    //                 $("#password").attr("data-content",data.msg);
    //             }
    //             if(data.code=301){
    //                 console.log(data.msg)
    //                 $("#username").attr("data-content",data.msg);
    //             }
    //
    //         },
    //         error: function () {
    //             console.log("error")
    //         }
    //
    //
    //
    //     })



    })
</script>

</body>
</html>