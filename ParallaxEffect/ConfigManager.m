//
//  ConfigManager.m
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 06/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "ConfigManager.h"
#import "AppConfig.h"

@interface ConfigManager ()

@property (nonatomic, readwrite) BasicConfig *basicConfig;
@property (nonatomic, readwrite) GameConfig *gameConfig;

@end


@implementation ConfigManager

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t oncePredicate = 0;
    __strong static ConfigManager *_sharedInstance = nil;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[super alloc] init];
        [_sharedInstance setAllDataOnce];
    });
    return _sharedInstance;
}

#pragma mark - Private Method
- (void)setAllDataOnce {
    [self callDataSource];
}

- (void)callDataSource {
    AppConfig *_appConfig = [AppConfig new];
    if ([_appConfig conformsToProtocol:@protocol(BaseConfigDataSource)] &&
        [_appConfig respondsToSelector:@selector(customBasicConfig)]) {
        _basicConfig = [[_appConfig performSelector:@selector(customBasicConfig)] createPrivateClass];
    }
    
    if ([_appConfig conformsToProtocol:@protocol(GameConfigDataSource)] &&
        [_appConfig respondsToSelector:@selector(customGameConfig)]) {
        _gameConfig = [[_appConfig performSelector:@selector(customGameConfig)] clone];
    }
}

@end

