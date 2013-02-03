//
//  EDStartRatingView.
//
//  Created by Ernesto Garcia on 26/02/12.
//  Copyright (c) 2012 cocoawithchurros.com All rights reserved.
//  Distributed under MIT license




//
//  ARC Helper
//
//  Version 1.2.1
//
//  Created by Nick Lockwood on 05/01/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://gist.github.com/1563325
//

#ifndef AH_RETAIN
#if __has_feature(objc_arc)
#define AH_RETAIN(x) (x)
#define AH_RELEASE(x)
#define AH_AUTORELEASE(x) (x)
#define AH_SUPER_DEALLOC
#else
#define __AH_WEAK
#define AH_WEAK assign
#define AH_RETAIN(x) [(x) retain]
#define AH_RELEASE(x) [(x) release]
#define AH_AUTORELEASE(x) [(x) autorelease]
#define AH_SUPER_DEALLOC [super dealloc]
#endif
#endif

//  Weak reference support

#ifndef AH_WEAK
#if defined __IPHONE_OS_VERSION_MIN_REQUIRED
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_4_3
#define __AH_WEAK __weak
#define AH_WEAK weak
#else
#define __AH_WEAK __unsafe_unretained
#define AH_WEAK unsafe_unretained
#endif
#elif defined __MAC_OS_X_VERSION_MIN_REQUIRED
#if __MAC_OS_X_VERSION_MIN_REQUIRED > __MAC_10_6
#define __AH_WEAK __weak
#define AH_WEAK weak
#else
#define __AH_WEAK __unsafe_unretained
#define AH_WEAK unsafe_unretained
#endif
#endif
#endif

//  ARC Helper ends


#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
#define EDSTAR_MACOSX 1
#define EDSTAR_IOS    0
#else
#define EDSTAR_MACOSX 0
#define EDSTAR_IOS    1
#endif

#if EDSTAR_MAC
#import <Cocoa/Cocoa.h>
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

@property (nonatomic,unsafe_unretained) id<EDStarRatingProtocol> delegate;
@property (nonatomic,copy) EDStarRatingReturnBlock returnBlock;
@end


@protocol EDStarRatingProtocol <NSObject>

@optional
-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating;

@end

