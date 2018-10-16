# MRouterFramework
iOS路由，不仅仅是实现页面的跳转！


#前言
*   [MRouterFramework](https://github.com/MMicker/MRouterFramework),实现但不限于URL进行页面之间的跳转；

##简介
* 1、此包提供Router的Framework；
* 2、支持通过配置文件，代码级进行URL的路由规则配置，且支持各URL的权重信息；
* 3、支持在程序内部使用过程中的传参处理；
* 4、支持自定义的跳转规则，如仅对某一类URL，不作跳转，仅做逻辑处理；


##说明
*   使用`[[MRouter sharedRouter] start];`开启注册；
*   在具体的跳转`Controller`中实现`IRouterLink`即可收到相应的预处理消息；
*   配置文件的示例如下，其中class对应的值，若以`#`开头，则表示使用默认的处理方式
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>object_list</key>
    <array>
        <dict>
            <key>class</key>
            <string>#CommodityListViewController</string>
            <key>name</key>
            <string>search_url_solver</string>
            <key>index</key>
            <integer>0</integer>
            <key>exact_url</key>
            <array>
                <string>k.m.baidu.com/s/search</string>
                <string>m.baidu.com/s/search</string>
            </array>
        </dict>
        <dict>
            <key>class</key>
            <string>#MDetailViewController</string>
            <key>name</key>
            <string>M_detail_url_solver</string>
            <key>exact_url</key>
            <array>
                <string>m.baidu.com/item.html</string>
                <string>m.baidu.com/main/rebate</string>
            </array>
        </dict>
        <dict>
            <key>ext</key>
            <dict>
                <key>modal</key>
                <false/>
                <key>animated</key>
                <true/>
            </dict>
            <key>class</key>
            <string>#MNavigatorDetailViewController</string>
            <key>name</key>
            <string>korea_detail_url_solver</string>
            <key>index</key>
            <string>101</string>
            <key>exact_url</key>
            <array>
                <string>m.baidu.com/koreaitem.html</string>
                <string>k.m.baidu.com/koreaitem.html</string>
                <string>k.m.baidu.com/main/rebate</string>
                <string>k.m.baidu.com/item.html</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
```

##ChangeLog

V0.3
---
*   添加匹配上的路由规则URL，MRouterLink、UIViewController
```

/**
 匹配上的路由
 */
@property (nonatomic, copy) NSString  *matchedURL;
```

V0.2
---
*   添加缺省的处理方式，可以通过配置文件或者代码进行注入
*   增加是否使用缺省处理方式的方法
```
- (BOOL) handleURL:(NSURL *) url userInfo:(id) userInfo;
- (BOOL) handleURL:(NSURL *) url userInfo:(id) userInfo useDefault:(BOOL) flag;
```


V0.1
---
*   首版功能的实现
*   URL的权重处理
*   URL及其相应的处理规则的自定义
*   配置文件与代码级的URL注入