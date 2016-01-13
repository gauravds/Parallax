//
//  CustomTableViewCell.m
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 12/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(NSDictionary*)data {
    self.title.text = data[@"title"];
    self.detail.text = data[@"detail"];
}

@end
