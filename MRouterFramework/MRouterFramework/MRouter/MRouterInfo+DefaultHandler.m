//
//  MRouterInfo+DefaultHandler.m
//  MRouterFramework
//
//  Created by Micker on 16/8/8.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterInfo+DefaultHandler.h"

@implementation MRouterInfo (DefaultHandler)

- (BOOL) animated {
    if (self.extentions && [[self.extentions allKeys] containsObject:@"animated"]) {
        return [[self.extentions objectForKey:@"animated"] boolValue];;
    }
    return YES;
}

- (BOOL) modalPresent {
    if (self.extentions && [[self.extentions allKeys] containsObject:@"modal"]) {
        return [[self.extentions objectForKey:@"modal"] boolValue];;
    }
    return NO;
}

- (BOOL) singleInstance {
    if (self.extentions && [[self.extentions allKeys] containsObject:@"single"]) {
        return [[self.extentions objectForKey:@"single"] boolValue];;
    }
    return NO;
}

- (UIViewController *) targetController {
    return [[[self handlerCtrlCls] alloc] init];
}
@end
