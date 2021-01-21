//
//  MRouterIntercept.m
//  MRouterFramework
//
//  Created by Micker on 2021/1/21.
//  Copyright © 2021 Micker. All rights reserved.
//

#import "MRouterIntercept.h"


static id<MRouterInterceptProtocol> __gRouterInterceptProtocol ;

void  registerRouterInterceptProtocol(id<MRouterInterceptProtocol> item) {
    if (item && [item respondsToSelector:@selector(interceptRouter:link:continueBlock:)]) {
        __gRouterInterceptProtocol = item;
    }
}

id<MRouterInterceptProtocol> gRouterInterceptItem(void) {
    return __gRouterInterceptProtocol;
}
