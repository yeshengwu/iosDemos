//
//  Son.m
//  ProductName
//
//  Created by 十度 on 2020/5/31.
//  Copyright © 2020 十度. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"son. init");
        
        NSLog(@"son. init self class = %@",NSStringFromClass([self class]));   // result : Son
        NSLog(@"son. init super class = %@",NSStringFromClass([super class])); // result : Son
    }
    return self;
}
@end
