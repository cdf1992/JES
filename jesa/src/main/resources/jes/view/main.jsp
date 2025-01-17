<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="jes/view/inc/top.httl" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>

<head>

    <%@ include file="jes/view/inc/head.httl" %>
    <%@ include file="jes/view/inc/extjs.httl" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="${app}/res/img/favicon.ico">


    <link type="text/css" rel="stylesheet" href="${app}/res/db/bootstrap/css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="${app}/res/db/font-awesome-default/css/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="${app}/res/db/ace/css/ace.min.css"/>
    <link type="text/css" rel="stylesheet" href="${app}/res/db/ace/css/ace-rtl.min.css"/>
    <link type="text/css" rel="stylesheet" href="${app}/res/db/ace/css/ace-skins.min.css"/>
    <link type="text/css" rel="stylesheet" href="${app}/res/db/bootstrap/validator/bootstrapValidator.min.css">
    <link type="text/css" rel="stylesheet" href="${app}/res/css/sys.css"/>
    <link type="text/css" rel="stylesheet" href="${app}/res/css/main.css"/>

    <script type="text/javascript" src="${app}/res/js/jq/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/other/html5shiv.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/other/respond.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/ace/ace-extra.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/bootstrap/validator/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/ace/ace.min.js"></script>
    <script type="text/javascript" src="${app}/res/db/layer/layer.js"></script>


</head>
<script type="text/javascript">
    Ext.require([
        'Ext.ux.window.Notification'
        , 'Sys.app.PassWin'
        , 'Ext.util.DelayedTask'
    ]);
</script>
<body>
<!--navbar start-->
<div class="navbar navbar-default navbar-${theme}" id="navbar">
    <div class="navbar-container" id="navbar-container">

        <!--logo start-->
        <div class="navbar-logo pull-left">
            <img src="${jesLogo}" style="width: ${jeslogoWidth}px;height: ${jeslogoHeight}px;" alt="">
        </div>
        <div class="navbar-header pull-left">
            <a href="#" class="navbar-brand">
                <small>
                    ${productName}
                    <span style="color:red;font-size:70%;">${envType}</span>
                </small>
            </a>
        </div>
        <!--logo start-->

        <!--navbar_header start-->
        <div class="navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">

                <!--top_menu start-->
                <li>

                    <a id="index" data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0);">
                        <i class="icon-myhome"></i>
                        <span class="header-title-span"><spring:message
                                code="jes.WebContent.res.js.app.main.shouye"></spring:message></span><!-- 首页 -->
                    </a>

                </li>
                ${menus}
                <!--my_msg start-->
                <li id="my-msg">
                </li>
                <!--my_msg end-->

                <!--top_menu end-->

                <!--user start-->
                <li class="navbar-${theme}">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <img class="nav-user-photo" src="${app}/res/db/ace/images/user.png" alt="${userId}"/>
                        <span class="user-info" style="padding: 0;">
                                <small id="hello"></small>
                                ${userCname}
                            </span>

                        <b class="fa fa-angle-down"></b>
                    </a>
                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <%--<li>--%>
                        <%--<a href="#">--%>
                        <%--<i class="icon-cog"></i>--%>
                        <%--设置--%>
                        <%--</a>--%>
                        <%--</li>--%>
                        <li>
                            <a href="javascript:void(0);" onclick="modifyUser1();">
                                <i class="fa fa-user"></i>
                                <spring:message code="jes.WebContent.res.js.app.main.grxx"></spring:message><!-- 个人信息 -->
                            </a>
                        </li>

                        <li id="languageSettingTrigger">
                            <a href="javascript:void(0);">
                                <i class="fa fa-caret-left"></i>
                                Language
                            </a>
                            <ul id="languageSetting">
                                <li class="languageItem">
                                    <a href="javascript:void(0);" type="submit" onclick="languages('zh');">
                                        简体中文
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li class="languageItem" style="height: 32px;">
                                    <a href="javascript:void(0);" type="submit" onclick="languages('en');"
                                       style="position: absolute;top: 44px;">
                                        English
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="divider"></li>
                        <li>
                            <a id="logout" href="javascript:void(0);">
                                <i class="fa fa-power-off"></i>
                                <spring:message code="jes.WebContent.res.js.app.main.tuichu"></spring:message>
                                <!--  退出 -->
                            </a>
                        </li>
                    </ul>
                </li>
                <!--user end-->

            </ul>
        </div>
        <!--navbar_header end-->

    </div>
</div>
<!--navbar end-->

<!--container start-->
<div class="main-container" id="main-container">
    <a class="menu-toggler" id="menu-toggler" href="#">
        <span class="menu-text"></span>
    </a>
    <div class="sidebar sidebar-${theme}" id="sidebar">
        <!--sidebar start -->
        <div class="sidebar-shortcuts" id="sidebar-shortcuts">
            <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
                <button class="btn btn-success">
                    <i class="fa fa-signal"></i>
                </button>
                <button class="btn btn-info">
                    <i class="fa fa-pencil"></i>
                </button>
                <button class="btn btn-warning">
                    <i class="fa fa-group"></i>
                </button>
                <button class="btn btn-danger">
                    <i class="fa fa-cogs"></i>
                </button>
            </div>
            <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                <span class="btn btn-success"></span>
                <span class="btn btn-info"></span>
                <span class="btn btn-warning"></span>
                <span class="btn btn-danger"></span>
            </div>
        </div>
        <!--sidebar end -->

        <!--left_menu start -->
        <ul class="nav nav-list" data-collectflag='true'></ul>
        <!--left_menu end -->

        <!--sidebar_collapse start-->
        <div class="sidebar-collapse" id="sidebar-collapse">
            <i class="icon-double-angle-left fa fa-angle-double-left"
               data-icon1="fa fa-angle-double-left icon-double-angle-left"
               data-icon2="fa fa-angle-double-right icon-double-angle-right"></i>
        </div>
        <!--sidebar_collapse end-->
    </div>


    <!--main start-->
    <div class="main-content">
        <div class="page-content" id="page-content">
            <iframe src="home.do" id="indexContent" scrolling='no' width="100%" height="100%"
                    frameborder="0"></iframe>
        </div>
    </div>
    <!--main end-->

</div>

<!--tabs start-->
<div id="index-tabs" class="tab-${theme}"></div>
<!--tabs end-->


