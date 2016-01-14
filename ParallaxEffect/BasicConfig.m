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

- (void)setAppName:(NSString *)appName {
    _appName = appName;
    NSLog(@"app name %@", _appName);
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
        fprintf(stdout, "%s %s\n", property_getName(property), setter);
        
        //- override the setter methods with do nothing in new runtime class
        Method m2 = class_getInstanceMethod(className, @selector(setterDoNothing:));
        IMP imp2 = method_getImplementation(m2);
        SEL oldSetterName = NSSelectorFromString([NSString stringWithFormat:@"%s", setter]);
        class_addMethod(mySubclass, oldSetterName, (IMP)imp2, "v@:@");
//        class_replaceMethod(mySubclass, oldSetterName, imp2, "@:");

        
//        Method m =
//        method_setImplementation();
//        SEL s1 = NSSelectorFromString([NSString stringWithFormat:@"%s", setter]);
//        Method m1 = class_getInstanceMethod(className, s1);
//        Method m2 = class_getInstanceMethod(className, @selector(setterDoNothing:));
//        
////        IMP imp1 = method_getImplementation(m1);
//        IMP imp2 = method_getImplementation(m2);
//        method_setImplementation(m1, imp2);
        
//        method_exchangeImplementations(m1, m2);
        
//        IMP m1 = method_getImplementation(m1)
//        method_exchangeImplementations();
        
//        class_replaceMethod
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


//
//
//
//
//+(NSDictionary*)buildClassFromDictionary:(NSArray*)propNames withName:(NSString*)className
//
//{
//    
//    NSMutableDictionary* keys = [[NSMutableDictionary alloc]init];
//    
//    
//    
//    Class newClass = NSClassFromString(className);
//    
//    
//    
//    if(newClass == nil)
//        
//    {
//        
//        newClass = objc_allocateClassPair([NSObject class], [className UTF8String], 0);
//        
//        
//        
//        for(NSString* key in propNames)
//            
//        {
//            
//            NSString* propName = [self propName: key];
//            
//            class_addMethod(newClass, NSSelectorFromString([self setterName:propName]), (IMP)setterDoNothing, "v@:@");
//            
//            [keys setValue:key forKey:propName];
//            
//        }
//        
//        
//        
//        objc_registerClassPair(newClass);
//        
//    }
//    
//    
//    
//    return keys;
//    
//}
//
//
//
//+ (NSString*)propName:(NSString*)name {
//    name = [name stringByReplacingOccurrencesOfString:@":" withString:@""];
//    
//    NSRange r;
//    r.length = name.length -1 ;
//    r.location = 1;
//    
//    NSString* firstChar = [name stringByReplacingCharactersInRange:r withString:@""];
//    
//    if([firstChar isEqualToString:[firstChar lowercaseString]])
//    {
//        return name;
//    }
//    
//    r.length = 1;
//    r.location = 0;
//    
//    NSString* theRest = [name stringByReplacingCharactersInRange:r withString:@""];
//    
//    return [NSString stringWithFormat:@"%@%@", [firstChar lowercaseString] , theRest];
//}
//
//+ (NSString*)setterName:(NSString*)name {
//    name = [self propName:name];
//    
//    NSRange r;
//    r.length = name.length -1 ;
//    r.location = 1;
//    
//    NSString* firstChar = [name stringByReplacingCharactersInRange:r withString:@""];
//    
//    r.length = 1;
//    r.location = 0;
//    
//    NSString* theRest = [name stringByReplacingCharactersInRange:r withString:@""];
//    
//    return [NSString stringWithFormat:@"set%@%@", [firstChar uppercaseString] , theRest];
//}
//
//
//+ (NSString*)propNameFromSetterName:(NSString*)name {
//    return [self propName:[name stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""]];
//}
//
//+ (NSString*)ivarName:(NSString*)name {
//    NSRange r;
//    r.length = name.length -1 ;
//    r.location = 1;
//    
//    NSString* firstChar = [name stringByReplacingCharactersInRange:r withString:@""].lowercaseString;
//    
//    if([firstChar isEqualToString:@"_"])
//        return name;
//    
//    r.length = 1;
//    r.location = 0;
//    
//    NSString* theRest = [name stringByReplacingCharactersInRange:r withString:@""];
//    
//    return [NSString stringWithFormat:@"_%@%@",firstChar, theRest];
//}


@end
