//
//  Scroll.m
//  Question-Answer
//
//  Created by EnzoF on 20.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "Scroll.h"
#import "DrawingView.h"

@implementation Scroll

-(id)init:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.scrollDelegate scrollTouchBegan:self touches:touches withEvent:event];
}

@end
