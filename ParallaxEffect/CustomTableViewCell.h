//
//  CustomTableViewCell.h
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 12/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *title, *detail;

- (void)loadData:(NSDictionary*)data;

@end
