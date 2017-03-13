//
//  MRouterInfo+Refine.m
//  MRouterFramework
//
//  Created by Micker on 2017/3/13.
//  Copyright © 2017年 Micker. All rights reserved.
//

#import "MRouterInfo+Refine.h"

static id<MRouterInfoProtocol> __gRouterInfoProtocol ;

@implementation MRouterInfo (Refine)


- (void) refine:(MRouterInfo *) routerInfo {
    !__gRouterInfoProtocol?:[__gRouterInfoProtocol refine:routerInfo];
}

@end


FOUNDATION_EXPORT void  registerRouterInfoProtocol(id<MRouterInfoProtocol> item) {
    if (item && [item respondsToSelector:@selector(refine:)]) {
        __gRouterInfoProtocol = item;
    }
}
