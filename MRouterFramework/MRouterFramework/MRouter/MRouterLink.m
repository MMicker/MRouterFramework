//
//  MRouterLink.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterLink.h"
#import "NSURL+Extend.h"

NSString * const MRouterCallbackURLKey = @"m_callback_url";

@implementation MRouterLink

- (instancetype) initWithURL:(NSURL *)url {
    if (!url) return nil;
    
    self = [super init];
    if (self) {
        _URL  = url;
        _queryParameters = [_URL parametersFromQueryString];
    }
    return self;
}

- (NSURL *) callbackURL {
    NSString *URLString = self.queryParameters[MRouterCallbackURLKey];
    return [NSURL URLWithString:URLString];
}

- (void) setRouteParameters:(NSDictionary *)routeParameters {
    _routeParameters = routeParameters;
}

#pragma mark - Parameter Retrieval via Object Subscripting

- (id) objectForKeyedSubscript:(NSString *)key {
    id value  = self.routeParameters[key];
    if (!value) {
        value = self.queryParameters[key];
    }
    return value;
}
@end
