//
//  EDStartRatingView.
//
//  Created by Ernesto Garcia on 26/02/12.
//  Copyright (c) 2012 cocoawithchurros.com All rights reserved.
//  Distributed under MIT license

#import "EDStarRating.h"

#define ED_DEFAULT_HALFSTAR_THRESHOLD   0.6


@interface EDStarRating()
@property (nonatomic,strong ) EDImage *tintedStarImage;
@property (nonatomic,strong ) EDImage *tintedStarHighlightedImage;
@property (nonatomic) CGColorRef backCGColor;
@end


@implementation EDStarRating

#pragma mark -
#pragma mark Init & dealloc


-(void)setDefaultProperties
{
    _minRating = 0.0;
    _maxRating = 5.0;
    _rating = 0.0;
    _horizontalMargin = 10.0;
    _displayMode = EDStarRatingDisplayFull;
    _halfStarThreshold = ED_DEFAULT_HALFSTAR_THRESHOLD;
    [self setBackgroundColor:[EDColor clearColor]];
    
}
#if  EDSTAR_MACOSX

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDefaultProperties];
    }
    
    return self;
}
#else
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        [self setDefaultProperties];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self )
    {
        [self setDefaultProperties];
    }
    return self;
}
#endif




#pragma mark -
#pragma mark Setters
-(void)setReturnBlock:(EDStarRatingReturnBlock)retBlock
{
    _returnBlock = [retBlock copy];
    _delegate = nil;
}

-(void)setDelegate:(id<EDStarRatingProtocol>)delegate
{
    _delegate = delegate;
    _returnBlock = nil;
}

-(void)setRating:(float)ratingParam
{
    _rating = ratingParam;
    [self setNeedsDisplay];
}

-(void)setDisplayMode:(EDStarRatingDisplayMode)dispMode
{
    _displayMode = dispMode;
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Drawing
-(CGPoint)pointOfStarAtPosition:(NSInteger)position highlighted:(BOOL)hightlighted
{
    CGSize size = hightlighted?_starHighlightedImage.size:_starImage.size;
    
    NSInteger starsSpace = self.bounds.size.width - 2*_horizontalMargin;
    
    NSInteger interSpace = 0;
    interSpace = _maxRating-1>0?(starsSpace - (_maxRating)*size.width)/(_maxRating-1):0;
    if( interSpace <0 )
        interSpace=0;
    CGFloat x = _horizontalMargin + size.width*position;
    if( position >0 )
        x+=interSpace*position;
    CGFloat y = (self.bounds.size.height - size.height)/2.0;
    return CGPointMake(x  ,y); 
}

-(void)drawBackgroundImage
{
    if( _backgroundImage )
    {
#if EDSTAR_MACOSX
        [backgroundImage drawInRect:self.bounds fromRect:NSMakeRect(0.0, 0.0, backgroundImage.size.width, backgroundImage.size.height) operation:NSCompositeSourceOver fraction:1.0];
        
#else
        [_backgroundImage drawInRect:self.bounds];
        
#endif
    }
    
}

-(void)drawImage:(EDImage*)image atPosition:(NSInteger)position
{
#if EDSTAR_MACOSX
    [image drawAtPoint:[self pointOfStarAtPosition:position highlighted:YES] fromRect:NSMakeRect(0.0, 0.0, image.size.width, image.size.height) operation:NSCompositeSourceOver fraction:1.0];

#else
    [image drawAtPoint:[self pointOfStarAtPosition:position highlighted:YES]];
    
#endif

}


-(void)setBackgroundColor:(EDColor *)color
{
#if EDSTAR_IOS
    [super setBackgroundColor:color];
#else
    _backgroundColor = color;
#endif
    if( color )
    {
        self.backCGColor = [self cgColor:color];
    }
}


-(CGColorRef)cgColor:(EDColor*)color
{
    CGColorRef cgColor = nil;
    
#if EDSTAR_MACOSX    
    NSInteger numberOfComponents = [color numberOfComponents];
    CGFloat components[numberOfComponents];

    CGColorSpaceRef colorSpace = [[color colorSpace] CGColorSpace];
    
    [color getComponents:(CGFloat *)&components];
    cgColor =  CGColorCreate(colorSpace, components);
    CGColorSpaceRelease(colorSpace);

#else
    cgColor  = color.CGColor;
#endif

    return cgColor;
}

-(CGContextRef)currentContext
{
    CGContextRef ctx=nil;
#if EDSTAR_MACOSX    
    NSGraphicsContext    *    nsGraphicsContext    = [NSGraphicsContext currentContext];
    ctx        = (CGContextRef) [nsGraphicsContext graphicsPort];
#else
    ctx = UIGraphicsGetCurrentContext();  
#endif
    return ctx;
}

-(void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGContextRef ctx = [self currentContext];  
    
    // Fill background color
    CGContextSetFillColorWithColor(ctx, self.backCGColor);
    CGContextFillRect(ctx, bounds);  
    
    // Draw background Image
    if( _backgroundImage )
    {
        [self drawBackgroundImage];
    }
    
    // Draw rating Images
    CGSize starSize = _starHighlightedImage.size;
    for( NSInteger i=0 ; i<_maxRating; i++ )
    {
        [self drawImage:self.tintedStarImage atPosition:i];
        if( i < _rating )   // Highlight
        {
            CGContextSaveGState(ctx);
            {
                if( i< _rating &&  _rating < i+1 )
                {
                    
                    CGPoint starPoint = [self pointOfStarAtPosition:i highlighted:NO];
                    float difference = _rating - i;
                    CGRect rectClip;
                    rectClip.origin = starPoint;
                    rectClip.size = starSize;
                    if( _displayMode == EDStarRatingDisplayHalf && difference < _halfStarThreshold )    // Draw half star image
                    {
                        rectClip.size.width/=2.0;
                    }
                    else if( _displayMode == EDStarRatingDisplayAccurate )
                    {
                        rectClip.size.width*=difference;
                    }
                    else {
                        rectClip.size.width = 0;
                    }
                    if( rectClip.size.width >0 )
                        CGContextClipToRect( ctx, rectClip);
                    
                }
                
                [self drawImage:self.tintedStarHighlightedImage atPosition:i];
            }
            CGContextRestoreGState(ctx);
        }
    }
    
}


#pragma mark -
#pragma mark Mouse/Touch Interaction
-(float) starsForPoint:(CGPoint)point
{
    float stars = _minRating;
    for( NSInteger i=stars; i<_maxRating; i++ )
    {
        CGPoint p =[self pointOfStarAtPosition:i highlighted:NO];
        if( point.x > p.x )
        {
            float increment=1.0;
            
            if( self.displayMode == EDStarRatingDisplayHalf  )
            {
                float difference = (point.x - p.x)/self.starImage.size.width;
                if( difference < self.halfStarThreshold )
                {
                    increment=0.5;
                }
            }
            stars+=increment;
        }
    }
    return stars;
}

#if EDSTAR_MACOSX
-(void)mouseDown:(NSEvent *)theEvent
{
    if( !editable )
        return;
    
    if ([theEvent type] == NSLeftMouseDown) {
        
        NSPoint pointInView   = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        
        self.rating = [self starsForPoint:pointInView];
        [self setNeedsDisplay];
    }

}
#else
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if( !_editable )
        return;

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.rating =[self starsForPoint:touchLocation];
    [self setNeedsDisplay];
}
#endif

