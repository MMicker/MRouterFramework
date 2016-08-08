//
//  MRouterInfo+Router.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterInfo.h"

@interface MRouterInfo (Router)

- (MRouterLink *) handleURL:(NSURL *) url userInfo:(id) userInfo;

@end
