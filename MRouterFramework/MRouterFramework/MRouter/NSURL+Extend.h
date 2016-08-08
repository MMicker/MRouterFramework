//
//  NSURL+Extend.h
//  comb5mios
//
//  Created by allen.wang on 8/6/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(Extend)

/**
 * @brief get query parameters array
 *
 * @return              NSArray *
 * @note                NULL: If no parameters
 */
- (NSArray *) paramContents;
    
/**
 * @brief get the value of the give parameter key
 *        the key should not be empty
 *
 * @param [out] N/A    
 * @return             NSString *
 * @note               @"": If did not contain such value
 */
- (NSString*) valueWithKey:(const NSString *)key;


- (NSDictionary *) parametersFromQueryString;

@end
