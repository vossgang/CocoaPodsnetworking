//
//  MVMasterViewController.h
//  CocoaPods-Networking
//
//  Created by Matthew Voss on 3/17/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVDetailViewController;

@interface MVMasterViewController : UITableViewController

@property (strong, nonatomic) MVDetailViewController *detailViewController;

@end
