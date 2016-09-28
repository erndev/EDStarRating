//
//  SampleViewController.m
//  SampleiOS
//
//  Created by Martin Pfannemüller on 02.01.16.
//
//

#import "SampleViewController.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[ [UIColor colorWithRed:0.11f green:0.38f blue:0.94f alpha:1.0f], [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f], [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f], [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f]];
    
    _starRating.backgroundColor  = [UIColor whiteColor];
    _starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayHalf;
    [_starRating  setNeedsDisplay];
    _starRating.tintColor = self.colors[0];
    [self starsSelectionChanged:_starRating rating:2.5];
    
    // Setup control using image
    _starRatingImage.backgroundImage=[UIImage imageNamed:@"starsbackground iOS.png"];
    _starRatingImage.starImage = [UIImage imageNamed:@"star.png"];
    _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"starhighlighted.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 12;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 2.5;
    _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
    // This one will use the returnBlock instead of the delegate
    __weak typeof(self) weakSelf = self;
    _starRatingImage.returnBlock = ^(float rating )
    {
        NSString *ratingString = [NSString stringWithFormat:@"Rating: %.1f", rating];
        weakSelf.starRatingLabelImage.text = ratingString;
    };
    
    // Example with image resizing
    // Setup control using image
    _starRatingImageLarge.starImage = [UIImage imageNamed:@"StarLargeEmpty.png"];
    _starRatingImageLarge.starHighlightedImage = [UIImage imageNamed:@"StarLarge.png"];
    _starRatingImageLarge.starSize = 20;
    _starRatingImageLarge.maxRating = 5.0;
    _starRatingImageLarge.delegate = self;
    _starRatingImageLarge.horizontalMargin = 12;
    _starRatingImageLarge.editable=YES;
    _starRatingImageLarge.rating= 2.5;
    _starRatingImageLarge.displayMode=EDStarRatingDisplayAccurate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)colorChanged:(id)sender
{
    UISegmentedControl *segmentedControl = sender;
    UIColor * color = self.colors[segmentedControl.selectedSegmentIndex];
    
    self.starRating.tintColor = color;
}

-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    NSString *ratingString = [NSString stringWithFormat:@"Rating: %.1f", rating];
    
    if(control == _starRating){
        _starRatingLabel.text = ratingString;
    }else if(control == _starRatingImage){
        _starRatingLabelImage.text = ratingString;
    }else if(control == _starRatingImageLarge){
        _starRatingLabelImageLarge.text = ratingString;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
