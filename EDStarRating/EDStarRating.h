//
//  EDStarRating.
//
//  Created by Ernesto Garcia on 26/02/12.
//  2013 cocoawithchurros.com
//  Distributed under MIT license
//
//  Version 1.1


#import <Availability.h>
#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
#define EDSTAR_MACOSX 1
#define EDSTAR_IOS    0
#else
#define EDSTAR_MACOSX 0
#define EDSTAR_IOS    1
#endif



#if EDSTAR_MACOSX
#import <Cocoa/Cocoa.h>
#else
#import <UIKit/UIKit.h>
#endif


enum {
    EDStarRatingDisplayFull=0,
    EDStarRatingDisplayHalf,
    EDStarRatingDisplayAccurate
};
typedef NSUInteger EDStarRatingDisplayMode;
typedef void(^EDStarRatingReturnBlock)(float rating);
@protocol EDStarRatingProtocol;

#if EDSTAR_MACOSX
#define EDControl   NSControl
typedef NSColor     EDColor;
typedef NSImage     EDImage;
#else
#define EDControl   UIControl
typedef UIColor     EDColor;
typedef UIImage     EDImage;

#endif

@interface EDStarRating : EDControl

#if EDSTAR_MACOSX
@property (nonatomic,strong) EDColor *backgroundColor;
#endif
@property (nonatomic,strong) EDImage *backgroundImage;
@property (nonatomic,strong) EDImage *starHighlightedImage;
@property (nonatomic,strong) EDImage *starImage;
@property (nonatomic) NSInteger maxRating;
@property (nonatomic) float rating;
@property (nonatomic) CGFloat horizontalMargin;
@property (nonatomic) BOOL editable;
@property (nonatomic) EDStarRatingDisplayMode displayMode;
@property (nonatomic) float halfStarThreshold;

@property (nonatomic,weak) id<EDStarRatingProtocol> delegate;
@property (nonatomic,copy) EDStarRatingReturnBlock returnBlock;
@end


@protocol EDStarRatingProtocol <NSObject>

@optional
-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating;

@end

