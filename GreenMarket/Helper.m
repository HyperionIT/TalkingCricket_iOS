//
//  Helper.m
//  GreenMarket
//
//  Created by Andrea Cerra on 27/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import "Helper.h"

@implementation Helper

/* Convert NSDictionary in json string */
+ (NSString *) jsonFromDictionary:(NSDictionary *) makeMePretty {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:makeMePretty
                                                       options:kNilOptions
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
