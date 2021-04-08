//
//  MRouterDefaultHandler.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterDefaultHandler.h"
#import "MRouterInfo.h"
#import "MRouterLink.h"
#import "MRouterMatcher.h"
#import "MRouterInfo+DefaultHandler.h"
#import "UIViewController+RouterLink.h"
#import "MRouterLink+UserInfo.h"


@implementation UIApplication (NavigationController)

- (UIViewController*) rootPresentViewController {
    id<UIApplicationDelegate> appDelegate = (id<UIApplicationDelegate>)[UIApplication sharedApplication].delegate;
    return [self _topViewController:appDelegate.window.rootViewController];
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else if ([vc presentedViewController]) {
       return [self _topViewController:[vc presentedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (UINavigationController *) rootNavigationController {
    UIViewController *controller = [self rootPresentViewController];

    UINavigationController *navigation = (UINavigationController *)([controller isKindOfClass:[UINavigationController class]] ?
                                                                    controller:
                                                                    controller.navigationController);
    return navigation;
}

@end

@implementation MRouterDefaultHandler

- (UIViewController *) rootViewController:(MRouterLink *) link {
    return [[UIApplication sharedApplication] rootPresentViewController];
}

- (UINavigationController *) rootNavigationController:(MRouterLink *) link {
    return [[UIApplication sharedApplication] rootNavigationController];
}

#pragma IURLResolver

- (void) handleRouter:(MRouterInfo*) info link:(MRouterLink *) link {
    [self handleRouter:info link:link navation:nil];
}

- (void) handleRouter:(MRouterInfo*) info link:(MRouterLink *) link navation:(void(^)(UINavigationController *navigationController)) navationBlock {
    __block UIViewController *targetViewController = nil;
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjects:@[@(info.animated),@(info.modalPresent),@(info.singleInstance)]
                                                                   forKeys:@[@"animated",@"modal",@"single"]];
    
    if ([link.userInfo isKindOfClass: [NSDictionary class]]) {
        [data addEntriesFromDictionary:link.userInfo];
    }
    if (info.navigationClass) {
        [data setValue:info.navigationClass forKey:@"navigation"];
    }
    
    BOOL animated   = [[data valueForKey:@"animated"] boolValue];
    BOOL modal      = [[data valueForKey:@"modal"] boolValue];
    BOOL single     = [[data valueForKey:@"single"] boolValue];
    NSString *navigationClass = [data valueForKey:@"navigation"];
    
    // 单例
    if (single) {
        UINavigationController *navigation = [self rootNavigationController:link];

        [[navigation.viewControllers copy] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([controller.matchedURL isEqualToString:link.matchedURL]) {
                targetViewController = controller;
                *stop = YES;
            }
        }];
        if (targetViewController) {
            [navigation popToViewController:targetViewController animated:animated];
            return;
        }
    }
    
    targetViewController = [info targetController];
    [targetViewController setMatchedURL:link.matchedURL];
    
    if (targetViewController) {
        //模态展示
        if (modal) {
            UIViewController *controller = [self rootViewController:link];
            Class bgNavigation =  NULL;
            if (!navigationClass) {
                bgNavigation = NSClassFromString(@"BGNavigationController")?:([UINavigationController class]);
            } else {
                bgNavigation = NSClassFromString(navigationClass);
            }
            UINavigationController *navigation = [[bgNavigation alloc] initWithRootViewController:targetViewController];
            !navationBlock?:navationBlock(navigation);
            [self handleLink:link controller:targetViewController navigationController:navigation];
            [controller presentViewController:navigation?:targetViewController animated:animated completion:nil];
        }
        else {
            UINavigationController *navigation = [self rootNavigationController:link];
            !navationBlock?:navationBlock(navigation);
            [self handleLink:link controller:targetViewController navigationController:navigation];
            [navigation pushViewController:targetViewController animated:animated];
        }
    }
}

- (void)    handleLink:(MRouterLink*) link
            controller:(UIViewController *) targetViewController
  navigationController:(UINavigationController *)navigationController {
    
    if ([targetViewController respondsToSelector:@selector(handleRouterLink:navigationController:)]) {
        [targetViewController handleRouterLink:link navigationController:navigationController];
    } else {
        [targetViewController handleRouterLink:link];
    }
}

@end
