//
//  MRouterMatcher.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRouterLink.h"


/// 用于多域名支持， 仅在特定域名下有效
@protocol MRouterMatcherProtocol <NSObject>
@required

- (NSString *) matchOriginHost:(NSString *) originHost routerHost:(NSString *) routeHost;

@end

@interface MRouterMatcher : NSObject

@property (nonatomic, strong, class) id<MRouterMatcherProtocol> matcherProtocol;

+ (instancetype)matcherWithRoute:(NSString *)route;

- (MRouterLink *)deepLinkWithURL:(NSURL *)url;

@end
