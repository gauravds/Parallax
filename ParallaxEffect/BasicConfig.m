//
//  BasicConfig.m
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 06/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "BasicConfig.h"
#import <objc/runtime.h>

@implementation BasicConfig

- (instancetype)init {
    self = [super init];
    [self setDefault];
    return self;
}

- (void)setDefault {
    self.appName = @"App Default";
    self.appVersion = @"ac v1.0.0";
    self.index = 0;
    self.rect = CGRectZero;
}

- (BasicConfig *)customBasicConfig {
    return self;
}

#pragma mark - runtime class
- (instancetype)createPrivateClass {
    return [self copyProperties:[BasicConfig class]];
}

- (void)setterDoNothing:(id)nothing {}

- (const char *)setNameFor:(const char *)varName {
    size_t len = strlen(varName) + 4 + 1; /* one for extra char, one for trailing zero */
    char *str = malloc(len);
    snprintf(str, len, "set%s:", varName);
    if (str[3]>= 97 && str[3] <= 122) {
        str[3] = str[3] - 32;
    }
    return str;
}

- (instancetype)copyProperties:(Class)className {
    
    Class mySubclass = objc_allocateClassPair(className, [[NSString stringWithFormat:@"PK_%@",NSStringFromClass(className)] UTF8String], 0);
    
    //-- all setter method names
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char * setter = property_copyAttributeValue(property, "S");
        if (setter == NULL) {
            setter = [self setNameFor:property_getName(property)];
        }
//        fprintf(stdout, "%s %s\n", property_getName(property), setter);
        
        //- override the setter methods with do nothing in new runtime class
        Method m2 = class_getInstanceMethod(className, @selector(setterDoNothing:));
        IMP imp2 = method_getImplementation(m2);
        SEL oldSetterName = NSSelectorFromString([NSString stringWithFormat:@"%s", setter]);
        class_addMethod(mySubclass, oldSetterName, (IMP)imp2, "v@:@");
    }
    
    objc_registerClassPair(mySubclass);
    
    id newInstance = [[mySubclass alloc] init];
    
    //-- copy all ivar value from the current instance to new runtime class
    unsigned int count;
    Ivar* ivars = class_copyIvarList(className, &count);
    for(unsigned int i = 0; i < count; ++i) {
        NSString *key = [NSString stringWithFormat:@"%s",ivar_getName(ivars[i])];
        object_setIvar(newInstance, ivars[i], [self valueForKey:key]);
    }
    
    return newInstance;
}

- (void)setValue:(id)value forKey:(NSString *)key {}

@end
