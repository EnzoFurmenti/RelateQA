//
//  DrawingView.h
//  Question-Answer
//
//  Created by EnzoF on 19.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView
@property (nonatomic, assign) BOOL isQuestion;
//@property (nonatomic, assign) CGPoint currentPointOrigin;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) NSString *currentText;
@property (nonatomic, strong) NSString *currentRef;
@property (nonatomic, strong) NSMutableSet *refQA;
@property (nonatomic, assign) BOOL isSetRelated;
@property (nonatomic, assign) BOOL isRelated;

//@property (nonatomic, assign) CGPoint currentPointOrigin;
@end
