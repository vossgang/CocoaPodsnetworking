//
//  MVDetailViewController.h
//  CocoaPods-Networking
//
//  Created by Matthew Voss on 3/17/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

@interface MVDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Song *song;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
