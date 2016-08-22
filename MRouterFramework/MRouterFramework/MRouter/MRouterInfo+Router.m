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


@implementation MRouterInfo (Router)

- (MRouterLink *) handleURL:(NSURL *) url userInfo:(id) userInfo {
    __block MRouterLink *link = nil;
    [self.regexUrls enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MRouterMatcher *matcher = [MRouterMatcher matcherWithRoute:obj];
        link = [matcher deepLinkWithURL:url];
        if (link) {
            *stop = YES;
        }
    }];
    
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
@end
