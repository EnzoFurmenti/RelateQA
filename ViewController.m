//
//  ViewController.m
//  Question-Answer
//
//  Created by EnzoF on 19.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"
#import "lineRelationQA.h"
#import "jsonData.h"
#import "Scroll.h"

@interface ViewController ()
@property(nonatomic, strong) UIView *questionsAnswerView;
@property(nonatomic, strong) Scroll *scroll;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) CGSize totalHeight;
@property(nonatomic, assign) double marginQA;
@property(strong,nonatomic) DrawingView *drawing;
@property(strong,nonatomic) DrawingView *setRelatedDrawing;
@property(strong,nonatomic) NSArray *arrayQ;
@property(strong,nonatomic) NSArray *arrayA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.size = CGSizeMake(300.f, 100.f);
    self.marginQA = 10.f;
    jsonData *json = [[jsonData alloc]init];
    
    NSArray *arrayQuestion = [[NSArray alloc]initWithArray:[json getArrayQAOfJSONDictionary:@"left"]];
    self.arrayQ = [self setPropertyForArrayObjects:arrayQuestion isQuestion:true];
    
    NSArray *arrayAnswer = [[NSArray alloc]initWithArray:[json getArrayQAOfJSONDictionary:@"right"]];
    self.arrayA = [self setPropertyForArrayObjects:arrayAnswer isQuestion:false];
    
    [self setSizeViewQA:self.arrayQ arrayA:self.arrayA];
    
    self.scroll = [[Scroll alloc]initWithFrame:CGRectMake(CGPointZero.x, CGPointZero.y, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scroll.backgroundColor = [UIColor grayColor];
    self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    [self.scroll setScrollDelegate:self];
    
    self.scroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.totalHeight.height);
    [self.view addSubview:self.scroll];
    
    
    self.questionsAnswerView = [[UIView alloc] initWithFrame:CGRectMake(CGPointZero.x, CGPointZero.y, self.view.bounds.size.width, self.totalHeight.height)];
    self.questionsAnswerView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.questionsAnswerView.backgroundColor = [UIColor greenColor];
    
    for (DrawingView *viewQ in self.arrayQ) {
        [self.scroll addSubview:viewQ];
    }
    for (DrawingView *viewA in self.arrayA) {
        [self.scroll addSubview:viewA];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray*) setPropertyForArrayObjects:(NSArray*)arrayQA isQuestion:(BOOL)isQuestion{
    CGPoint startPoint = CGPointZero;
    CGRect rect = CGRectMake(startPoint.x, startPoint.y, self.size.width, self.size.height);
    NSMutableArray *array = [[NSMutableArray alloc] init];

    if(isQuestion)
    {
        startPoint = CGPointMake(CGRectGetMaxX(self.view.bounds) - self.size.width, CGRectGetMinY(self.view.bounds));
    }
    
    for (NSString *string in arrayQA)
    {
        if (array.count > 0)
        {
            startPoint = CGPointMake(startPoint.x, startPoint.y + self.size.height +10.f);
        }
        rect = CGRectMake(startPoint.x, startPoint.y, self.size.width, self.size.height);
        DrawingView *drawing = [[DrawingView alloc] initWithFrame:rect];
        if (isQuestion) {
            drawing.isQuestion = true;
            drawing.currentRef = [NSString stringWithFormat:@"Q-%d", array.count + 1];
        }
        else
        {

            drawing.isQuestion = false;
            drawing.currentRef = [NSString stringWithFormat:@"A-%d", array.count + 1];
        }
        drawing.currentColor = [UIColor lightGrayColor];
        drawing.currentText = string;
        self.drawing = drawing;
        [array addObject:self.drawing];
    }
    if (array.count == 0)
    {
        array = nil;
    }
    
    return array;
}

- (void)setSizeViewQA:(NSArray *)arrayQ arrayA:(NSArray *)arrayA{
    CGSize sizeQ = CGSizeZero;
    CGSize sizeA = CGSizeZero;
    for (DrawingView *viewQ in arrayQ) {
        if (sizeQ.height == 0 && sizeQ.width == 0)
        {
            sizeQ = CGSizeMake(sizeQ.width , sizeQ.height + (arrayQ.count - 1) * self.marginQA);
        }
        sizeQ = CGSizeMake(sizeQ.width , sizeQ.height + viewQ.frame.size.height);
    }
    
    for (DrawingView *viewA in arrayA) {
        if (sizeA.height == 0 && sizeA.width == 0)
        {
            sizeA = CGSizeMake(sizeA.width , sizeA.height + (arrayA.count - 1) * self.marginQA);
        }
        sizeA = CGSizeMake(sizeA.width , sizeA.height + viewA.frame.size.height);
    }
    if(sizeQ.height >= sizeA.height)
    {
        self.totalHeight = CGSizeMake(self.view.bounds.size.width,sizeQ.height);
    }
    else
    {
        self.totalHeight = CGSizeMake(self.view.bounds.size.width,sizeA.height);
    }
    
    if(self.totalHeight.height <= self.view.bounds.size.height)
    {
        self.totalHeight= CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    }
}


-(UIColor*)randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}
-(void)setRelateColor:(DrawingView*)oneDrawingView twoDrawinView:(DrawingView*)twoDrawinView{
    if(!(oneDrawingView.isRelated  || twoDrawinView.isRelated))
    {
        UIColor *randColor = [self randomColor];
        oneDrawingView.currentColor = randColor;
        twoDrawinView.currentColor = randColor;
        
    }
    else
    {
        if(oneDrawingView.isRelated)
        {
            twoDrawinView.currentColor = oneDrawingView.currentColor;
            
        }
        else
        {
            oneDrawingView.currentColor = twoDrawinView.currentColor;
        }
    }
    
}
-(void)setRelate:(DrawingView*)oneDrawingView twoDrawinView:(DrawingView*)twoDrawinView{
    if(oneDrawingView.isRelated == twoDrawinView.isRelated)
    {
        // вывести сообщение : данный вопрос и ответ уже связаны
        [oneDrawingView setNeedsDisplay];
        [twoDrawinView setNeedsDisplay];
        self.setRelatedDrawing = nil;
    }
    else
    {
        if(oneDrawingView.isQuestion == twoDrawinView.isQuestion)
        {
             // вывести сообщение : связывать можно только вопрос и  ответ(вопрос и вопрос, либо ответ и ответ нельзя!!!)
            [oneDrawingView setNeedsDisplay];
            [twoDrawinView setNeedsDisplay];
            self.setRelatedDrawing = nil;
        }
        else
        {
            [self setRelateColor:oneDrawingView twoDrawinView:twoDrawinView];
            oneDrawingView.isRelated = true;
            twoDrawinView.isRelated = true;
            [oneDrawingView.refQA addObject:twoDrawinView.currentRef];
            [twoDrawinView.refQA addObject:oneDrawingView.currentRef];
            [oneDrawingView setNeedsDisplay];
            [twoDrawinView setNeedsDisplay];
            self.setRelatedDrawing = nil;
        }
    
    }
    
}

#pragma mark  -toucheUIVIewControlDelegate-
-(void)scrollTouchBegan:(Scroll*)scroll touches:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[DrawingView class]])
    {
        DrawingView *currentDrawingView = (DrawingView*)touch.view;
        if(!self.setRelatedDrawing)
        {
            if (!currentDrawingView.isRelated)
            {
                currentDrawingView.isSetRelated = true;
                currentDrawingView.currentColor = [UIColor redColor];
            }
            self.setRelatedDrawing = currentDrawingView;
            [currentDrawingView setNeedsDisplay];
        }
        else
        {
            [self setRelate:currentDrawingView twoDrawinView:self.setRelatedDrawing];
            
        
        }

    }
    
}



@end
