//
//  NSObject+Clone.m
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 11/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "NSObject+Clone.h"
#import <objc/runtime.h>

typedef struct objcasd_class1 *Class12;

@implementation NSObject(Clone) 

- (instancetype)clone {
    id objNew = [[self class] new];
    
    Class className = [self class];
    while (className) {
        [self copyIVAR:className andObject:objNew];
        className = class_getSuperclass(className);
    }
    return objNew;
}

- (void)copyValues:(id)objCopy {
    if ([objCopy isKindOfClass:[self class]]) {
        NSArray *arrayIVARs = [[self class] getIVARsTillTargetClass:nil];
        for (NSString *key in arrayIVARs) {
            [self setValue:[objCopy valueForKey:key] forKey:key];
        }
    }
}

- (void)copyIVAR:(Class)className andObject:(id)newObj{
    if (!className || ![self isKindOfClass:className] || ![self isMemberOfClass:[newObj class]]) {
        NSLog(@"Class is not well defined in cloning");
    } else {
        unsigned int count;
        Ivar* ivars = class_copyIvarList(className, &count);
        for(unsigned int i = 0; i < count; ++i) {
            NSString *key = [NSString stringWithFormat:@"%s",ivar_getName(ivars[i])];
            [newObj setValue:[self valueForKey:key]?:[NSNull null] forKey:key];
        }
    }
}

- (void)setAccessibilityLabelsOnIVARs {
    if ([self isKindOfClass:[UIViewController class]]) {
        Class className = [self class];
        while (className) {
            unsigned int count;
            Ivar* ivars = class_copyIvarList(className, &count);
            for(unsigned int i = 0; i < count; ++i) {
                NSString *key = [NSString stringWithFormat:@"%s",ivar_getName(ivars[i])];
                [self accessibilityLabelIfPossible:[self valueForKey:key] andObjName:key];
            }
            if (className == [UIViewController class]) {
                break;
            }
            className = class_getSuperclass(className);
        }
    }
}

- (BOOL)accessibilityLabelIfPossible:(id)obj andObjName:(NSString*)objName {
    if (!obj || ![obj isKindOfClass:[UIView class]]) {
        return NO;
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@%@", [self uiClassName:[obj class]], objName];
    [str deleteCharactersInRange:NSMakeRange(0, 2)];
    [str replaceOccurrencesOfString:@"_"
                         withString:@""
                            options:NSCaseInsensitiveSearch
                              range:NSMakeRange(0, str.length)];
    [(UIView *)obj setAccessibilityLabel:str];
    return YES;
}

- (NSString*)uiClassName:(Class)class {
    @try {
        NSString *str = NSStringFromClass(class);
        if ([str hasPrefix:@"UI"]) {
            return str;
        }
        return [self uiClassName:[class superclass]];
    } @catch (NSException *exception) {
        return @"";
    }
}


+ (NSArray*)getIVARsTillTargetClass:(Class)classNameTarget {
    if (!classNameTarget) {
        classNameTarget = [NSObject class];
    }
    NSMutableArray *arrayIVARs = [NSMutableArray new];
    Class className = [self class];
    while (className) {
        unsigned int count;
        Ivar* ivars = class_copyIvarList(className, &count);
        for(unsigned int i = 0; i < count; ++i) {
            NSString *key = [NSString stringWithFormat:@"%s",ivar_getName(ivars[i])];
            [arrayIVARs addObject:key];
        }
        if (className == classNameTarget) {
            break;
        }
        className = class_getSuperclass(className);
    }
    return arrayIVARs;
}



- (void)protocolMethodList:(Protocol*)p {
//    unsigned int mc = 0;
//    struct objc_method_description *mlist = (protocol_copyMethodDescriptionList(p, YES, YES, &mc));
//    NSLog(@"%d methods", mc);
//    for(int i = 0; i < mc ; i++, mlist++) {
//        NSLog(@"Method no #%d: %@, %s", i, NSStringFromSelector(mlist->name) , mlist->types);
//    }
}

- (void)protertiesName {
    
    
//    unsigned int mc = 0;
//    objc_property_t *mlist = class_copyPropertyList([self class], &mc);
//    NSLog(@"%d methods", mc);
//    for(int i = 0; i < mc ; i++, mlist++) {
//        const char * setter = property_copyAttributeValue(*mlist, "S");
//        if (setter != NULL) {
//            NSLog(@"Method no , %s", setter);
//        }
////        NSLog(@"Method no , %s", , );
//    }
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char * setter = property_copyAttributeValue(property, "S");
        if (setter == NULL) {
            setter = [self setNameFor:property_getName(property)];
        }
        fprintf(stdout, "%s %s\n", property_getName(property), setter);
    }

    
    
    
    
//    NSArray *arrayProperty = [[self class] getIVARsTillTargetClass:nil];
//    for (NSString *ivarName in arrayProperty) {
//        objc_property_t a = class_getProperty([self class], "appVersion");
//        NSLog(@"%s", property_copyAttributeValue( a, "S"));
//    }
    
}
                      

- (const char *)setNameFor:(const char *)varName {
    size_t len = strlen(varName) + 3 + 1; /* one for extra char, one for trailing zero */
    char *str = malloc(len);
    snprintf(str, len, "set%s", varName);
    if (str[3]>= 97 && str[3] <= 122) {
       str[3] = str[3] - 32;
    }
    return str;
}
                      
                    

@end
