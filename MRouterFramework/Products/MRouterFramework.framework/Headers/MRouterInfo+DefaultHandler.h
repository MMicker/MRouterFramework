//
//  MRouterInfo+DefaultHandler.h
//  MRouterFramework
//
//  Created by Micker on 16/8/8.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterInfo.h"

@interface MRouterInfo (DefaultHandler)

- (BOOL) animated;

- (BOOL) modalPresent;

- (BOOL) singleInstance;

- (BOOL) defaultRouterValue;

- (UIViewController *) targetController;

@end
