//
//  MRouterRegularExpression.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterRegularExpression.h"

static NSString * const DPLNamedGroupComponentPattern = @":[a-zA-Z0-9-_][^/]+";
static NSString * const DPLRouteParameterPattern      = @":[a-zA-Z0-9-_]+";
static NSString * const DPLURLParameterPattern        = @"([^/]+)";

@implementation MRouterRegularMatchResult


@end

@implementation MRouterRegularExpression

+ (instancetype)regularExpressionWithPattern:(NSString *)pattern {
    return [[self alloc] initWithPattern:pattern options:0 error:nil];
}


- (instancetype)initWithPattern:(NSString *)pattern
                        options:(NSRegularExpressionOptions)options
                          error:(NSError *__autoreleasing *)error {
    
    NSString *cleanedPattern = [[self class] stringByRemovingNamedGroupsFromString:pattern];
    
    self = [super initWithPattern:cleanedPattern options:options error:error];
    if (self) {
        self.groupNames = [[self class] namedGroupsForString:pattern];
    }
    return self;
}


- (MRouterRegularMatchResult *)matchResultForString:(NSString *)str {
    NSArray *matches = [self matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    MRouterRegularMatchResult *matchResult = [[MRouterRegularMatchResult alloc] init];
    
    if (!matches.count) {
        return matchResult;
    }
    
    matchResult.match = YES;
    
    // Set route parameters in the routeParameters dictionary
    NSMutableDictionary *routeParameters = [NSMutableDictionary dictionary];
    for (NSTextCheckingResult *result in matches) {
        // Begin at 1 as first range is the whole match
        for (NSInteger i = 1; i < result.numberOfRanges && i <= self.groupNames.count; i++) {
            NSString *parameterName         = self.groupNames[i - 1];
            NSString *parameterValue        = [str substringWithRange:[result rangeAtIndex:i]];
            routeParameters[parameterName]  = parameterValue;
        }
    }
    
    matchResult.namedProperties = routeParameters;
    return matchResult;
}


#pragma mark - Named Group Helpers

+ (NSRegularExpression *) reqularExpressionForPattern:(NSString *) pattern {
    static NSDictionary *regularExpressions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        regularExpressions = @{
            DPLNamedGroupComponentPattern : [NSRegularExpression regularExpressionWithPattern:DPLNamedGroupComponentPattern
                                                                                      options:0
                                                                                        error:nil],
            DPLNamedGroupComponentPattern : [NSRegularExpression regularExpressionWithPattern:DPLRouteParameterPattern
                                                                                      options:0
                                                                                        error:nil]
        };
    });
    return [regularExpressions objectForKey:pattern];
}

+ (NSArray *)namedGroupTokensForString:(NSString *)str {
    NSRegularExpression *componentRegex = [self reqularExpressionForPattern:DPLNamedGroupComponentPattern];

    NSArray *matches = [componentRegex matchesInString:str
                                               options:0
                                                 range:NSMakeRange(0, str.length)];
    
    NSMutableArray *namedGroupTokens = [NSMutableArray array];
    for (NSTextCheckingResult *result in matches) {
        NSString *namedGroupToken = [str substringWithRange:result.range];
        [namedGroupTokens addObject:namedGroupToken];
    }
    return [NSArray arrayWithArray:namedGroupTokens];
}


+ (NSString *)stringByRemovingNamedGroupsFromString:(NSString *)str {
    NSString *modifiedStr = [str copy];
    
    NSArray *namedGroupExpressions = [self namedGroupTokensForString:str];
    NSRegularExpression *parameterRegex = [self reqularExpressionForPattern:DPLRouteParameterPattern];
    
    // For each of the named group expressions (including name & regex)
    for (NSString *namedExpression in namedGroupExpressions) {
        NSString *replacementExpression       = [namedExpression copy];
        NSTextCheckingResult *foundGroupName  = [[parameterRegex matchesInString:namedExpression
                                                                         options:0
                                                                           range:NSMakeRange(0, namedExpression.length)] firstObject];
        // If it's a named group, remove the name
        if (foundGroupName) {
            NSString *stringToReplace  = [namedExpression substringWithRange:foundGroupName.range];
            replacementExpression = [replacementExpression stringByReplacingOccurrencesOfString:stringToReplace
                                                                                     withString:@""];
        }
        
        // If it was a named group, without regex constraining it, put in default regex
        if (replacementExpression.length == 0) {
            replacementExpression = DPLURLParameterPattern;
        }
        
        modifiedStr = [modifiedStr stringByReplacingOccurrencesOfString:namedExpression
                                                             withString:replacementExpression];
    }
    
    if (modifiedStr.length && !([modifiedStr characterAtIndex:0] == '/')) {
        modifiedStr = [@"^" stringByAppendingString:modifiedStr];
    }
    modifiedStr = [modifiedStr stringByAppendingString:@"$"];
    
    return modifiedStr;
}


+ (NSArray *)namedGroupsForString:(NSString *)str {
    NSMutableArray *groupNames = [NSMutableArray array];
    
    NSArray *namedGroupExpressions = [self namedGroupTokensForString:str];
    NSRegularExpression *parameterRegex = [self reqularExpressionForPattern:DPLRouteParameterPattern];
    
    for (NSString *namedExpression in namedGroupExpressions) {
        NSArray *componentMatches             = [parameterRegex matchesInString:namedExpression
                                                                        options:0
                                                                          range:NSMakeRange(0, namedExpression.length)];
        NSTextCheckingResult *foundGroupName = [componentMatches firstObject];
        if (foundGroupName) {
            NSString *stringToReplace  = [namedExpression substringWithRange:foundGroupName.range];
            NSString *variableName     = [stringToReplace stringByReplacingOccurrencesOfString:@":"
                                                                                    withString:@""];
            
            [groupNames addObject:variableName];
        }
    }
    return [NSArray arrayWithArray:groupNames];
}

@end
