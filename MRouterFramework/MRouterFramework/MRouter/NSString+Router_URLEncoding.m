//
//  NSString+URLEncoding.m
//
//  Created by Jon Crosby on 10/19/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "NSString+Router_URLEncoding.h"


@implementation NSString (Router_OAURLEncodingAdditions)

- (NSString *)router_removeScheme {
    NSString *result = [self copy];
    NSRange range = [result rangeOfString:@"://"];
    if (range.location != NSNotFound) {
        result = [result substringFromIndex:range.location+range.length];
    }
    return result;
}

- (NSString *)router_URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
//    [result autorelease];
	return result;
}

- (NSString*)router_URLDecodedString
{
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8));
//    [result autorelease];
	return result;
}

- (BOOL) isIPAddress {
    NSString *regex = @"((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(\\.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}";
    NSRegularExpression *componentRegex = [NSRegularExpression regularExpressionWithPattern:regex
                                                                                    options:0
                                                                                      error:nil];
    NSString *target = [self copy];
    NSArray *matches = [componentRegex matchesInString:target
                                               options:0
                                                 range:NSMakeRange(0, target.length)];
    return [matches count] > 0;
}
@end
