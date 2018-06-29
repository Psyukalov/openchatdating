//
//  NSDictionary+Custom.m
//
//
//  Created by Vladimir Psyukalov on 30.11.17.
//  Copyright © 2017 none. All rights reserved.
//


#import "NSDictionary+Custom.h"


@implementation NSDictionary (Custom)

- (NSString *)string {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
