//
//  MRouterDefaultHandler.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IURLResolver.h"

@interface UIApplication (NavigationController)

- (UIViewController*) rootPresentViewController;

- (UINavigationController *) rootNavigationController;

@end

@interface MRouterDefaultHandler : NSObject<IURLResolver>

- (UIViewController *) rootViewController:(MRouterLink *) link;

@end


