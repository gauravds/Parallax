//
//  GameConfig.h
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 06/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Clone.h"

@interface GameConfig : NSObject

@property (nonatomic, weak) NSString *gameName;
@property (nonatomic, weak) NSString *gameVersion;

- (instancetype)init;

@end


@protocol GameConfigDataSource <NSObject>
- (GameConfig*)customGameConfig;
@end