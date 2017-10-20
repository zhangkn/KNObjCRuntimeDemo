//
//  ViewController.m
//  KNObjCRuntimeDemo
//
//  Created by devzkn on 20/10/2017.
//  Copyright © 2017 Weiliu. All rights reserved.
//

#import "ViewController.h"
#import "KNRuntimeKit.h"
#import "KNTestClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    获取成员变量list
   NSArray *arr = [KNRuntimeKit fetchIvarList:[KNTestClass class]];
    
    NSLog(@"%@",arr);
    /**
     *     ivarName = "_var2";
     type = i;
     },
     {
     ivarName = "_var3";
     type = c;
     },
     {
     ivarName = "_var4";
     type = d;
     },
     {
     ivarName = "_var5";
     type = f;
     },
     {
     ivarName = "_publicProperty1";
     type = "@\"NSArray\"";
     },
     
     */
    
    
    
    NSArray *arrfetchIvarList = [KNRuntimeKit fetchPropertyList:[KNTestClass class]];
    
    NSLog(@"%@",arrfetchIvarList);
    
    
    NSArray *arrfetchIvarListfetchMethodList = [KNRuntimeKit fetchMethodList:[KNTestClass class]];
    
    NSLog(@"%@",arrfetchIvarListfetchMethodList);
    
    
    NSArray *arrfetchIvarListfetchMethodListfetchProtocolList = [KNRuntimeKit fetchProtocolList:[KNTestClass class]];
    
    NSLog(@"%@",arrfetchIvarListfetchMethodListfetchProtocolList);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
