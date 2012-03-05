//
//  AppDelegate.h
//  sample
//
//  Created by Ernesto Garcia  on 26/02/12.
//  Copyright (c) 2012 cocoawithchurros.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EDStarRating.h"
@interface AppDelegate : NSObject <NSApplicationDelegate,EDStarRatingProtocol>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet EDStarRating *starRatingImage;
@property (assign) IBOutlet EDStarRating *starRating;

-(IBAction)editableChanged:(id)sender;
-(IBAction)displayModeChanged:(id)sender;

@end
