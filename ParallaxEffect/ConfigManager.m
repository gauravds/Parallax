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

@property (nonatomic, strong) BasicConfig *basicConfigOrignal, *basicConfigPrivate;
@property (nonatomic, strong) GameConfig *gameConfigOrignal, *gameConfigPrivate;

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

- (BasicConfig *)basicConfig {
//    if (!_basicConfigPrivate) {
//        _basicConfigPrivate = [BasicConfig new];
//    }
//    [_basicConfigPrivate copyValues:_basicConfigOrignal];
    return [_basicConfigOrignal clone];
}

- (GameConfig *)gameConfig {
//    if (!_gameConfigPrivate) {
//        _gameConfigPrivate = [GameConfig new];
//    }
//    [_gameConfigPrivate copyValues:_gameConfigOrignal];
    return [_gameConfigOrignal clone];
}

#pragma mark - Private Method
- (void)setAllDataOnce {
    _basicConfigOrignal = [[BasicConfig alloc] init];
    [self callDataSource];
}

- (void)callDataSource {
    AppConfig *appConfig = [AppConfig new];
    if ([appConfig conformsToProtocol:@protocol(BaseConfigDataSource)] &&
        [appConfig respondsToSelector:@selector(customBasicConfig)]) {
        _basicConfigOrignal = [[appConfig performSelector:@selector(customBasicConfig)] clone];
    }
    
    if ([appConfig conformsToProtocol:@protocol(GameConfigDataSource)] &&
        [appConfig respondsToSelector:@selector(customGameConfig)]) {
        _gameConfigOrignal = [[appConfig performSelector:@selector(customGameConfig)] clone];
    }
}


#pragma mark - Test method 
#pragma mark --temp -remove-it
- (void)testConfigProtocol {
    [self protocolMethodList:@protocol(BaseConfigDataSource)];
    [_basicConfigOrignal protertiesName];
    NSLog(@"----");
//    [ConfigManager sharedInstance].basicConfig.appName = @"test name";
//    [ConfigManager sharedInstance].gameConfig.gameName = @"test game name";
    NSLog(@"%@",[ConfigManager sharedInstance].basicConfig.appName);
//    NSLog(@"%@", [ConfigManager sharedInstance].basicConfig.appVersion);
//    NSLog(@"%d", [ConfigManager sharedInstance].basicConfig.index);
//    NSLog(@"%@", NSStringFromCGRect([ConfigManager sharedInstance].basicConfig.rect));
//    NSLog(@"%@", [ConfigManager sharedInstance].gameConfig.gameName);
//    NSLog(@"%@", [ConfigManager sharedInstance].gameConfig.gameVersion);
}

@end

