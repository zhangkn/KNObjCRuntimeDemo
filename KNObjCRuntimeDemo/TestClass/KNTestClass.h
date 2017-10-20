//
//  KNTestClass.h
//  KNObjCRuntimeDemo
//
//  Created by devzkn on 20/10/2017.
//  Copyright © 2017 Weiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTestClass : NSObject<NSCoding, NSCopying>




@property (nonatomic, strong) NSArray *publicProperty1;
@property (nonatomic, strong) NSString *publicProperty2;

+ (void)classMethod: (NSString *)value;
- (void)publicTestMethod1: (NSString *)value1 Second: (NSString *)value2;
- (void)publicTestMethod2;

- (void)method1;
@end

