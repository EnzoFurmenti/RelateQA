//
//  jsonData.h
//  Question-Answer
//
//  Created by EnzoF on 19.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jsonData : NSObject

-(NSArray*) getArrayQAOfJSONDictionary:(NSString *)questionOrAnswer;

@end
