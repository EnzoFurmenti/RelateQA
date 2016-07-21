//
//  DrawingView.m
//  Question-Answer
//
//  Created by EnzoF on 19.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//-(id)initWithCoder:(NSCoder *)aDecoder
//
//
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //[super drawRect:rect]
    CGRect r = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - rect.size.height/2, rect.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor);
    CGContextAddRect(context, r);
    CGContextFillPath(context);
    
    NSString * text = self.currentText;
    CGPoint textPoint = CGPointMake(CGRectGetMinX(rect) + 5.f,CGRectGetMidY(rect));
    UIFont *font = [UIFont systemFontOfSize:26.f];

    NSShadow *shadowText = [[NSShadow alloc] init];
    shadowText.shadowOffset = CGSizeMake(1, 1);
    shadowText.shadowColor = [UIColor grayColor];
    shadowText.shadowBlurRadius = 1.5;

    NSDictionary *fontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor], NSForegroundColorAttributeName,
                                    font, NSFontAttributeName,
                                    shadowText, NSShadowAttributeName, nil];

    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    CGRect textRect = CGRectMake(textPoint.x, textPoint.y, textSize.width, textSize.height);
    textRect = CGRectIntegral(textRect);

    CGContextFillPath(context);
    [text drawInRect:textRect withAttributes:fontAttributes];
    CGPoint point = CGPointZero;
    CGPoint point1 = CGPointZero;
    if(self.isQuestion)
    {
        point =  CGPointMake(CGRectGetMinX(r), CGRectGetMinY(r));
        point1 = CGPointMake(point.x - r.size.height/2, point.y + r.size.height/2);
        
    }
    else
    {
        point =  CGPointMake(CGRectGetMaxX(r), CGRectGetMinY(r));
        point1 = CGPointMake(point.x + r.size.height/2, point.y + r.size.height/2);
    }
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor);
    CGContextSetLineWidth(context, 5.f);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point1.x,point1.y);
    CGContextAddLineToPoint(context, point.x, point.y + r.size.height);
    CGContextAddLineToPoint(context, point.x,point.y);
    
   
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddArc(context, CGRectGetMaxX(rect) -10.f, CGRectGetMidY(rect), 10.f, 0, M_PI * 2, YES);
    CGContextFillPath(context);
    
}






@end
