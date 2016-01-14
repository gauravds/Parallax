//
//  AppConfig.h
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 06/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "BasicConfig.h"
#import "GameConfig.h"
#import "ConfigManager.h"

@interface AppConfig : NSObject <BaseConfigDataSource, GameConfigDataSource>

@property (nonatomic, strong) NSString *appName;
- (void)hack;

@end
