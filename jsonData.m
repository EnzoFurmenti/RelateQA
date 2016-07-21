//
//  jsonData.m
//  Question-Answer
//
//  Created by EnzoF on 19.07.16.
//  Copyright © 2016 EnzoF. All rights reserved.

#import "jsonData.h"

@interface jsonData()
// Название и тип файла ресурсов
#define  PATH_FOR_RESOURSE @"QuastionsAndAnswers"
#define  OF_TYPE_RESOURSE @"json"
// Адрес JSON-файла
#define URLstringFile @"http://balasdevserver.trinitydigital.ru/data"

//JSON-данные
@property(strong,nonatomic) NSDictionary *JSONDictionary;
@property(strong,nonatomic) NSData *data;
//@property(strong,nonatomic) NSString *str;
@end

@implementation jsonData : NSObject

- (NSData *)data{
    
    if(!_data)
        _data = [NSData new];
    return _data;
}

//Получить данных из файла ресурсов
//Возвращает nil или NSData
- (NSData *)getDataOfFileResource{
    //nil-указатель на объект NSError
    NSError *error = nil;
    //Указатель на NSData
    NSData *DatafromFileResource;
    
    //загрузка данных из сети
    //Возможно использовать данный способ загрузки файла при наличие сети
    //Не доработан индикатор прогресс-бар
    //[self getDataOfInet];
    DatafromFileResource =  self.data;
    //если данных нет
    if([DatafromFileResource bytes] == NULL || DatafromFileResource == nil)
    {
        //загрзука данных из файла ресурсов
        //
        //Получение директории к файлу (json) ресурсов
        NSString *PathFile = [[NSBundle mainBundle] pathForResource:PATH_FOR_RESOURSE ofType:OF_TYPE_RESOURSE];
        // Дирректоря файла существует?
        if(PathFile)
        {
            // Получение данных из файла ресурсов
            DatafromFileResource = [NSData dataWithContentsOfFile:PathFile options:0 error:&error];
            //Ошибка  в получении данных?
            if(error)
            {
                
                DatafromFileResource = nil;
                //Вывод ошибки
                NSLog(@"[JSONData getDatafromFileResource]:%@",[error localizedDescription]);
            }
        }
        else
        {
            NSLog(@"[JSONData getDatafromFileResource]:Не найден файл");
        }
    }
    
    return DatafromFileResource;
}
// Получение данных из сети
// Доработать!!!
- (void) getDataOfInet{
    /* NSURL *nsURL = [NSURL URLWithString:URLstringFile];
     NSURLRequest *nsURLrequest = [NSURLRequest requestWithURL:nsURL
     cachePolicy:NSURLRequestUseProtocolCachePolicy
     timeoutInterval:60.0];
     NSConnection *nsConnect = [NSURLConnection connectionWithRequest:nsURLrequest delegate:self];
     if (nsConnect)
     {
     self.data = [NSData data];*/
    self.data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"lllmlm"]];
    
    
    /* NSString *str;
     NSURLSessionConfiguration *Configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:Configuration];
     NSURLSessionDownloadTask *task;
     task = [session downloadTaskWithRequest:nsURLrequest completionHandler:^(NSURL * locationfile, NSURLResponse * response, NSError *  error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     self.data = [NSData dataWithContentsOfURL:locationfile];
     });
     }];
     [task resume];*/
    // }
    //  else
    //  {
    //     NSLog(@"Connection failed");
    // }
    
}


//Отложенная инициализация свойства "JSONDictionary"
- (NSDictionary *)JSONDictionary{
    //указатель на данные - nil?
    if(!_JSONDictionary)
    {
        //Создаем и иницилиазируем объект
        _JSONDictionary = [[NSDictionary alloc]init];
        // nil-указатель на NSError
        NSError *error = nil;
        //Данные из файла ресурсов
        NSData *DatafromFileResourse = [self getDataOfFileResource];
        //Если данных нет,
        if(!DatafromFileResourse)
        {
            _JSONDictionary = nil;
        }
        //иначе
        else
        {
            //Инициализуруем JSONDictionary
            _JSONDictionary = [NSJSONSerialization JSONObjectWithData:DatafromFileResourse options:0 error:&error];
            //Ошибка при NSJSONSerialization
            if(error)
            {
                _JSONDictionary = nil;
                NSLog(@"getJSONDictionary:%@",[error localizedDescription]);
            }
        }
    }
    return _JSONDictionary;
}

//Получение массива словарей вопросов и ответов
//По значению строки возвращает nil или NSArray
- (NSArray*)getArrayQAOfJSONDictionary:(NSString *)questionOrAnswer{
    //Объявление переменных
    NSArray *arrayQuestionOrAnswer;
    NSDictionary *JSONDictionary = self.JSONDictionary;
    //Если данных нет
    if(!JSONDictionary)
    {
        arrayQuestionOrAnswer = nil;
        NSLog(@"[JSONData getArrayQAOfJSONDictionary]:Нет данных");
    }
    //иначе
    else
    {
        NSDictionary *Dictionary = [JSONDictionary objectForKey:@"test"];
        arrayQuestionOrAnswer = [Dictionary objectForKey:questionOrAnswer];
    }
    return arrayQuestionOrAnswer;
}





@end
