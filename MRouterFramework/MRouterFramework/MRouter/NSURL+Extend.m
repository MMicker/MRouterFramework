//
//  NSURL+Extend.m
//  comb5mios
//
//  Created by allen.wang on 8/6/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "NSURL+Extend.h"

#define parameterString             @"&"
#define parameterComparString       @"="


@implementation NSURL(Extend)

- (NSArray *) paramContents
{
    NSAssert(self,@"URL is NULL!");
    if (self.query) {
        NSRange range = [self.query rangeOfString:parameterString];
        if (range.location != NSNotFound) {
            return [self.query componentsSeparatedByString:parameterString];
        }
        else {
            return [NSArray arrayWithObject:self.query];
        }
    }
    return nil;
}

- (NSString*) valueWithKey:(const NSString *)key
{
    NSAssert(self,@"URL is NULL!");
    NSAssert(key, @"key is NULL!");
    NSAssert([key length],@"key is empty!");
    
    NSArray *array = [self paramContents];
    for (int i = 0 ; i < [array count];i++) {
        
        NSString *origal = [array objectAtIndex:i];
        NSString *content = [origal lowercaseString];
        NSRange range = [content rangeOfString:parameterComparString];
        NSString *keyTemp = nil;
        
        if (range.location != NSNotFound) {
            keyTemp = [content substringToIndex:range.location];
            if ([[key lowercaseString] isEqualToString:keyTemp]) {
                NSString *valTemp = [origal  substringFromIndex:range.location + 1];
                return valTemp;
            }
        }
    }
    return nil;
}

- (NSDictionary *) parametersFromQueryString {
    NSArray *params = [self paramContents];
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    for (NSString *param in params) {
        NSArray *pairs = [param componentsSeparatedByString:parameterComparString];
        if (pairs.count == 2) {
            NSString *key   = [pairs[0] stringByRemovingPercentEncoding];
            NSString *value = [pairs[1] stringByRemovingPercentEncoding];
            paramsDict[key] = value;
        }
        else if (pairs.count == 1) {
            NSString *key = [[pairs firstObject] stringByRemovingPercentEncoding];
            paramsDict[key] = @"";
        }
    }
    return [paramsDict copy];
}



@end
