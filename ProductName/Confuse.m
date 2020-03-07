//
//  Confuse.m
//  
//
//  Created by NPHD on 14-8-25.
//  Copyright (c) 2014年 1528studio. All rights reserved.
//

#import "Confuse.h"

@implementation Confuse

// +1-1+2-2+3-3+4-4+5-5+6-6

+(NSString*) make:(NSString*) str {
    NSString* value = @"";
    
    for ( int i = 0; i < [str length]; i ++ ) {
        int off = i / 2 + 1;
        unichar ch = [str characterAtIndex:i];
        if ( i % 2 == 0 ) {
            ch = ch + off;
        } else {
            ch = ch - off;
        }
        
        value = [value stringByAppendingFormat:@"%C", ch];
    }
    return value;
}

+(NSString*) make2:(NSString*) str {
    NSString* value = @"";
    
    for ( int i = 0; i < [str length]; i ++ ) {
        int off = i / 2 + 1;
        unichar ch = [str characterAtIndex:i];
        if ( i % 2 == 0 ) {
            ch = ch - off;
        } else {
            ch = ch + off;
        }
        
        value = [value stringByAppendingFormat:@"%C", ch];
    }
    return value;
}

@end
