//
//  NSCharacterSet+AppFunctions.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "NSCharacterSet+AppFunctions.h"

@implementation NSCharacterSet (AppFunctions)

- (void)logCharacterSet {
    int bufferSize = 10;
    unichar unicharBuffer[bufferSize];
    int index = 0;
    
    for (unichar uc = 0; uc < (0xFFFF); uc ++) {
        if ([self characterIsMember:uc]) {
            unicharBuffer[index] = uc;
            
            index ++;
            
            if (index == bufferSize) {
                NSString * characters = [NSString stringWithCharacters:unicharBuffer length:index];
                NSLog(@"%@", characters);
                
                index = 0;
            }
        }
    }
    
    if (index != 0) {
        NSString * characters = [NSString stringWithCharacters:unicharBuffer length:index];
        NSLog(@"%@", characters);
    }
}

+ (void)logCharacterSet:(NSCharacterSet*)characterSet {
    [characterSet logCharacterSet];
}


@end
