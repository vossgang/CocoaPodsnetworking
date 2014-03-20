//
//  MVMasterViewController.m
//  CocoaPods-Networking
//
//  Created by Matthew Voss on 3/17/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "MVMasterViewController.h"
#import "Song.h"
#import "MVDetailViewController.h"

@interface MVMasterViewController ()

@property (nonatomic, strong) NSMutableArray *songs;

@end

@implementation MVMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (MVDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self getSongsFromItunes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!self.songs) {
        self.songs = [[NSMutableArray alloc] init];
    }
    [self.songs insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Song *song = self.songs[indexPath.row];
    cell.textLabel.text = song.name;
    return cell;
}

-(void)getSongsFromItunes
{
    
    NSString *searchURLString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=blink-182"];
    
    NSURL *searchURL = [NSURL URLWithString:searchURLString];
    
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    
    NSDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil];
    
    NSMutableArray *tempSongs = [NSMutableArray new];
    
    for (NSDictionary *song in [searchDict objectForKey:@"results"]) {
        Song *downloadedSong = [[Song alloc] initWithJSON:song];
        [tempSongs addObject:downloadedSong];
    }
    self.songs = tempSongs;
    [self.tableView reloadData];

    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.songs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Song *song= self.songs[indexPath.row];
    self.detailViewController.song = song;
}

@end
