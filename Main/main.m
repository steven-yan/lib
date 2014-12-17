//
//  main.m
//  e-Heathy
//
//  Created by steven on 7/10/14.
//  Copyright (c) 2014 steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/objc.h>

#import "AppDelegate.h"

void showSelf(id self, SEL cmd) {
    NSLog(@"%@, %p, %p ", [self class], [self class], showSelf);
    
    NSObject *obj = [[NSObject alloc] init];
    NSLog(@"**%p %p %p", obj, [obj class], [[obj class] class]);
    NSLog(@"**%p %p %p", object_getClass(obj), object_getClass([obj class]), object_getClass([[obj class] class]));
    NSLog(@"**%p %p %p", objc_getMetaClass(class_getName([obj class])), objc_getMetaClass(class_getName([obj class])), objc_getMetaClass(class_getName([[obj class] class])));
    Class isa = object_getClass(self);
    while (1) {
        NSLog(@"%p, %p, %p", isa, object_getClass(isa), objc_getMetaClass(class_getName(isa)));
        
        if (isa == object_getClass(isa)) {
            return;
        }
        
        isa = (Class)isa->isa;
    }
}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        Class subCls = objc_allocateClassPair([NSObject class], "SubNSObject", 0);
        class_addMethod(subCls, @selector(show), (IMP)showSelf, nil);
        
        id is = class_createInstance(subCls, 0);
        NSLog(@"%@ %p", subCls, subCls);
        NSLog(@"%@ %p %@ %p", is, is, [is class], [is class]);
        
        if ([is respondsToSelector:@selector(show)]) {
            [is performSelector:@selector(show)];
        }
        
//        [[[subCls alloc] init] showSelf];
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
