//
//  NSString+Custom.m
//
//
//  Created by Vladimir Psyukalov on 18.10.17.
//  Copyright © 2017 none. All rights reserved.
//


#import "NSString+Custom.h"


@implementation NSString (Custom)

- (NSString *)encodeURL {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)withoutWhitespaces {
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@"%20" options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
}

- (BOOL)numeric {
    NSCharacterSet *charSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [charSet isSupersetOfSet:stringSet];
}

- (BOOL)email {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSDictionary *)dictionary {
    NSError *error;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        return nil;
    }
    return dictionary;
}

- (NSData *)data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)weekday {
    return [self weekdayWithFormat:@"yyyy MMM dd"];
}

- (NSString *)weekdayWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatted = [NSDateFormatter new];
    [dateFormatted setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatted setDateFormat:format];
    NSDate *currentDate = [dateFormatted dateFromString:self];
    [dateFormatted setDateFormat:@"EEEE"];
    return [dateFormatted stringFromDate:currentDate];
}

@end
