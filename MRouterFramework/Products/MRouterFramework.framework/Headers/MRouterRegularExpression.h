//
//  MRouterRegularExpression.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRouterRegularMatchResult : NSObject

@property (nonatomic, assign, getter=isMatch) BOOL match;

@property (nonatomic, strong) NSDictionary *namedProperties;

@end

@interface MRouterRegularExpression : NSRegularExpression

@property (nonatomic, strong) NSArray *groupNames;

+ (instancetype)regularExpressionWithPattern:(NSString *)pattern;

- (MRouterRegularMatchResult *)matchResultForString:(NSString *)str;

@end
