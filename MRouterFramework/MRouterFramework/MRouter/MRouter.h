//
//  MRouter.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MRouterInfo;
@class UIViewController;

typedef NSURL * (^handleURLBlock)(NSURL *originURL);

@interface MRouter : NSObject
@property (nonatomic, copy) handleURLBlock routerHandler;

+ (instancetype) sharedRouter;

/**
 *  启动注册
 *  备注：此处会通过反射调用URLRouterService的Category中的，以registerRouter_开头的方法；
 *       可以通过编写对应的Category来进行加载
 *
 *  @return self
 */
- (id) start ;

/**
 *  开启调试模式，会打印相关日志信息
 *
 *  @return self
 */
- (id) enableDebug;

/**
 *  向Service注入URLRouter
 *
 *  @param info
 */
- (void) registerURLRouter:(MRouterInfo *) info;

/**
 *  注册符合如下规则的数据
 *
 *  @parameters
 *
 ****************************************************************
 *  备注：
 *  配置文件为一层结构，为object_list
 *  1）object_list[{name, index, class, resolver, exact_url}]
 *  2）class对应的VC名称；如果name以#开头，则会使用默认的处理方式，进行处理；
 *  3）resolver对应的规则类名称；
 *  4）exact_url字段，支持字符串、数据两种数据类型；
 *  5）index字段，值越大，越靠前，默认值为100；若值相同，则根据添加顺序决定
 ****************************************************************/
- (void) registerURLRouters:(NSDictionary *) resolvers;

/**
 *  反注册某个处理类
 *
 *  @param name
 */
- (void) unRegisterURLRouter:(NSString *) name;

/**
 *  反注册某个URLs
 *
 *  @param url
 */
- (void) unRegisterURLs:(NSArray *) urls;

/**
 *  查看某个已经注册的类
 *
 *  @param name 名称
 *
 *  @return 对应的值
 */
- (MRouterInfo *) resolverInfoWithName:(NSString *) name;

/**
 *  处理回调信息
 *
 *  @param url        待处理的URL
 *  @param userInfo   用户信息传递
 *  @param flag       是否使用默认路由进行处理, 默认为YES
 *  @param controller 调用者
 *
 *  @return 是否能够正常处理
 */
- (BOOL) handleURL:(NSURL *) url userInfo:(id) userInfo;
- (BOOL) handleURL:(NSURL *) url userInfo:(id) userInfo useDefault:(BOOL) flag;

//- (BOOL) handleURL:(NSURL *) url;

@end