#if EDSTAR_MACOSX
-(void)mouseDragged:(NSEvent *)theEvent
{
    if( !editable )
        return;
    
    NSPoint pointInView   = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    self.rating = [self starsForPoint:pointInView];
    [self setNeedsDisplay];
}
#else
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( !_editable )
        return;
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.rating =[self starsForPoint:touchLocation]; 
    [self setNeedsDisplay];
}

#endif

#if EDSTAR_MACOSX
- (void)mouseUp:(NSEvent *)theEvent
#else
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
#endif
{
    if( !_editable )
        return;
    
    if( self.delegate && [self.delegate respondsToSelector:@selector(starsSelectionChanged:rating:)] )
        [self.delegate starsSelectionChanged:self rating:self.rating];
    
    if( self.returnBlock)
        self.returnBlock(self.rating);
    
}


#pragma mark - Tint color Support
-(void)setStarImage:(EDImage *)image
{
    if( _starImage == image)
        return;
    
    _starImage = image;
    self.tintedStarImage = [self tintedImage:image];
}

-(void)setStarHighlightedImage:(EDImage *)image
{
    if( _starHighlightedImage == image )
        return;
    
    _starHighlightedImage = image;
    self.tintedStarHighlightedImage = [self tintedImage:image];

}
-(EDImage*)tintedImage:(EDImage*)img
{
    EDImage *tintedImage = img;
#if EDSTAR_IOS
    // Make sure tintColor is available (>= iOS 7.0 runtime)
    if( [self respondsToSelector:@selector(tintColor)] && img.renderingMode == UIImageRenderingModeAlwaysTemplate )
    {
        
        UIGraphicsBeginImageContextWithOptions(img.size, NO, [UIScreen mainScreen].scale );
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, img.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
        // draw alpha-mask
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextDrawImage(context, rect, img.CGImage);
        // draw tint color, preserving alpha values of original image
        CGContextSetBlendMode(context, kCGBlendModeSourceIn);
        [self.tintColor setFill];
        CGContextFillRect(context, rect);
        
        tintedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
#endif
    return tintedImage;
}
#if EDSTAR_IOS
-(void)tintColorDidChange
{
    self.tintedStarImage = [self tintedImage:self.starImage];
    self.tintedStarHighlightedImage = [self tintedImage:self.starHighlightedImage];
    [self setNeedsDisplay];
}
#endif

@end
