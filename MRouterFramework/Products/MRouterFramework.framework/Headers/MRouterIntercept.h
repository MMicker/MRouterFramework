//
//  MRouterIntercept.h
//  MRouterFramework
//
//  Created by Micker on 2021/1/21.
//  Copyright © 2021 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRouterInfo, MRouterLink;

@protocol MRouterInterceptProtocol <NSObject>
@required

/// 在匹配上路由之后，对需要特殊拦截的路由进行拦截
/// @param routerInfo 匹配上的路由信息
/// @param link 路由
/// @param continueBlock 是否需要继续进行此路由，若继续，则需要手动调用
- (void) interceptRouterInfo:(MRouterInfo *) routerInfo link:(MRouterLink *) link continueBlock:(void (^)(void)) continueBlock;

@optional

- (void) beforeRouter:(MRouterInfo *) routerInfo link:(MRouterLink *) link;

- (void) afterRouter:(MRouterInfo *) routerInfo  link:(MRouterLink *) link;

@end


FOUNDATION_EXPORT void  registerRouterInterceptProtocol(id<MRouterInterceptProtocol> item);

FOUNDATION_EXPORT id<MRouterInterceptProtocol> gRouterInterceptItem(void);

