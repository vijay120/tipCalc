//
//  utils.m
//  tipcalculator
//
//  Created by Vijay Ramakrishnan on 12/24/14.
//  Copyright (c) 2014 Vijay Ramakrishnan. All rights reserved.
//

#import "utils.h"

@implementation utils

+(NSMutableArray *) getTipPercentages {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *segmentStrings = @[@"p1", @"p2", @"p3"];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i < segmentStrings.count; i++) {
        NSNumber *val = [NSNumber numberWithInteger:[defaults integerForKey:segmentStrings[i]]];
        [result addObject: val];
    }
    return result;
}

@end
