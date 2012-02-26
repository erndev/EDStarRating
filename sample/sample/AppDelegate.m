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
    
    // Insert code here to initialize your application
    _starRatingImage.backgroundImage=[NSImage imageNamed:@"starsbackground.png"];
    _starRatingImage.backgrounColor  = [NSColor clearColor];
    _starRatingImage.starImage = [NSImage imageNamed:@"star.png"];
    _starRatingImage.starHighlightedImage = [NSImage imageNamed:@"starhighlighted.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 12;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 1.4;
    _starRatingImage.drawHalfStars=YES;
    [_starRatingImage setTarget:self];
    [_starRatingImage  setNeedsDisplay];
    
    // Insert code here to initialize your application
    _starRating.backgrounColor  = [NSColor clearColor];
    _starRating.starImage = [NSImage imageNamed:@"star.png"];
    _starRating.starHighlightedImage = [NSImage imageNamed:@"starhighlighted.png"];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 12;
    _starRating.editable=YES;
    _starRating.rating= 1.4;
    _starRating.drawHalfStars=YES;
    [_starRating setTarget:self];
    [_starRating  setNeedsDisplay];

    
    // Set the control size equals to the background image size
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
-(IBAction)halfStarChanged:(id)sender
{
    _starRatingImage.drawHalfStars=[sender state];
    [_starRatingImage setNeedsDisplay];
    _starRating.drawHalfStars=[sender state];
    [_starRating setNeedsDisplay];
}
-(IBAction)ratingChanged:(id)sender
{
    NSSlider *slider = (NSSlider*)sender;
    _starRating.rating = [slider floatValue];
    _starRatingImage.rating = [slider floatValue];
}

@end
