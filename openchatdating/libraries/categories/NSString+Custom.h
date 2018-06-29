//
//  NSString+Custom.h
//
//
//  Created by Vladimir Psyukalov on 18.10.17.
//  Copyright © 2017 none. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSString (Custom)

- (NSString *)encodeURL;

- (BOOL)numeric;
- (BOOL)email;

- (NSDictionary *)dictionary;
- (NSData *)data;

- (NSString *)weekday;
- (NSString *)weekdayWithFormat:(NSString *)format;

@end
