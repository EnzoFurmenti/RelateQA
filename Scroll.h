//
//  Scroll.h
//  Question-Answer
//
//  Created by EnzoF on 20.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol toucheUIVIewControlDelegate;

@interface Scroll : UIScrollView

@property(nonatomic, weak) id <toucheUIVIewControlDelegate> scrollDelegate;

@end


@protocol toucheUIVIewControlDelegate

@required
-(void)scrollTouchBegan:(Scroll*)scroll touches:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end
