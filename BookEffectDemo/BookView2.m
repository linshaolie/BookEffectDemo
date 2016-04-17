//
//  BookView2.m
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/17.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import "BookView2.h"
#import "utils.h"
#import "UIView+Extension.h"

@implementation BookView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)bookViewWithSize:(CGSize)size {
  BookView2 *bookView = (BookView2 *)[[NSBundle mainBundle] loadNibNamed:@"BookView2" owner:self options:nil][0];
  bookView.layer.shadowOffset = SIZE(0, 1);
  bookView.layer.shadowOpacity = 3;
  bookView.sl_width  = size.width;
  bookView.sl_height = size.height;
  return bookView;
}


- (void)setupWithModel:(NSDictionary *)model {
  self.titleLabel.text = model[@"title"];
  
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionTask *task = [session downloadTaskWithURL:[NSURL URLWithString:model[@"imageURL"]] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
      });
    }
  }];
  [task resume];
}

@end
