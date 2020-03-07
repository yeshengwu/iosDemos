//
//  confuse.h
//  
//
//  Created by NPHD on 14-8-25.
//  Copyright (c) 2014年 1528studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef wangcai_confuse_h
#define wangcai_confuse_h

#define OFW   ([Confuse make:@"ngdgoz]pg"])

#define TYZX  ([Confuse make:@"佒骍丫必"])

@interface Confuse : NSObject
+ (NSString*) make:(NSString*) str;
+ (NSString*) make2:(NSString*) str;
@end

#endif
