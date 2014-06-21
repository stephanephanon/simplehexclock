//
//  StephaniesHexClockView.m
//  StephaniesHexClock
//
//  Created by Stephanie on 6/20/14.
//  using http://www.mactech.com/articles/mactech/Vol.21/21.07/SaveOurScreens102/index.html and http://www.thecolourclock.com/
//  probably the most memory-leaking, horribly written objective c ever made. :)
//

#import "StephaniesHexClockView.h"


@implementation StephaniesHexClockView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        // default is 1/30.0
        [self setAnimationTimeInterval:1/1.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    NSColor *color;
    float red, green, blue;
    
    // make a rectangle the size of the screen
    float width = [self bounds].size.width;
    float height = [self bounds].size.height;
    float x0 = NSMinX([self bounds]);
    float y0 = NSMinY([self bounds]);
    
    NSRect rectToDraw = NSMakeRect(x0, y0, width, height);
    
    // get the current time
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    // calculate a color and draw the rectangle
   
    // range has to be between 0 and 1 for the colors
    red = (255.0*((int)hour/24.0))/255.0;
    green = (255.0*((int)minute/60.0))/255.0;
    blue = (255.0*((int)second/60.0))/255.0;
   
    /*
    playing with different ways to display the color
    int allSeconds = (hour*60*60 + minute*60 + second)*388;
    
    NSString *hexValue=[NSString stringWithFormat:@"%06x", allSeconds]; 
    
    NSString *stringRR = [hexValue substringWithRange: NSMakeRange (0, 2)];
    NSString *stringGG = [hexValue substringWithRange: NSMakeRange (2, 2)];
    NSString *stringBB = [hexValue substringWithRange: NSMakeRange (4, 2)];
    
    unsigned resultRR = 0;
    unsigned resultGG = 0;
    unsigned resultBB = 0;
   
    NSScanner *scanner = [NSScanner scannerWithString:stringRR];
    [scanner scanHexInt:&resultRR]; 
    
    scanner = [NSScanner scannerWithString:stringGG];
    [scanner scanHexInt:&resultGG]; 
    
    scanner = [NSScanner scannerWithString:stringBB];
    [scanner scanHexInt:&resultBB]; 
    
    red = resultRR/255.0;
    green = resultGG/255.0;
    blue = resultBB/255.0;
    */ 
    
    color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1];
    
    [color set];
    
    [NSBezierPath fillRect:rectToDraw];   
    
    // make some text!!
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Futura" size:200], NSFontAttributeName,[NSColor whiteColor], NSForegroundColorAttributeName, nil];
    
    NSAttributedString * currentText=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second] attributes: attributes];
    
    [currentText drawAtPoint:NSMakePoint(width/5.0, height/3.0)];
 }

- (void)animateOneFrame
{
    [self setNeedsDisplay: YES];   
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
