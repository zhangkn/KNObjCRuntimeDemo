//
//  KNTestClass.m
//  KNObjCRuntimeDemo
//
//  Created by devzkn on 20/10/2017.
//  Copyright © 2017 Weiliu. All rights reserved.
//

#import "KNTestClass.h"



#import "KNRuntimeKit.h"

@interface SecondClass : NSObject
- (void)noThisMethod:(NSString *)value;
@end

@implementation SecondClass
- (void)noThisMethod:(NSString *)value {
    NSLog(@"SecondClass中的方法实现%@", value);
}
@end





@interface KNTestClass(){
    NSInteger _var1;
    int _var2;
    BOOL _var3;
    double _var4;
    float _var5;
}

@property (nonatomic, strong) NSMutableArray *privateProperty1;
@property (nonatomic, strong) NSNumber *privateProperty2;
@property (nonatomic, strong) NSDictionary *privateProperty3;


@end

@implementation KNTestClass

+ (void)classMethod: (NSString *)value {
    NSLog(@"publicTestMethod1");
}

- (void)publicTestMethod1: (NSString *)value1 Second: (NSString *)value2 {
    NSLog(@"publicTestMethod1");
}

- (void)publicTestMethod2 {
    NSLog(@"publicTestMethod2");
}

- (void)privateTestMethod1 {
    NSLog(@"privateTestMethod1");
}

- (void)privateTestMethod2 {
    NSLog(@"privateTestMethod2");
}

#pragma mark - 方法交换时使用
- (void)method1 {
    NSLog(@"我是Method1的实现");
}

//运行时方法拦截
- (void)dynamicAddMethod: (NSString *) value {
    NSLog(@"OC替换的方法：%@", value);
}

#pragma mark - ******** 消息转发
/**
流程：
http://blog.csdn.net/z929118967/article/details/78032699
1.动态方法解析
向当前类发送 resolveInstanceMethod: 信号，检查是否动态向该类添加了方法。（迷茫请搜索：@dynamic）
2.快速消息转发
检查该类是否实现了 forwardingTargetForSelector: 方法，若实现了则调用这个方法。若该方法返回值对象非nil或非self，则向该返回对象重新发送消息。
3.标准消息转发
runtime发送methodSignatureForSelector:消息获取Selector对应的方法签名。返回值非空则通过forwardInvocation:转发消息，返回值为空则向当前对象发送doesNotRecognizeSelector:消息，程序崩溃退出。

利用上述过程中的2、3两种方式来完成消息转发。
 
 
 两种消息转发方式的比较
 
 快速消息转发：简单、快速、但仅能转发给一个对象。
 标准消息转发：稍复杂、较慢、但转发操作实现可控，可以实现多对象转发
 
**/

/**
 没有找到SEL的IML实现时会执行下方的方法
 
 @param sel 当前对象调用并且找不到IML的SEL
 @return 找到其他的执行方法，并返回yes
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;    //当返回NO时，会接着执行forwordingTargetForSelector:方法，
    [KNRuntimeKit addMethod:[self class] method:sel method:@selector(dynamicAddMethod:)];
    return YES;
}


/**
 将当前对象不存在的SEL传给其他存在该SEL的对象
 
 @param aSelector 当前类中不存在的SEL
 @return 存在该SEL的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self;
    return [SecondClass new];   //让SecondClass中相应的SEL去执行该方法
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SecondClass * forwardClass = [SecondClass new];
    SEL sel = invocation.selector;
    if ([forwardClass respondsToSelector:sel]) {
        [invocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
