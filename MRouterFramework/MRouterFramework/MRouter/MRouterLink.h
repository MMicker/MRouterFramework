//
//  MRouterLink.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRouterLink : NSObject
@property (nonatomic, copy, readonly)   NSURL *URL;
@property (nonatomic, copy, readonly)   NSDictionary *queryParameters;
@property (nonatomic, copy, readonly)   NSDictionary *routeParameters;
@property (nonatomic, strong, readonly) NSURL *callbackURL;

- (instancetype)initWithURL:(NSURL *)url;

- (void)setRouteParameters:(NSDictionary *)routeParameters;

- (id) objectForKeyedSubscript:(NSString *)key;

@end
