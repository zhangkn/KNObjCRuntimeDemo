//
//  KNTestClass+KNSwapMethod.m
//  KNObjCRuntimeDemo
//
//  Created by devzkn on 20/10/2017.
//  Copyright © 2017 Weiliu. All rights reserved.
//

#import "KNTestClass+KNSwapMethod.h"
#import "KNRuntimeKit.h"

@implementation KNTestClass (KNSwapMethod)

- (void)swapMethod {
    [KNRuntimeKit methodSwap:[self class]
               firstMethod:@selector(method1)
              secondMethod:@selector(method2)];
}

- (void)method2 {
    //下方调用的实际上是method1的实现
    [self method2];
    NSLog(@"可以在Method1的基础上添加各种东西了");
}

@end
