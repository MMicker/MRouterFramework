//
//  MRouterInfo+Router.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterInfo+Router.h"
#import "MRouterLink.h"
#import "MRouterMatcher.h"
#import "IURLResolver.h"
#import "MRouterLink+UserInfo.h"
#import <objc/runtime.h>

static char objc_default_router;

@implementation MRouterInfo (Router)

- (MRouterLink *) handleURL:(NSURL *) url userInfo:(id) userInfo direct:(BOOL) direct{
    __block MRouterLink *link = nil;
    if (direct) {
        link  = [[MRouterLink alloc] initWithURL:url];
    } else {
        [self.regexUrls enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MRouterMatcher *matcher = [MRouterMatcher matcherWithRoute:obj];
            link = [matcher deepLinkWithURL:url];
            if (link) {
                *stop = YES;
            }
        }];
    }
    
    if (link) {
        link.userInfo = userInfo;
        if (self.block) {
            self.block(self, link);
        } else {
            id<IURLResolver> handleInstance = [[self.handleCls alloc] init];
            [handleInstance handleRouter:self link:link];
        }
    }
    return link;
}

- (BOOL) isDefault {
    NSNumber *number = objc_getAssociatedObject(self, &objc_default_router);
    return [number boolValue];
}

- (void) setDefaultRouter:(BOOL)defaultRouter {
    objc_setAssociatedObject(self, &objc_default_router, @(defaultRouter), OBJC_ASSOCIATION_RETAIN);
}
@end
