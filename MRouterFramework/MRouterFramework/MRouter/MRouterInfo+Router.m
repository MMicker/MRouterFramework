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
#import "MRouterIntercept.h"

#import <objc/runtime.h>

static char objc_default_router;

@interface MRouterInfo(MATCHER)
@property (nonatomic, strong) NSMutableDictionary *matcherDictionary;
@end

@implementation MRouterInfo(MATCHER)

- (void) setMatcherDictionary:(NSMutableDictionary *)matcherDictionary {
    objc_setAssociatedObject(self, @selector(matcherDictionary), matcherDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *) matcherDictionary {
    NSMutableDictionary *data = objc_getAssociatedObject(self, _cmd);
    if (!data) {
        data = [NSMutableDictionary dictionaryWithCapacity:10];
        self.matcherDictionary = data;
    }
    return data;
}

- (MRouterMatcher *) mathcerForUrl:(NSString *) url {
    return [self.matcherDictionary valueForKey:url];
}

@end

@implementation MRouterInfo (Router)

- (MRouterLink *) handleURL:(NSURL *) url userInfo:(id) userInfo direct:(BOOL) direct{
    __block MRouterLink *link = nil;
    if (direct) {
        link  = [[MRouterLink alloc] initWithURL:url];
    } else {
        __weak __typeof__(self) weakSelf = self;
        [self.regexUrls enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MRouterMatcher *matcher = [weakSelf.matcherDictionary valueForKey:obj];
            if (!matcher) {
                matcher = [MRouterMatcher matcherWithRoute:obj];
                [weakSelf.matcherDictionary setValue:matcher forKey:obj];
            }
            link = [matcher deepLinkWithURL:url];
            if (link) {
                *stop = YES;
            }
        }];
    }
    
    if (link) {
        link.matchedURL = [url absoluteString];
        link.userInfo = userInfo;
        
        id<MRouterInterceptProtocol> intercept = gRouterInterceptItem();
        if (intercept) {
            [intercept interceptRouterInfo:self link:link continueBlock:^(void) {
                [self __handleRouterLink:link];
            }];
        } else {
            [self __handleRouterLink:link];
        }
    }
    return link;
}

- (void) __handleRouterLink:(MRouterLink *) link {
    if (self.block) {
        self.block(self, link);
    } else {
        id<IURLResolver> handleInstance = [[self.handleCls alloc] init];
        [handleInstance handleRouter:self link:link];
    }
}

- (BOOL) isDefault {
    NSNumber *number = objc_getAssociatedObject(self, &objc_default_router);
    return [number boolValue];
}

- (void) setDefaultRouter:(BOOL)defaultRouter {
    objc_setAssociatedObject(self, &objc_default_router, @(defaultRouter), OBJC_ASSOCIATION_RETAIN);
}
@end
