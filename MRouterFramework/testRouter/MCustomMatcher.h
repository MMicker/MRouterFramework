//
//  MCustomMatcher.h
//  testRouter
//
//  Created by Micker on 2020/10/22.
//  Copyright © 2020 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRouterMatcher.h"
#import "MRouterIntercept.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCustomMatcher : NSObject<MRouterMatcherProtocol>

@end

@interface MCustomRouterIntercept : NSObject<MRouterInterceptProtocol>

@end

NS_ASSUME_NONNULL_END
