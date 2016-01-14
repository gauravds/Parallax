//
//  BasicConfig.h
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 06/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BasicConfig;

@protocol BaseConfigDataSource <NSObject>

- (BasicConfig *)customBasicConfig;

@end


@interface BasicConfig : NSObject <BaseConfigDataSource>

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong, setter=myAppVersion:) NSString *appVersion;
@property (nonatomic) NSInteger index;
@property (nonatomic) CGRect rect;

- (instancetype)createPrivateClass;

@end




