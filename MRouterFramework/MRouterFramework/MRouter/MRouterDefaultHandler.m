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

@implementation MRouterDefaultHandler

- (UIViewController *) rootViewController:(MRouterLink *) link {
    return [[UIApplication sharedApplication].keyWindow.rootViewController presentedViewController];
}

#pragma IURLResolver

- (void) handleRouter:(MRouterInfo*) info link:(MRouterLink *) link {
    
    UIViewController *targetViewController = [info targetController];
    if (targetViewController) {
        UIViewController *controller = [self rootViewController:link];
        [targetViewController handleRouterLink:link];
        UINavigationController *navigation = nil;
        
        if ([info modalPresent]) {
            
            navigation = [[UINavigationController alloc] initWithRootViewController:targetViewController];
            [controller presentViewController:navigation animated:[info animated] completion:nil];

        }
        else {
            navigation = (UINavigationController *)([controller isKindOfClass:[UINavigationController class]] ?
                                                    controller:
                                                    controller.navigationController);
            [navigation pushViewController:targetViewController animated:[info animated]];

        }
    }
}

@end
