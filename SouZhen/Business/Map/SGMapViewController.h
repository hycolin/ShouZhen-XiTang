//
//  SGMapViewController.h
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGBaseHomeViewController.h"
#import "SGAnnotation.h"

typedef enum {
    MapTypeAll,
    MapTypeSingle,
} MapType;

@interface SGMapViewController : SGViewController

@property (nonatomic) MapType mapType;

- (void)setAnnotations:(NSArray *)annotations;
- (void)addAnnotation:(SGAnnotation *)annotation;
- (void)removeAnnotationWithId:(NSString *)annotationId;

@end
