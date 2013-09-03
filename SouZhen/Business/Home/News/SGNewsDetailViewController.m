//
//  SGNewsDetailViewController.m
//  SouZhen
//
//  Created by chenwang on 13-9-1.
//  Copyright (c) 2013年 songguo. All rights reserved.
//

#import "SGNewsDetailViewController.h"

@interface SGNewsDetailViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SGNewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"正文";

    float width = 296;
    float startX = 13;
    float startY = 14;
    NSString *newsTitle = self.news.title;
    UIFont *font = [UIFont systemFontOfSize:16];
    float titleHeight = ceilf([newsTitle sizeWithFont:font constrainedToSize:CGSizeMake(width, INT_MAX)].height);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY, width, titleHeight)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    label.text = newsTitle;
    label.textAlignment = UITextAlignmentLeft;
    label.font = font;
    [self.scrollView addSubview:label];
    
    startY += titleHeight + 10;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY, 150, 15)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:136/255.f green:136/255.f blue:136/255.f alpha:1];
    label.text = self.news.time;
    label.textAlignment = UITextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:label];
    
    startY += 15 + 13;
    
    NSString *content = self.news.content;
    int position = 0;
    do
    {
        NSRange range = [content rangeOfString:@"<img"];
        
        int endPosition;
        if (range.location == NSNotFound) {
            endPosition = content.length - 1;
        } else {
            endPosition = range.location;
        }
        if (position < endPosition) {
            NSString *str = [content substringToIndex:endPosition];
            
            UIFont *font = [UIFont systemFontOfSize:14];
            float titleHeight = ceilf([str sizeWithFont:font constrainedToSize:CGSizeMake(width, INT_MAX)].height);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY, width, titleHeight)];
            label.numberOfLines = 0;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:105/255.f green:105/255.f blue:105/255.f alpha:1];
            label.text = str;
            label.textAlignment = UITextAlignmentLeft;
            label.font = font;
            [self.scrollView addSubview:label];
            
            startY += titleHeight + 15;
            
            position = endPosition;
        }
        
        if (range.location != NSNotFound) {
            NSRange endRange = [content rangeOfString:@"/>"];
            if (endRange.location != NSNotFound) {
                int length = endRange.location - (range.location + range.length);
                NSString *imageName = [[content substringWithRange:(NSRange){range.location+range.length, length}] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                float imageHeight = width * image.size.height / image.size.width;
                imageView.frame = CGRectMake(startX, startY, width, imageHeight);
//                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self.scrollView addSubview:imageView];
                startY += imageHeight + 15;
                
                position = endRange.location + endRange.length;                
            }
        }
        if (position >= content.length - 1) {
            break;
        }
        content = [content substringFromIndex:position];
        position = 0;
    } while(YES);
    
    self.scrollView.contentSize = CGSizeMake(320, startY + 10);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
