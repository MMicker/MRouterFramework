//
//  MCustomMatcher.m
//  testRouter
//
//  Created by Micker on 2020/10/22.
//  Copyright © 2020 Micker. All rights reserved.
//

#import "MCustomMatcher.h"
#import "MRouterInfo.h"
#import "MRouterLink.h"
#import "MRouter.h"

@interface MRouterMatcher(WSCN)

@end

@implementation MRouterMatcher(WSCN)

+ (void) load {
    self.matcherProtocol = [MCustomMatcher new];
}

@end

@implementation MCustomMatcher

- (NSString *) matchOriginHost:(NSString *) originHost routerHost:(NSString *) routeHost {
    static NSArray *hosts = nil;
    if(!hosts) {
        hosts = @[@"vip.jianshiapp.com",@"oia.jianshiapp.com",@"192.168.0.111"];
    }
    if ([hosts containsObject:originHost] && [routeHost isEqualToString:@"wallstreetcn.com"]) {
        return routeHost;
    }
    return originHost;
}

@end


@implementation MCustomRouterIntercept

+ (void) load {
    registerRouterInterceptProtocol([MCustomRouterIntercept new]);
}


- (void) interceptRouterInfo:(MRouterInfo *) routerInfo link:(MRouterLink *) link continueBlock:(void (^)(void)) continueBlock {
    if (routerInfo.extentions[@"needLogin"]) {
        
        [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"http://micker.cnb"] userInfo:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !continueBlock?:continueBlock();
        });
        return;
    }
    !continueBlock?:continueBlock();
}


@end
