//
//  MRouterLink+UserInfo.m
//  MRouterFramework
//
//  Created by Micker on 16/8/22.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterLink+UserInfo.h"
#import <objc/runtime.h>

@implementation MRouterLink (UserInfo)

- (void) setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, @selector(userInfo), userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id) userInfo {
    return objc_getAssociatedObject(self, _cmd);
}

@end
