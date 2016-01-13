//
//  TableViewController.m
//  ParallaxEffect
//
//  Created by Gaurav Sharma on 12/01/16.
//  Copyright © 2016 ___iOS Technology___. All rights reserved.
//

#import "TableViewController.h"
#import "CustomTableViewCell.h"

@interface TableViewController () <UITableViewDataSource> {
    NSMutableArray *arrayTable;
    IBOutlet UITableView *tableView;
}
@property (assign, nonatomic) CATransform3D initialTransformation;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayTable = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [arrayTable addObject:@{@"title":[NSString stringWithFormat:@"title %d", i],
                                @"detail":@"Holi (pronunciation: /ˈhoʊliː/; Sanskrit: होली Holī) is a spring festival, also known as the festival of colours or the festival of love. It is an ancient Hindu religious festival which has become popular with non-Hindus in many parts of South Asia, as well as people of other communities outside Asia."}];
    }
    [tableView setBounces:NO];
}

- (IBAction)btnReloadTapped:(id)sender {
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CustomTableViewCell";
    CustomTableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellID];
    [cell loadData:arrayTable[indexPath.row]];
    return cell;
}

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    
    CGPoint center = cell.center;
    cell.center = CGPointMake(center.x, center.y + 500);
    cell.alpha = 0.1;
    
    [UIView animateWithDuration:.6
                          delay:0.01
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         cell.alpha = .8;
                         cell.center = CGPointMake(center.x, center.y - 10);
                     } completion:^(BOOL finished) {
                         cell.alpha = 1.;
                         cell.center = CGPointMake(center.x, center.y);
                     }];
    
    
    
//    //1. Setup the CATransform3D structure
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (0.0*M_PI)/180, 0.0, -0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
////    rotation = CATransform3DMakeRotation( 0, 0.0, 2.0, 0.0);
//    
//    //2. Define the initial state (Before the animation)
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
    
    //3. Define the final state (After the animation) and commit the animation
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
}

@end