<!--container end-->
<script type="text/javascript">

    var sysJesRunDuration=${JES_PAGE_EXPIRE};
    window.top.document.jesRunDuration=-2;
    window.top.document.resetJesRunDuration=function(){
        window.top.document.jesRunDuration=0;
    }
    document.body.onclick=window.top.document.resetJesRunDuration;
    document.body.onkeydown=window.top.document.resetJesRunDuration;
    
    $.ajaxSetup({
        error: function (x, e) {
          //由于本页ajax失败可能造成页面假死,所以增加支持(返回login认为需处理)
          if(x && x.responseText && x.responseText.indexOf('login.js')>1){
                window.top.location='exit.do';
          }
        }
    });

    $(window).resize(function(){
    	$('.main-container').height($(window).height() - 25 -($('#navbar').height() - 45))
    });
    $('.main-container').height($(window).height() - 25)
    var isThird = ${isThird};
    var tabMessage = '${expirationDate}';
    var IframeOnClick = {
        resolution: 200,
        iframes: [],
        interval: null,
        Iframe: function () {
            this.element = arguments[0];
            this.cb = arguments[1];
            this.hasTracked = false;
        },
        track: function (element, cb) {
            this.iframes.push(new this.Iframe(element, cb));
            if (!this.interval) {
                var _this = this;
                this.interval = setInterval(function () {
                    _this.checkClick();
                }, this.resolution);
            }
        },
        checkClick: function () {
            if (document.activeElement) {
                var activeElement = document.activeElement;
                for (var i in this.iframes) {
                    if (activeElement === this.iframes[i].element) { // user is in this Iframe
                        if (this.iframes[i].hasTracked == false) {
                            this.iframes[i].cb.apply(window, []);
                            this.iframes[i].hasTracked = true;
                        }
                    } else {
                        this.iframes[i].hasTracked = false;
                    }
                }
            }
        }
    };
    var outerUrlCache = {}
    // 动态添加下拉菜单事件
    // 使用调用 __dropdown.draw(data) data为银监会子系统 人行子系统等等小系统点击后获取的json
    var __dropdown = {
        draw: function (data, icon, flag) {
            var systemName = data.splice(data.length-1,1);

            function getAttrText(obj) {
                var str = '';
                $.each(obj, function (i, v) {
                    if (i === 'text' || i === 'children') return
                    str += ' data-' + i + '="' + v + '"'
                });
                return str
            }

            function getSubmenuText(data) {
                var str = '<li><a href="#" class="border-${theme}"><i class=" icon-double-angle-right"></i></a></li>'
                return str.replace(/\<li\>/, '<li' + getAttrText(data) + '>').replace(/\<\/i\>/, '</i>' + data.text)
            }

            var arr = ['fa fa-steam', 'fa fa-random', 'fa fa-eraser', 'fa fa-sign-language', 'fa fa-star-half-o', 'fa fa-sitemap', 'fa fa-puzzle-piece', 'fa fa-align-justify', 'fa fa-th', 'fa fa-telegram', 'fa fa-paragraph', 'fa fa-table', 'fa fa-empire', 'fa fa-search', 'fa fa-file', 'fa fa-indent', 'fa fa-star', 'fa fa-film', 'fa fa-signal', 'fa fa-gear', 'fa fa-road', 'fa fa-inbox', 'fa fa-bookmark', 'fa fa-print', 'fa fa-paperclip']
            var count = 0;

            function getMainmenuText(data) {
                getAttrText(data);
                var inner = '';

                function returnIcon() {
                    return arr[count++]
                }

                data.ssIcon = data.ssIcon || returnIcon();
                if (data.children) {
                    $.each(data.children, function (i, v) {
                        inner += getSubmenuText(v)
                    })
                }
                if (data.expanded) {
                    var str = '<li class="open"><a href="#" class="dropdown-toggle"><i class="' + data.ssIcon + '"></i>' +
                        '<span class="menu-text"></span><b class="arrow fa  fa-angle-down"></b></a>' +
                        '<ul class="submenu" style="display: block">' + inner + '</ul></li>'
                } else {
                    var str = '<li><a href="#" class="dropdown-toggle"><i class="' + data.ssIcon + '"></i>' +
                        '<span class="menu-text"></span><b class="arrow icon-angle-down"></b></a>' +
                        '<ul class="submenu">' + inner + '</ul></li>'
                }
                return str.replace(/\<li/, '<li' + getAttrText(data)).replace(/\<\/span\>/, data.text + '</span>')
            }

            function getSidemenu(data, icon, flag) {
                flag = flag || '';
                $('#content-sidebar').html('');
                var inner = '';
                $.each(data, function (i, v) {
                    inner += getMainmenuText(v)
                });
                $('#sidebar .nav-list').html(inner);
                $('#sidebar .nav-list').attr('data-collectflag', flag);
                $("#sidebar .nav-list").prepend('<li class="systemName" id="systemName"><a href="javascript:void(0)"><i class="' + icon + '"></i><span class="menu-text">' + systemName + '</span></a></li>')
            }

            getSidemenu(data, icon, flag);
            $('.nav.nav-list').attr('data-icon', icon);
            this.addClick()
        },
        expand: function () {
            $(this).parent().addClass('open');
            $(this).next().css({'display': 'block'})
        },
        collapse: function () {
            $(this).parent().removeClass('open');
            $(this).next().css({'display': 'none'})
        },
        addClick: function () {
            var self = this;
            $('#sidebar').delegate('.nav.nav-list>li>a', 'click', function () {
                $(this).parent().hasClass('open') ? self.collapse.call(this) : self.expand.call(this)
            })
        },
        contextmenuChange: function (callback) {
            $('.submenu>li').contextmenu(function (e) {
                if ($('.contextMenu').length = 1) $('.contextMenu').eq(0).remove();
                $(this).css({'user-select': 'none'});
                if ($(this).parent().parent().attr('data-id') === 'init') return false;
                var isCollect=$('#sidebar .nav-list').attr('data-collectflag');
                var str = isCollect ? '<spring:message code="jes.WebContent.res.js.app.main.qxshoucang"></spring:message>'/* 取消收藏 */ : '<spring:message code="jes.WebContent.res.js.app.main.jrshoucang"></spring:message>'/* 加入收藏 */;
                $('body').append("<div class='contextMenu' style='left:" + e.clientX + "px;top:" + e.clientY + "px'>" + str + "</div>");

                var obj = {};
                obj.objectId = $(this).attr('data-id');
                var ssIdAndMenuId= obj.objectId.split('#');
                obj.menuId = ssIdAndMenuId[1];
                obj.ssId = ssIdAndMenuId[0];
                obj.ssurl = $(this).attr('data-ssurl');
                obj.menuUrl = $(this).attr('data-menuurl');
                obj.leaf = true;
                obj.menuName = $(this).find('a').html().split('\/i\>')[1];
                if (callback) callback(obj);
                $('.contextMenu').on('click',function(){
                	var ajaxUrl=isCollect? 'deleteFromMyFavorite.ajax' : 'addToMyFavorite.ajax';
                	var msgText=isCollect? '移除' : '添加到';
                	Ext.Ajax.request({
						 url: ajaxUrl,
							 params:obj,
							 success: function(response,req){	
								 eval('var result='+response.responseText)
								 if(result.success){
								 	 jesAlert('['+obj.menuName+']已成功' + msgText + '我的收藏！');
								 	 if(isCollect){
								 		getMyFavorite();
								 	 }
								 }else{
									 jesErrorAlert('['+obj.menuName+']' + msgText + '我的收藏失败！');
								 }
							 }	 
					 });
                });	
                
                return false
            });
            document.onclick = function () {
                if ($('.contextMenu')) $('.contextMenu').hide()
            };
            IframeOnClick.track(document.getElementById('indexContent'), function () {
                if ($('.contextMenu')) $('.contextMenu').hide()
            });
        }
    };

    var trigger = {
        list: [],
        // 设置底部tabWrap宽度
        setTabWrapWidth: function () {
            var sidebarWidth = $('#sidebar').width(),
                windowWidth = $(window).width(),
                tabsWrapWidth = windowWidth - sidebarWidth - 1
            if (windowWidth < 992) $('#index-tabs').width(windowWidth)
            else $('#index-tabs').width(tabsWrapWidth)
        },
        // 返回iframe模板
        getIframe: function (obj) {
            return '<iframe src="' + obj.ssurl + '" id="' + obj.id + '" style="display:none;">'
        },
        // 返回tabbox模板
        getTabs: function (obj) {
            var icon = $('.nav.nav-list').attr('data-collectflag') ? obj.ssIcon : $('.nav.nav-list').attr('data-icon')
            return '<div class="tab-box" tabId="' + obj.id + '"  sysName="' + obj.sysName + '" tabMenuurl="' + obj.menuurl + '"><i class="' + icon + '"></i><span>' + obj.text + '</span><b>×</b></div>'
        },
        // 返回tabMore模板
        getTabMore: function () {
            return ' <div id="tab-boxMore" onclick="return false"><i class="fa fa-pencil"></i><div class="moreTag" onclick="return false">更多标签</div><div class="fa fa-caret-up"></div><div id="moreWrap"></div></div>'
        },
        // 根据当前情况更新tabWrap显示状态
        tabWrapState: function () {
            if (trigger.list.length > 0) {
                $('#index-tabs').show()
                if ($('#tabMessage').length == 0) {
                    $('#index-tabs').append('<ul id="tabMessage">' + tabMessage + '<ul>')
                }
            }
            else if (trigger.list.length === 0) $('#index-tabs').hide()
        },
        // moreTab样式绘制
        moreBoxReflow: function (count) {
            // count--
            $('#moreWrap').css({
                'top': -count * 25 - 2 + 'px',
                'height': count * 25 + 'px'
            })
        },
        // 当应显示的tab超出底部限制时  增加tab-boxMore重绘底部tabWrap 动态添加超出的到moreWrap中
        // 调用环境 1.点击左侧sidebar上的菜单 2.点击sidebar缩小菜单 3.window.resize 4.减少
        reflowTabBox: function (flag) {
            var count = this.getTabsMaxCount(),
                len = $('.tab-box').length,
                self = this
            if (len > count && !flag) {
                if ($('#tab-boxMore').length) {
                    self.moreBoxReflow(len - count + 1)
                    for (var i = count - 1; i < len; i++) {
                        $('#moreWrap').prepend($('.tab-box').eq(i))
                    }
                }
                else {
                    $('#index-tabs').append(self.getTabMore())
                    self.moreBoxReflow(len - count + 1)
                    for (var i = count - 2; i < len; i++) {
                        $('#moreWrap').prepend($('.tab-box').eq(i))
                    }
                }
            }
            if (flag) {
                if (flag === 'out') {
                    var moveTab = Array.prototype.pop.call($('#moreWrap').children())
                    $(moveTab).insertBefore('#tab-boxMore')

                }
                if ($('#moreWrap').children().length === 1) {
                    var str = $('#moreWrap').html()
                    $('#tab-boxMore').remove()
                    $('#index-tabs').append(str)
                }
                self.moreBoxReflow(len - count + 1)
            }


        },
        // 内容中添加sidebar菜单请求地址的iframe
        contentAppendIframe: function (str, obj) {
            $('#page-content').append(str)
            document.getElementById(obj.id).onload = function(t){
                // try{
                //     var dom = this.contentWindow.Ext.ComponentQuery.query('viewport')[0].getEl().dom;
                //     dom.onclick=window.top.document.resetJesRunDuration
                //     dom.onkeydown=window.top.document.resetJesRunDuration
                // }catch(e){
                    //do nothing
                    var doc = this.contentWindow.document;
                    doc.onclick=window.top.document.resetJesRunDuration;
                    doc.onkeydown=window.top.document.resetJesRunDuration;
                // }
            }
        },
        // 在tabWrap中添加tabBox并将其转为active状态  重绘tabWrap
        tabWrapAppendTab: function (str) {
            $('#index-tabs').append(str)
            this.addActive($('.tab-box').eq($('.tab-box').length - 1))
            this.reflowTabBox()
        },
        // 改变内容
        changeContent: function (id) {
            for (var i = 0, l = $('#page-content').children().length; i < l; i++) {
               var t =  $('#page-content').children()[i];
               if(t.id == id){
            	    if(document.lastIdOfContent != id){
            			$(document.getElementById(id)).show()
            	    }else{
            	    	document.getElementById(id).contentWindow.location.reload();
            	    }
               }else{
	               $(t).hide()
               }
            } 
            
    	    document.lastIdOfContent = id;
        },
        // 返回值为底部tab可容纳最大个数
        getTabsMaxCount: function () {
            this.setTabWrapWidth()
            var tabBoxWidth = $('.tab-box').eq(0).width() + 4,
                sidebarWidth = $('#index-tabs').width(),
                maxCount = Math.floor(sidebarWidth / tabBoxWidth)
            return maxCount
        },
        // 添加tab活跃事件
        addActive: function (obj) {
            $('.tab-box').each(function (index, item) {
                $(item).removeClass('tabActive')
            })
            $(obj).addClass('tabActive')
        },
        // 判断是否需要添加iframe 并且替换内容
        judgeAppendIframe: function (obj) {
            var flag = false
            // 如果已经存在 则不在数组中添加
            for (var i = 0; i < trigger.list.length; i++) {
                if (trigger.list[i] === obj.id) {
                    flag = true
                }
            }
            if (!flag) {
                if (!this.mask) {
                    this.mask = new Ext.LoadMask(document.body, {msg: '<spring:message code="jes.WebContent.res.js.app.main.zzjzym"></spring:message>'/* "正在加载页面，请稍等..." */});
                }
                this.mask.show();
                trigger.list.push(obj.id)
                // 获取新iframe 并添加到内容中
                this.add(obj)
            }
            this.changeContent(obj.id)
        },
        // 添加新iframe&&tab
        add: function (obj) {
            var self = this
            self.contentAppendIframe(self.getIframe(obj), obj)
            self.tabWrapAppendTab(self.getTabs(obj))
            this.tabWrapState()
            if(self.list.length > ${maxPageTabs}){
            	self.closeTab($('div[tabid='+ self.list[0] +']')[0])
            }
        },
        afterRender: function (obj, callback) {
            var me = this;
            $(document.getElementById(obj.id)).load(function () {
                if (me.mask) {
                    me.mask.hide();
                }
                IframeOnClick.track(document.getElementById(obj.id), function () {
                    if ($('.contextMenu')) $('.contextMenu').hide()
                });
                if (callback && $.isFunction(callback)) {
                    callback.call(this, obj);
                }
            })
        },
        changeSideMenu: function (str, obj) {
            var el = $(obj),
                ssId = el.attr('tabid').split('#')[0],
                sysName = el.attr('sysname'),
                outerUrl = outerUrlCache[ssId],
                icon = $(el).children('i').attr('class'),
                currentSidemenuName = $('#systemName .menu-text').html();
            if (sysName == currentSidemenuName) return;
            if (sysName === '<spring:message code="jes.WebContent.res.js.app.main.shouye"></spring:message> '/* '首页' */) {
                $.getJSON('getMyFavorite.ajax', function (data) {
                    data[0].ssIcon = 'fa fa-edit';
                    data.push('<spring:message code="jes.WebContent.res.js.app.main.shouye"></spring:message> '/* '首页' */);
                    data[0].expanded = true;
                    __dropdown.draw(data, 'fa fa-home', true);
                    __dropdown.contextmenuChange(function (a) {
                        console.log(a);
                    });
                });
            } else {
                $.getJSON('ssmenu.ajax', {outerUrl: outerUrl, ssId: ssId}, function (data) {
                    for (var i = 0; i < data.length; i++) {
                        for (var j = 0; j < data[i].children.length; j++) {
                            data[i].children[j].id = ssId + '#' + data[i].children[j].id
                        }
                    }
                    var text = sysName || $(me).children('span').html()
                    data.push(text)
                    __dropdown.draw(data, icon);
                    __dropdown.contextmenuChange(function (targetObj) {
                        console.log(targetObj)
                    })
                });
            }
        },
        closeTab:function (tab) {
        	   document.lastIdOfContent = null; //防止已关闭的Tab被再次激活时，失败
        	
               var tabId = $(tab).attr('tabId'),
                   prevContent = $(document.getElementById(tabId)).prev(),
                   prevContentId = $(prevContent).attr('id'),
                   moreTagFlag = $('#moreWrap').find(tab).length ? 'in' : 'out';

               // 1.移除当前tab
               $(tab).remove();
               // 2.移除当前tab对应的content
               var frameEl = document.getElementById(tabId);
               if(!!window.ActiveXObject || "ActiveXObject" in window){
                   var frame = frameEl.contentWindow;
                   frame.src = 'about:blank';
                   try{
                       frame.document.write('');
                       frame.document.clear();
                   } catch (e){jesAlert(e);}
                   frameEl.parentNode.removeChild(frameEl);
                   CollectGarbage();
               } else {
                   $(frameEl).remove();
               }
               // 3.移除数组中对应项
               if ($.inArray(tabId, trigger.list) >= 0) trigger.list.splice($.inArray(tabId, trigger.list), 1);
               // 4.展示当前tab对应内容的前一项
               for (var i = 0, l = $('#page-content').children().length; i < l; i++) {
                   $('#page-content').children().eq(i).hide()
               }
               prevContent.show();
               // 5.将对应tab转为active状态
               $('.tab-box').each(function (index, item) {
                   if ($(item).attr('tabId') == prevContentId) trigger.addActive($(item));
               });
               // 6.移除更多便签
               trigger.reflowTabBox(moreTagFlag);
               // 7.更新tabWrap状态
               trigger.tabWrapState();
        },
        init: function (obj, callback) {
            this.judgeAppendIframe(obj);
            this.afterRender(obj, callback);
            return this
        }
    };

    function getMyFavorite() {
        $.getJSON('getMyFavorite.ajax', function (data) {
            data[0].ssIcon = 'fa fa-edit';
            data.push('<spring:message code="jes.WebContent.res.js.app.main.shouye"></spring:message> '/* '首页' */);
            __dropdown.draw(data, 'fa fa-home', true);
            $('.tab-box').each(function (index, item) {
                $(item).removeClass('tabActive');
            });
            __dropdown.contextmenuChange(function (a) {
                console.log(a);
            });
        });
        trigger.changeContent && trigger.changeContent("indexContent");
    }

    var jesLocalStorage = new Ext.util.LocalStorage();

    function languages(language) {
        Ext.Ajax.request({
            url: 'language.ajax',
            params: {
                language: language
            },
            success: function (response) {
                window.location.reload()
            }
        })
    }

    function modifyUser1() {
        $.ajax({
            url: 'modifyUser.ajax?f=BSYS.modifyUser',
            success: function (res) {
                // var user = eval("(" + res.user + ")");
                var user = JSON.parse(res.user);

                function returnValue(key) {
                    return key === null || key === undefined ? '' : key;
                }

                var currentPortrait = $('.nav-user-photo').eq(0).attr('src'),
                    sysPortraitPath = '${app}/res/img/portait/',
                    sysPortraits = ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg', '12.jpg', '13.jpg'],
                    sysPortraitTemplate = '',
                    count = 0;
                sysPortraits.forEach(function (t) {
                    sysPortraitTemplate += '<img src="' + sysPortraitPath + t + '">'
                });

                $('body').delegate('#portaitSelected', 'click', function () {
                    $('.layui-layer').append('<div id="portaitMask"></div>');
                    $('#portaitShow').show();
                    if (count === 0) {
                        $('#portaitWrap').append(sysPortraitTemplate);
                        count++;
                    }
                }).delegate('#portaitWrap>img', 'click', function () {
                    $('#portaitSelected>img').attr('src', $(this).attr('src'));
                    $('#portaitMask').remove();
                    $('#portaitShow').hide();
                }).delegate('#portaitMask', 'click', function () {
                    $('#portaitMask').remove();
                    $('#portaitShow').hide();
                })
//                $('body').delegate('#uploadPortait','click',function(){
//                    $(this).append('<div></div>')
//                })

                res.departName = res.departName || '';
                layer.open({
                    type: 1,
                    title: ['<spring:message code="jes.WebContent.res.js.app.main.grxxxgjm"></spring:message>'/* '个人信息修改界面' */],
                    skin: 'layui-layer-rim',
                    area: ['643px', '650px'],
                    closeBtn: 1,
                    content: '<div style="width:598px"> ' +
                    '    <form class="well form-horizontal" style="margin:0" method="post" id="contact_form"> ' +
                    '        <fieldset> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.yhtx"></spring:message>'/* 用户头像 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                   <div id="portaitSelected" class="portaitSelected"><i class="fa fa-camera"></i><img src="' + currentPortrait + '" /></div>' +
                    '                   <div id="portaitShow" class="portaitShow"><div>系统头像</div><div class="clearfix" style="padding:0" id="portaitWrap"></div><div id="uploadPortait">自定义头像...</div></div>' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.yhywm"></spring:message>'/* 用户英文名 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> ' +
                    '                        <input name="userEname" value="' + returnValue(user.userEname) + '" class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.yhzwm"></spring:message>'/* 用户中文名 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> ' +
                    '                        <input name="userCname" action="" value="' + returnValue(user.userCname) + '" class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.bmmc"></spring:message>'/* 部门名称 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-list-alt"></i></span> ' +
                    '                        <input name="departName" action="" value="' + returnValue(res.departName) + '"disabled class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.yhssjg"></spring:message>'/* 用户所属机构 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-list-alt"></i></span> ' +
                    '                        <input name="instName" disabled action="" value=' + returnValue(res.instName) + ' class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.zjdh"></spring:message>'/* 座机电话 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-phone-alt"></i></span> ' +
                    '                        <input name="tel" action="" value="' + returnValue(user.tel) + '" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.gsw"></spring:message>'/* 格式为XXXX-XXXXXXX */ + '" class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.sjh"></spring:message>'/* 手机号 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span> ' +
                    '                        <input name="mobile" action="" value="' + returnValue(user.mobile) + '" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.srsjh"></spring:message>'/* 输入手机号 */ + '"class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">E-Mail</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span> ' +
                    '                        <input name="email" action="" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.sryx"></spring:message>'/* 输入邮箱 */ + '" value="' + returnValue(user.email) + '" class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.dizhi"></spring:message>'/* 地址 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span> ' +
                    '                        <input name="address" action="" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.srdz"></spring:message>'/* 输入地址 */ + '" value="' + returnValue(user.address) + '" class="form-control" type="text"> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.miaoshu"></spring:message>'/* 描述 */ + '</label> ' +
                    '                <div class="col-md-6 inputGroupContainer"> ' +
                    '                    <div class="input-group"> ' +
                    '                        <span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span> ' +
                    '                        <textarea class="form-control" action="" value="' + returnValue(user.description) + '" name="description" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.srgrms"></spring:message>'/* 输入个人描述 */ + '"></textarea> ' +
                    '                    </div> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '            <!-- Button --> ' +
                    '            <div class="form-group"> ' +
                    '                <label class="col-md-4 control-label"></label> ' +
                    '                <div class="col-md-3"> ' +
                    '                    <button type="submit" id="msgSend"  style="width:120px" class="btn btn-primary">' + '<spring:message code="jes.WebContent.res.js.app.main.ti"></spring:message>'/* 提 */ + '&nbsp;&nbsp;&nbsp;' + '<spring:message code="jes.WebContent.res.js.app.main.jiao"></spring:message>'/* 交 */ + '&nbsp;&nbsp;<span class="glyphicon glyphicon-send"></span> ' +
                    '                    </button> ' +
                    '                </div> ' +
                    '            </div> ' +
                    '        </fieldset> ' +
                    '    </form> ' +
                    '</div>'
                });
                $('#contact_form').bootstrapValidator({
                    message: 'This value is not valid',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    submitButtons: $('#msgSend'),
                    submitHandler: function (validator, form, submitButton) {
                        var data = form.serialize(),
                            portaitData = 'userPortait=' + $('#portaitSelected').children('img').eq(0).attr('src');
                        data = portaitData + '&' + data;
                        $.post('modifyUserDo.ajax?f=BSYS.main.modifyUserDo', data, function (data, status) {
                            if (status === 'success') {
                                jesAlert('<spring:message code="jes.WebContent.res.js.app.main.xgcg"></spring:message>'/* '修改成功！' */);
                                $('.nav-user-photo').eq(0).attr('src', $('#portaitSelected').children('img').eq(0).attr('src'))
                            } else {
                                Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.xgsb"></spring:message>'/* '修改失败！' */);
                            }
                            setTimeout(function () {
                                layer.closeAll('page');
                            }, 0)
                        });

                    },
                    fields: {
                        userEname: {
                            validators: {
                                notEmpty: {
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.yhmbnwk"></spring:message>'/* '用户名不能为空' */
                                },
                                stringLength: {
                                    max: 20,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.yhmcdbxxy1"></spring:message>'/* '用户名长度必须小于20位' */
                                },
                                regexp: {
                                    regexp: /^\w+$/,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.ywyhmbnhyhz"></spring:message>'/* '英文用户名不能含有汉字' */
                                }
                            }
                        },
                        userCname: {
                            validators: {
                                notEmpty: {
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.yhmbnwk"></spring:message>'/* '用户名不能为空' */
                                },
                                stringLength: {
                                    max: 40,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.yhmcdbxxy2"></spring:message>'/* '用户名长度必须小于40位' */
                                },
                                regexp: {
                                    regexp: /^[-_\u4E00-\u9FA5a-zA-Z0-9]+$/,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.qsrzw"></spring:message>'/* '请输入中文' */
                                }
                            }
                        },
                        tel: {
                            validators: {
                                regexp: {
                                    regexp: /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.gsw"></spring:message>'/* '格式为 XXXX-XXXXXXX' */
                                }
                            }
                        },
                        mobile: {
                            validators: {
                                notEmpty: {
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.dhhmbnwk"></spring:message>'/* '电话号码不能为空' */
                                },
                                regexp: {
                                    regexp: /^(1)\d{10}$/,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.qsrzqddhhm"></spring:message>'/* '请输入正确的电话号码' */
                                }
                            }
                        },
                        email: {
                            validators: {
                                notEmpty: {
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.yxbnwk"></spring:message>'/* '邮箱不能为空' */
                                },
                                regexp: {
                                    regexp: /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
                                    message: '<spring:message code="jes.WebContent.res.js.app.main.qsrzqdyxdz"></spring:message>'/* '请输入正确的邮箱地址' */
                                }
                            }
                        }
                    }
                });


            }
        })
    }

    function modifyUser() {
        Ext.Ajax.request({
            url: 'modifyUser.ajax?f=BSYS.modifyUser',
            success: function (response) {
                var text = Ext.decode(response.responseText);
                var user = eval("(" + text.user + ")");
                Ext.create('Ext.window.Window', {
                    width: 640,
                    height: 280,
                    modal: true,
                    resizable: false,
                    title: '<spring:message code="jes.WebContent.res.js.app.main.grxxxgjm"></spring:message>'/* '个人信息修改界面' */,
                    items: [{
                        xtype: 'form',
                        layout: 'column',
                        name: 'form',
                        autoScroll: true,
                        border: false,
                        defaults: {
                            padding: '5',
                            labelAlign: 'right',
                            labelWidth: 100,
                            columnWidth: .45
                        },
                        items: [{
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.yhywm"></spring:message>'/* '用户英文名' */,
                            name: 'userEname',
                            value: user.userEname,
                            maxLength: 20,
                            allowBlank: false,
                            validator: function () {
                                var value = this.getValue();
                                var reg = /^\w+$/;
                                if (reg.test(value)) {
                                    return true;
                                } else {
                                    return '<spring:message code="jes.WebContent.res.js.app.main.bnhyhz"></spring:message>'/* "不能含有汉字！" */;
                                }
                            }
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.yhzwm"></spring:message>'/* '用户中文名' */,
                            name: 'userCname',
                            value: user.userCname,
                            allowBlank: false,
                            maxLength: 40,
                            validator: function () {
                                var value = this.getValue();
                                //				var reg = /^[\u4E00-\u9FA5]+$/;
                                var reg = /^[-_\u4E00-\u9FA5a-zA-Z0-9]+$/;
                                if (value) {
                                    if (reg.test(value)) {
                                        return true;
                                    } else {
                                        return '<spring:message code="jes.WebContent.res.js.app.main.qsrzw"></spring:message>'/* "请输入中文！" */;
                                    }
                                } else {
                                    return true;
                                }
                            }
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.bmmc"></spring:message>'/* '部门名称' */,
                            name: 'departName',
                            value: text.departName,
                            readOnly: true,
                            maxLength: 40
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.yhssjg"></spring:message>'/* '用户所属机构' */,
                            name: 'instName',
                            value: text.instName,
                            readOnly: true
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.zjdh"></spring:message>'/* '座机电话' */,
                            name: 'tel',
                            value: user.tel,
                            regexText: '<spring:message code="jes.WebContent.res.js.app.main.gsw"></spring:message>'/* '格式为 XXXX-XXXXXXX' */,
                            editable: true,
                            regex: /^(0(10|2[1-3]|[3-9]\d{2}))?[1-9]\d{6,7}$/
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.sjh"></spring:message>'/* '手机号' */,
                            name: 'mobile',
                            value: user.mobile,
                            regexText: '<spring:message code="jes.WebContent.res.js.app.main.qsrzqddhhm"></spring:message>'/* '请输入正确的电话号码' */,
                            regex: /^(1)\d{10}$/
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.youxiang"></spring:message>'/* '邮箱' */,
                            name: 'email',
                            value: user.email,
                            regex: /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
                            regexText: '<spring:message code="jes.WebContent.res.js.app.main.qsrzqdyxdz"></spring:message>'/* '请输入正确的邮箱地址' */
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.dizhi"></spring:message>'/* '地址' */,
                            name: 'address',
                            value: user.address,
                            maxLength: 120,
                            columnWidth: .9
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.miaoshu"></spring:message>'/* '描述' */,
                            name: 'description',
                            value: user.description,
                            columnWidth: .9
                        }],
                        buttons: [{
                            text: '<spring:message code="jes.WebContent.res.js.app.main.tijiao"></spring:message>'/* '提交' */,
                            handler: function () {
                                var form = this.up('form').getForm();
                                var win = this.up('window');
                                if (form.isValid()) {
                                    form.submit({
                                        url: 'modifyUserDo.ajax?f=BSYS.main.modifyUserDo',
                                        success: function (form, action) {
                                            jesAlert('<spring:message code="jes.WebContent.res.js.app.main.xgcg"></spring:message>'/* '修改成功！' */);
                                            win.close();
                                        },
                                        failure: function (form, action) {
                                            Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.xgsb"></spring:message>'/* '修改失败！' */);
                                            win.close();
                                        }
                                    });
                                }
                            }
                        }]
                    }]
                }).show();
            }
        });
    }

    function showMoreMyMsg() {
        var obj = {
            id: 'moreMyMsg',
            ssid: 'BSYS',
            ssurl: 'messageListHistory.do?f=BSYS.main.messageListHistory',
            text: '<spring:message code="jes.WebContent.res.js.app.main.dhlsxx"></spring:message>'/* '对话历史信息' */
        };
        trigger.init(obj)
    }


    $(function () {
        $('#sidebar>.nav.nav-list').delegate('li>ul>li', 'click', function () {
            $('#sidebar>.nav.nav-list li>ul>li').each(function (index, item) {
                $(item).removeClass('active')
                $(item).parent().parent().removeClass('opened-${theme}')
            });
            $(this).addClass('active');
            $(this).parent().parent().addClass('opened-${theme}');
            if ($(this).data('ssurl')) {
                var obj = {};
                obj.id = $(this).attr('data-id');
                obj.ssid = $(this).attr('data-ssid');
                obj.ssurl = $(this).attr('data-ssurl');
                obj.menuurl = $(this).attr('data-menuurl');
                obj.leaf = $(this).attr('data-leaf');
                obj.text = $(this).find('a').html().split('\/i\>')[1];
                obj.sysName = $('#systemName').find('a').eq(0).text();
                obj.ssIcon = $(this).parent().parent().attr('data-ssIcon');
                trigger.init(obj)
            } else {
                var id = $(this).attr('data-id');
                if (id == "init_1") {
//                        Ext.create('Sys.app.PassWin').show();
                    layer.open({
                        type: 1,
                        title: ['<spring:message code="jes.WebContent.res.js.app.main.xgmm"></spring:message>'/* '修改密码' */],
                        closeBtn: 1,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['632px', '318px'], //宽高
                        content: '<div style="width: 600px"> ' +
                        '    <form class="well form-horizontal" style="margin: 0;" action=" " id="contact_form"> ' +
                        '        <fieldset> ' +
                        '            <div class="form-group"> ' +
                        '                <label for="oldPassword" class="col-md-3 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.yuanmm"></spring:message>'/* 原密码 */ + '</label> ' +
                        '                <div class="col-md-7 inputGroupContainer"> ' +
                        '                    <div class="input-group"> ' +
                        '                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> ' +
                        '                        <input type="password" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.qsrymm1"></spring:message>'/* 请输入原密码 */ + '" class="form-control" id="oldPassword"> ' +
                        '                    </div> ' +
                        '                </div> ' +
                        '            </div> ' +
                        '            <div class="form-group"> ' +
                        '                <label for="newPassword"  class="col-md-3 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.xinmm"></spring:message>'/* 新密码 */ + '</label> ' +
                        '                <div class="col-md-7 inputGroupContainer"> ' +
                        '                    <div class="input-group"> ' +
                        '                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> ' +
                        '                        <input type="password" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.jyszzmfh"></spring:message>'/* 建议数字字母符号两种及以上的组合 */ + '" class="form-control" id="newPassword"> ' +
                        '                    </div> ' +
                        '                </div> ' +
                        '            </div> ' +
                        '            <div class="form-group"> ' +
                        '                <label class="col-md-3 control-label">' + '<spring:message code="jes.WebContent.res.js.app.main.qrmm"></spring:message>'/* 确认密码 */ + '</label> ' +
                        '                <div class="col-md-7 inputGroupContainer"> ' +
                        '                    <div class="input-group"> ' +
                        '                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> ' +
                        '                        <input type="password" placeholder="' + '<spring:message code="jes.WebContent.res.js.app.main.qzcsrmm"></spring:message>'/* 请再次输入密码 */ + '" class="form-control" id="confirmPassword"> ' +
                        '                    </div> ' +
                        '                </div> ' +
                        '            </div> ' +
                        '            <div class="form-group"> ' +
                        '                <label class="col-md-5 control-label"></label> ' +
                        '                <div class="col-md-5"> ' +
                        '                    <a  style="width:120px" id="psdSend" class="btn btn-primary">' + '<spring:message code="jes.WebContent.res.js.app.main.ti"></spring:message>'/* 提 */ + '&nbsp;&nbsp;&nbsp;' + '<spring:message code="jes.WebContent.res.js.app.main.jiao"></spring:message>'/* 交 */ + '&nbsp;&nbsp;<span class="glyphicon glyphicon-send"></span></a> ' +
                        '                </div> ' +
                        '            </div> ' +
                        '        </fieldset> ' +
                        '    </form> ' +
                        '</div>'
                    });
                } else if (id == "init_2") {
//                        modifyUser()
                    modifyUser1();

                }

            }
        });

        $('body').delegate('#psdSend', 'click', function () {
            var oldPasswordValue = $('#oldPassword').val(),
                newPasswordValue = $('#newPassword').val(),
                confirmPasswordValue = $('#confirmPassword').val();
            if (!oldPasswordValue) {
                Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.tishi"></spring:message>'/* '提示' */, '<spring:message code="jes.WebContent.res.js.app.main.qsrymm2"></spring:message>'/* "请输入原密码!" */);
                return;
            }
            if (!newPasswordValue) {
                Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.tishi"></spring:message>'/* '提示' */, '<spring:message code="jes.WebContent.res.js.app.main.qsrxmm"></spring:message>'/* "请输入新密码!" */);
                return;
            }
            if (!confirmPasswordValue) {
                Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.tishi"></spring:message>'/* '提示' */, '<spring:message code="jes.WebContent.res.js.app.main.qcfsrmm"></spring:message>'/* "请重复输入密码!" */);
                return;
            }
            if (newPasswordValue != confirmPasswordValue) {
                Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.tishi"></spring:message>'/* '提示' */, '<spring:message code="jes.WebContent.res.js.app.main.xszdmmsrbyz"></spring:message>'/* "新设置的密码输入不一致!" */);
                return;
            }
            $.post('changePwd.do', {
                oldPwd: oldPasswordValue,
                newPwd: newPasswordValue
            }, function (data) {
                var resp = Ext.decode(data);
                if(resp.success == true){
                    jesAlert('<spring:message code="jes.WebContent.res.js.app.main.xgmmcg"></spring:message>'/* '修改密码成功...' */);
                    setTimeout(function () {
                        layer.closeAll('page');
                    }, 0)
                }else{
                    var msg = resp.msg;
                    Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.tishi"></spring:message>',msg);
                }
            })
        });


        $('#index-tabs').on('click', function (e) {
            e = e || window.event;
            var tagObj = {
                change: function (flag) {
                    flag = flag || false;
                    var self = flag ? $(e.target).parent() : $(e.target),
                        str = $(self).attr('tabId');
                    if ($(self).hasClass('moreTag')) return;
                    if (document.getElementById(str)) trigger.changeContent(str);
                    trigger.addActive(self);
                    trigger.changeSideMenu(str, self)
                },
                i: function () {
                    this.change(true)
                },
                span: function () {
                    this.change(true);
                },
                b: function () {
                	trigger.closeTab($(e.target).parent())
                },
                div: function () {
                    $(e.target).attr('id') !== 'index-tabs' ? this.change() : function () {
                        return
                    };
                },
                p: function () {
                    return false
                }, ul: function () {
                    return false
                }
            }
            tagObj[e.target.tagName.toLowerCase()]()
        });

        $(window).resize(function () {
            if ($('.tab-box').length) trigger.reflowTabBox()
        });

        $('#index').on('click', getMyFavorite);

        $('.ss-menu').on('click', function () {
            var me = $(this);
            var ssId = me.attr('ssId');
            if (Ext.isEmpty(ssId)) {
                return;
            }
            $.getJSON('ssmenu.ajax', {outerUrl: me.attr('outerUrl'), ssId: ssId}, function (data) {
                for (var i = 0; i < data.length; i++) {
                    for (var j = 0; j < data[i].children.length; j++) {
                        data[i].children[j].id = ssId + '#' + data[i].children[j].id
                    }
                }
                outerUrlCache[ssId] = me.attr('outerUrl')
                var text = $(me).children('span').html(),
                    icon = $(me).children('i').attr('class')
                data.push(text);
                __dropdown.draw(data, icon);
                __dropdown.contextmenuChange(function (targetObj) {
                    
                });
                if(Ext.isEmpty(me.attr('jumpFlag'))){
                	 trigger.changeContent && trigger.changeContent("indexContent");
                }else{
	       			 me.removeAttr('jumpFlag');
                }
            });
        });

        (function setHello() {
            var text = '';
            var h = new Date().getHours();
            if (h >= 0 && h < 6) {
                text = '<spring:message code="jes.WebContent.res.js.app.main.xkl"></spring:message>'/* '辛苦了' */;
            } else if (h >= 6 && h < 9) {
                text = '<spring:message code="jes.WebContent.res.js.app.main.zsh"></spring:message>'/* '早上好' */;
            } else if (h < 11) {
                text = '<spring:message code="jes.WebContent.res.js.app.main.swh"></spring:message>'/* '上午好' */;
            } else if (h >= 11 && h < 13) {
                text = '<spring:message code="jes.WebContent.res.js.app.main.zwh"></spring:message>'/* '中午好' */;
            } else if (h >= 13 && h < 18) {
                text = '<spring:message code="jes.WebContent.res.js.app.main.xwh"></spring:message>'/* '下午好' */;
            } else {
                text = '<spring:message code="jes.WebContent.res.js.app.main.wsh"></spring:message>'/* '晚上好' */;
            }
            $('#hello').text(text);
        })()

        $('#logout').on('click', function () {
            Ext.create('Ext.ux.window.Notification', {
                html: '<spring:message code="jes.WebContent.res.js.app.main.zxdlz"></spring:message>'/* '注销登录中...' */
            }).show();
            try {
                new Ext.util.DelayedTask(function () {
                    window.location = 'exit.do';
                }).delay(1000);
            } catch (e) {
                //非IE未必支持
            }
        });

    });


    Ext.onReady(function () {
        if ('no' == '${activation}') {
            Ext.create('Ext.window.Window', {
                width: 800,
                height: 150,
                modal: true,
                closable: false,
                title: '<spring:message code="jes.WebContent.res.js.app.main.ndsyb"></spring:message>'/* '您的试用版已到期，请输入licence激活' */,
                items: [{
                    xtype: 'textarea',
                    name: 'lisenceNum',
                    fieldLabel: '<spring:message code="jes.WebContent.res.js.app.main.qsrjhm"></spring:message>'/* '请输入激活码' */,
                    width: 700,
                    padding: 10
                }],
                buttons: [{
                    text: '<spring:message code="jes.WebContent.res.js.app.main.tijiao"></spring:message>'/* '提交' */,
                    inputType: 'submit',
                    handler: function (me) {
                        Ext.Ajax.request({
                            url: 'updateLisence.ajax?f=BSYS.0101',
                            params: {
                                lisenceNum: me.up('window').down('textfield[name=lisenceNum]').getValue()
                            },
                            success: function (response) {
                                var text = Ext.decode(response.responseText);
                                if (text == 'true') {
                                    jesAlert('<spring:message code="jes.WebContent.res.js.app.main.jhcg"></spring:message>'/* '激活成功！' */);
                                    me.up('window').close();
                                    history.go(0);
                                } else {
                                    Ext.Msg.alert('<spring:message code="jes.WebContent.res.js.app.main.tishi"></spring:message>'/* '提示' */, '<spring:message code="jes.WebContent.res.js.app.main.jhmygq"></spring:message>'/* '激活码已过期，请重新输入或联系管理员！' */);
                                }
                            }
                        });
                    }
                }]
            }).show();
        }

        /* 准备增加密码修改后初次登陆，以及密码即将过期的修改密码提醒功能。*/
        if (!isThird) {
            var isFirstLogin = '${isFirstLogin}';
            var passwordInited = '${passwordInited}';
            var passwordExpire = ${passwordExpire };
            var pwdExpireDays = ${pwdExpireDays };
            if (isFirstLogin == "Y" || passwordInited == "Y" || (passwordExpire != 0 && pwdExpireDays >= 0)) {
                if (isFirstLogin == "Y") {
                    jesAlert('<spring:message code="jes.WebContent.res.js.app.main.ndycdr"></spring:message>'/* '您第一次登入本系统，请重新设置密码.' */);
                } else if (passwordInited == "Y") {
                    jesAlert('<spring:message code="jes.WebContent.res.js.app.main.ndymmybglycz"></spring:message>'/* '您的密码已被管理员重置，请重新设置密码.' */);
                } else if (pwdExpireDays >= 0) {
                    jesAlert('<spring:message code="jes.WebContent.res.js.app.main.nycg"></spring:message>'/* '您有超过' */ + passwordExpire + '<spring:message code="jes.WebContent.res.js.app.main.twxgmm"></spring:message>'/* '天未修改密码，请重新设置密码.' */);
                }
                var w = new Sys.app.PassWin();
                w.closable = false;
                w.show();
            } else {
                var lid = '${lastIpAndDate}'.split('_');
                jesAlert('<spring:message code="jes.WebContent.res.js.app.main.nscdr"></spring:message>'/* "您上次登入IP:" */ + lid[1] + "<BR>" + '<spring:message code="jes.WebContent.res.js.app.main.drsj"></spring:message>'/* 登入时间: */ + lid[0] + "<BR>" + '<spring:message code="jes.WebContent.res.js.app.main.mmyxq"></spring:message>'/* 密码有效期还剩 */ + ":<B style='color:red;'>" + (-pwdExpireDays) + "</B>" + '<spring:message code="jes.WebContent.res.js.app.main.tian"></spring:message>'/* 天 */, 3000, 'br', 200, 120);
            }
        }


        $.getJSON('getUserUnreadMessages.ajax', function (map) {
            var data = map.data;
            var count = map.count;
            var tp = new Ext.XTemplate(
                '<a data-toggle="dropdown" class="dropdown-toggle" href="#">',
                '<i class="fa fa-envelope" style="font-size:18px"></i>',
                '<tpl if="[values.length] &gt; 0">',
                '<span id="my-msg-num" style="display: block">'+count+'</span>',
                '</tpl>',
                '</a>',
                '<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close my-msg-body">',
                '<li class="dropdown-header">',
                '<i class="fa fa-envelope-alt"></i>',
                '<spring:message code="jes.WebContent.res.js.app.main.srdh"></spring:message>'/* 私人对话 */ + '[<span>'+count+'</span>]',
                '</li>',
                '<tpl for=".">',
                '<li>',
                '<a href="javascript:void(0);">',
                '<img src="${app}/res/db/ace/images/user.png" class="msg-photo" alt="">',
                '<span class="msg-body">',
                '<span class="msg-title">',
                '<span class="blue">{fromUser}:</span>',
                '{msgBody}',
                '</span>',
                '<span class="msg-time">',
                '<i class="fa fa-time"></i>',
                '<span>{sendTime}</span>',
                '</span>',
                '</span>',
                '</a>',
                '</li>',
                '</tpl>',
                '<li>',
                '<a href="javascript:void(0);" onclick="showMoreMyMsg();">',
                '<spring:message code="jes.WebContent.res.js.app.main.ckls"></spring:message>'/* 查看历史 */,
                '<i class="fa fa-arrow-right"></i>',
                '</a>',
                '</li>',
                '</ul>'
            );
            tp.overwrite("my-msg", data);
        })
    });
    
    
    
    Ext.onReady(function(){
        Ext.util.TaskManager.start({
            run: function (runCount) {
                window.top.document.jesRunDuration+=2;
                if(runCount>1 && (runCount-1)%15==0){
			     	jesAlert('<spring:message code="jes.WebContent.res.js.app.main.lxgz"></spring:message>'/*'您已连续工作['*/+2*(runCount-1)+
	     			 '<spring:message code="jes.WebContent.res.js.app.main.qzyxx"></spring:message>'/*']分钟,请注意休息.'*/);
                }
                if(window.top.document.jesRunDuration>=sysJesRunDuration){
                    window.location = 'exit.do';
                    alert( '<spring:message code="jes.WebContent.res.js.app.main.yywdl"></spring:message>'/* "由于您[" */+sysJesRunDuration+
                    		'<spring:message code="jes.WebContent.res.js.app.main.fzwdlbxt"></spring:message>'/* "]分钟没有使用本系统，出于安全原因，系统将自动注销您的本次登录。" */);	
                }
            },
            interval: 1000*60*2
        });
        
        var jumpSsId="${jumpSsId}";
        var jumpUrl="${jumpUrl}";
        var jumpText="${jumpText}";
        
        if(!Ext.isEmpty(jumpSsId))	{
        	Ext.Function.defer(function(){
        		jesAlert( $('#hello').text());
	        	if(jumpSsId != 'home'){
	        		try{
	        			 var ss=$('.ss-menu').filter('[ssid="'+jumpSsId+'"]').first();
	        			 ss.attr('jumpFlag','true');
	        			 ss.trigger("click");
	        		}catch(e){}
	        	}
	        	try{
	        		 var ss=$('.ss-menu').filter('[ssid="'+jumpSsId+'"]').first();
	        		 var obj = {};
                     obj.id = jumpSsId+'#jumpFunction';
                     obj.ssid = jumpSsId;
                     obj.ssurl = jumpUrl;
                     obj.text = jumpText;
                     obj.sysName = ss.text();
                     obj.ssIcon = ss.find('i').attr('class');
                     trigger.init(obj)
	        	}catch(e){}
	        	 
        	}, 100);
        }else{
        	getMyFavorite();
        }
    });

</script>
<%
	if(!"0".equals(jes.pub.runtime.JesConfig.getConfigValue("SESSION_OFFLINE_TIMEOUT","0"))){
%>
		<SCRIPT TYPE="text/javascript">
				Ext.util.TaskManager.start({
				     run: function (runCount) {
						 Ext.Ajax.request({
						    url: 'sessionKeeper.ajax',
							success: function(response) {
								console.log(response.responseText);
							}
						});
				 	},
			     interval: 1000*60*1
				});
		</SCRIPT>
<%		
	}
%>

</body>
<iframe width="0" height="0" frameborder="0" id="download"></iframe>

</html>