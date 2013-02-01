//
//  ViewController.m
//  SampleiOS
//
//  Created by Ernesto Garcia Carril on 22/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "EDStarRating.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;
@property (weak, nonatomic) IBOutlet UILabel *starRatingLabel;
@property (weak, nonatomic) IBOutlet EDStarRating *starRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *starRatingImageLabel;

@end

@implementation ViewController
@synthesize starRating=_starRating;
@synthesize starRatingLabel = _starRatingLabel;
@synthesize starRatingImage = _starRatingImage;
@synthesize starRatingImageLabel = _starRatingImageLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _starRating.backgroundColor  = [UIColor colorWithWhite:0.9 alpha:1.0];
    _starRating.starImage = [UIImage imageNamed:@"star.png"];
    _starRating.starHighlightedImage = [UIImage imageNamed:@"starhighlighted.png"];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayHalf;
    [_starRating  setNeedsDisplay];
    [self starsSelectionChanged:_starRating rating:2.5];

    
    _starRatingImage.backgroundImage=[UIImage imageNamed:@"starsbackground iOS.png"];
    _starRatingImage.starImage = [UIImage imageNamed:@"star.png"];
    _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"starhighlighted.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 12;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 2.5;
    _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
    [self starsSelectionChanged:_starRatingImage rating:2.5];
    // This one will use the returnBlock instead of the delegate
    _starRatingImage.returnBlock = ^(float rating )
    {
        NSLog(@"ReturnBlock: Star rating changed to %.1f", rating);
        // For the sample, Just reuse the other control's delegate method and call it
        [self starsSelectionChanged:_starRatingImage rating:rating];
    };


}

- (void)viewDidUnload
{
    [self setStarRating:nil];
    [self setStarRatingLabel:nil];
    [self setStarRatingImage:nil];
    [self setStarRatingImageLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    NSString *ratingString = [NSString stringWithFormat:@"Rating: %.1f", rating];
    if( [control isEqual:_starRating] )
        _starRatingLabel.text = ratingString;
    else
        _starRatingImageLabel.text = ratingString;
}

@end
