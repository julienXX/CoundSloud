//
//  JBTrackListViewController.m
//  CoundSloud
//
//  Created by Julien Blanchard on 10/24/13.
//  Copyright (c) 2013 Julien Blanchard. All rights reserved.
//

#import "SCUI.h"
#import "JBTrackListViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface JBTrackListViewController ()

@end

@implementation JBTrackListViewController

@synthesize tracks;
@synthesize player;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
    NSString *image = @"";
    NSString *artworkUrl = [track objectForKey:@"artwork_url"];

    if ((NSNull *)artworkUrl == [NSNull null]) {
        NSDictionary *user = [track objectForKey:@"user"];
        NSString *avatarUrl = [user objectForKey:@"avatar_url"];
        image = avatarUrl;
    } else {
        image = artworkUrl;
    }

    UIImage *artwork = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
    
    cell.textLabel.text = [track objectForKey:@"title"];
    cell.imageView.image = artwork;cell.imageView.image = artwork;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
    NSString *streamURL = [track objectForKey:@"stream_url"];

    SCAccount *account = [SCSoundCloud account];
    
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:streamURL]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                 NSError *playerError;
                 player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
                 [player prepareToPlay];
                 [player play];
             }];
}

@end
