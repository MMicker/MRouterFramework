//
//  MRouterInfo+Refine.h
//  MRouterFramework
//
//  Created by Micker on 2017/3/13.
//  Copyright © 2017年 Micker. All rights reserved.
//

#import "MRouterInfo.h"


@protocol MRouterInfoProtocol <NSObject>

- (void) refine:(MRouterInfo *) routerInfo;

@end

@interface MRouterInfo (Refine)<MRouterInfoProtocol>


@end


/**
 对路由信息进行再加工，如根据当前环境变化，生成不同路由对象

 @param item 实现了MRouterInfoProtocol的对象，全局持有
 */
FOUNDATION_EXPORT void  registerRouterInfoProtocol(id<MRouterInfoProtocol> item);

