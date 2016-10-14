//
//  MRouterMatcher.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterMatcher.h"
#import "MRouterRegularExpression.h"

@interface MRouterMatcher ()

@property (nonatomic, copy)   NSString *scheme;

@property (nonatomic, strong) MRouterRegularExpression *regexMatcher;

@end

@implementation MRouterMatcher

+ (instancetype)matcherWithRoute:(NSString *)route {
    return [[self alloc] initWithRoute:route];
}

- (instancetype)initWithRoute:(NSString *)route {
    if (![route length]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        NSArray *parts = [route componentsSeparatedByString:@"://"];
        _scheme = parts.count > 1 ? [parts firstObject] : nil;
        _regexMatcher = [MRouterRegularExpression regularExpressionWithPattern:[parts lastObject]];
    }
    
    return self;
}


- (MRouterLink *)deepLinkWithURL:(NSURL *)url {
    
    MRouterLink *deepLink       = [[MRouterLink alloc] initWithURL:url];
    NSString *deepLinkString    = [NSString stringWithFormat:@"%@%@", deepLink.URL.host, deepLink.URL.path];
    if ([deepLink.URL.query length] > 0) {
        //用于匹配带有参数的url, 在此对？进行转义成/
        deepLinkString    = [NSString stringWithFormat:@"%@/%@", deepLinkString, deepLink.URL.query];
    }
    
    if (self.scheme.length && ![self.scheme isEqualToString:deepLink.URL.scheme]) {
        return nil;
    }
    
    MRouterRegularMatchResult *matchResult = [self.regexMatcher matchResultForString:deepLinkString];
    if (!matchResult.isMatch) {
        return nil;
    }
    
    deepLink.routeParameters = matchResult.namedProperties;
    return deepLink;
}
@end
