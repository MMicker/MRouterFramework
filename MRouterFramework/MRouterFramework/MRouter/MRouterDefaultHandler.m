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
    UIViewController *controller = appDelegate.window.rootViewController;
    while (controller.presentedViewController) {
        controller = [self _topViewController:controller.presentedViewController];
    }
    return controller;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
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

#pragma IURLResolver

- (void) handleRouter:(MRouterInfo*) info link:(MRouterLink *) link {
    [self handleRouter:info link:link navation:nil];
}

- (void) handleRouter:(MRouterInfo*) info link:(MRouterLink *) link navation:(void(^)(UINavigationController *navigationController)) navationBlock {
    UIViewController *targetViewController = [info targetController];
    [targetViewController setMatchedURL:link.matchedURL];
    
    if (targetViewController) {
        UIViewController *controller = [self rootViewController:link];
        UINavigationController *navigation = nil;
        
        if ([info modalPresent]) {
            
            Class bgNavigation = NSClassFromString(@"BGNavigationController")?:([UINavigationController class]);
            navigation = [[bgNavigation alloc] initWithRootViewController:targetViewController];
            !navationBlock?:navationBlock(navigation);
            [self handleLink:link controller:targetViewController navigationController:navigation];
            [controller presentViewController:navigation animated:[info animated] completion:nil];

        }
        else {
            navigation = (UINavigationController *)([controller isKindOfClass:[UINavigationController class]] ?
                                                    controller:
                                                    controller.navigationController);
            !navationBlock?:navationBlock(navigation);
            [self handleLink:link controller:targetViewController navigationController:navigation];
            [navigation pushViewController:targetViewController animated:[info animated]];

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
