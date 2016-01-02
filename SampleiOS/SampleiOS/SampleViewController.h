//
//  SampleViewController.h
//  SampleiOS
//
//  Created by Martin Pfannemüller on 02.01.16.
//
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
@interface SampleViewController : UIViewController <EDStarRatingProtocol>

@property (nonatomic, strong) IBOutlet EDStarRating *starRating;
@property (nonatomic, strong) IBOutlet UILabel *starRatingLabel;
@property (nonatomic, strong) IBOutlet EDStarRating *starRatingImage;
@property (nonatomic, strong) IBOutlet UILabel *starRatingLabelImage;
@property (nonatomic, strong) IBOutlet EDStarRating *starRatingImageLarge;
@property (nonatomic, strong) IBOutlet UILabel *starRatingLabelImageLarge;
@property (nonatomic, copy) NSArray *colors;

@end
