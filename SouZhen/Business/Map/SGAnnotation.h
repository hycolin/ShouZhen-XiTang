//
//  SGAnnotation.h
//  SouZhen
//
//  Created by chenwang on 13-8-24.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
    AnnotationTypeScenery,
    AnnotationTypeHotel,
    AnnotationTypeEntertainment
} AnnotationType;

@interface SGAnnotation : NSObject <MKAnnotation>

- (id)initWithId:(NSString *)uid
             lat:(double)lat
             lng:(double)lng
         address:(NSString *)address
           title:(NSString *)title
        subTitle:(NSString *)subTitle
       leftImage:(NSString *)leftImage
            type:(AnnotationType)type;

- (NSString *)uid;
- (NSString *)leftImage;
- (AnnotationType)type;
- (NSString *)address;

@end


@interface SGUserLocationForAnnotation : NSObject
<MKAnnotation>
{
	CLLocationCoordinate2D _coordinate;
}

//require property and method for MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (NSString*) title;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end

@interface SGUserLocationAnnotationView : MKAnnotationView {
	
}

- (id) initWithAnnotation:(id <MKAnnotation>) pAnnotation;

@end
