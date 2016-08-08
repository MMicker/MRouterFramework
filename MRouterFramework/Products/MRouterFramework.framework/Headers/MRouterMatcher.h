//
//  MRouterMatcher.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRouterLink.h"

@interface MRouterMatcher : NSObject


+ (instancetype)matcherWithRoute:(NSString *)route;

- (MRouterLink *)deepLinkWithURL:(NSURL *)url;

@end
