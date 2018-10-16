//
//  UIViewController+RouterLink.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "UIViewController+RouterLink.h"
#import <objc/runtime.h>


@implementation UIViewController (RouterLink)

- (void) handleRouterLink:(MRouterLink *) link {
    
}

@end

@implementation UIViewController (MatchedURL)
@dynamic matchedURL;

- (void) setMatchedURL:(NSString *)matchedURL {
    objc_setAssociatedObject(self, @selector(matchedURL), matchedURL, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *) matchedURL {
    return objc_getAssociatedObject(self, _cmd);
}

@end
