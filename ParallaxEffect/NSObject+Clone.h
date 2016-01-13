//
//  NSObject+Clone.h
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 11/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Clone)

- (instancetype)clone;
- (void)copyValues:(id)objCopy;
- (void)setAccessibilityLabelsOnIVARs;

+ (NSArray*)getIVARsTillTargetClass:(Class)classNameTarget;


- (void)protocolMethodList:(Protocol*)p;
- (void)protertiesName;

@end
