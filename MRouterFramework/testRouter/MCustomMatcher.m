//
//  MCustomMatcher.m
//  testRouter
//
//  Created by Micker on 2020/10/22.
//  Copyright © 2020 Micker. All rights reserved.
//

#import "MCustomMatcher.h"

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
