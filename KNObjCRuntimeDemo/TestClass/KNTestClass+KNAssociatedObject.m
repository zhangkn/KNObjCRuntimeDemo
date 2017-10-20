//
//  KNTestClass+KNAssociatedObject.m
//  KNObjCRuntimeDemo
//
//  Created by devzkn on 20/10/2017.
//  Copyright © 2017 Weiliu. All rights reserved.
//

#import "KNTestClass+KNAssociatedObject.h"
#pragma mark - 动态属性关联
static char kDynamicAddProperty;
@implementation KNTestClass (KNAssociatedObject)


/**
 getter方法
 
 @return 返回关联属性的值
 */
- (NSString *)dynamicAddProperty {
    return objc_getAssociatedObject(self, &kDynamicAddProperty);
}


/**
 setter方法
 
 @param dynamicAddProperty 设置关联属性的值
 */
- (void)setDynamicAddProperty:(NSString *)dynamicAddProperty {
    objc_setAssociatedObject(self, &kDynamicAddProperty, dynamicAddProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
