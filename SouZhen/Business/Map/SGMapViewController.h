//
//  SGMapViewController.h
//  SouZhen
//
//  Created by chenwang on 13-8-21.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGBaseHomeViewController.h"
#import "SGAnnotation.h"

@interface SGMapViewController : SGViewController

- (void)setAnnotations:(NSArray *)annotations;
- (void)addAnnotation:(SGAnnotation *)annotation;
- (void)removeAnnotationWithId:(NSString *)annotationId;

@end
