//
//  JBTrackListViewController.h
//  CoundSloud
//
//  Created by Julien Blanchard on 10/24/13.
//  Copyright (c) 2013 Julien Blanchard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface JBTrackListViewController : UITableViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) AVAudioPlayer *player;

@end
