//
//  AppDelegate.h
//  sample
//
//  Created by Ernesto Garcia  on 26/02/12.
//  Copyright (c) 2012 cocoawithchurros.com. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize starRatingImage=_starRatingImage;
@synthesize starRating=_starRating;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    // Insert code here to initialize your application
    _starRatingImage.backgroundImage=[NSImage imageNamed:@"starsbackground.png"];
    _starRatingImage.backgroundColor  = [NSColor clearColor];
    _starRatingImage.starImage = [NSImage imageNamed:@"star.png"];
    _starRatingImage.starHighlightedImage = [NSImage imageNamed:@"starhighlighted.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 12;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 2.5;
    _starRatingImage.displayMode=EDStarRatingDisplayFull;
    [_starRatingImage setTarget:self];
    [_starRatingImage  setNeedsDisplay];
    
    
    _starRating.backgroundColor  = [NSColor clearColor];
    _starRating.starImage = [NSImage imageNamed:@"star.png"];
    _starRating.starHighlightedImage = [NSImage imageNamed:@"starhighlighted.png"];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 12;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayFull;
    [_starRating setTarget:self];
    [_starRating  setNeedsDisplay];
    // This will use a return block to handle the rating changes
    // Setting the return block automatically nils the delegate
    _starRating.returnBlock = ^(float rating)
    {
        NSLog(@"Star Rating changed to %.1f" ,rating);
    };
    
    
    // Set the control size equal to the background image size
    NSRect frame =_starRatingImage.frame;
    frame.size = _starRatingImage.backgroundImage.size;
    [_starRatingImage setFrame:frame];
}

-(IBAction)editableChanged:(id)sender
{
    _starRatingImage.editable=[sender state];
    [_starRatingImage setNeedsDisplay];
    _starRating.editable=[sender state];
    [_starRating setNeedsDisplay];
}
-(IBAction)displayModeChanged:(id)sender
{
    NSInteger selectedMode = [sender selectedRow];
    _starRatingImage.displayMode= selectedMode;
    [_starRatingImage setNeedsDisplay];
    _starRating.displayMode=selectedMode;
    [_starRating setNeedsDisplay];
}
-(IBAction)ratingChanged:(id)sender
{
    NSSlider *slider = (NSSlider*)sender;
    _starRating.rating = [slider floatValue];
    _starRatingImage.rating = [slider floatValue];
}

@end
