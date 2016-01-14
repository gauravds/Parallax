//
//  AppConfig.m
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 06/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "AppConfig.h"
#import <objc/runtime.h>

@implementation AppConfig

- (BasicConfig *)customBasicConfig {
    BasicConfig *basicConfig = [BasicConfig new];
    basicConfig.appName = @"custom app";
    return basicConfig;
}

- (GameConfig*)customGameConfig {
    GameConfig *gameConfig = [GameConfig new];
    gameConfig.gameName = @"custom Game name";
    gameConfig.gameVersion = @"custom ve 2.0";
    return gameConfig;
}


- (void)hack {
    Class className = [[ConfigManager sharedInstance].basicConfig class];
    SEL setterName = @selector(setAppName:);
    Method m2 = class_getInstanceMethod(className, setterName);
    IMP imp2 = method_getImplementation(m2);
    class_addMethod(className, setterName, (IMP)imp2, "v@:@");
    objc_registerClassPair(className);
}


@end