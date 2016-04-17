//
//  BookView.m
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/16.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import "BookView.h"
#import "UIView+Extension.h"
#import "utils.h"

@implementation BookView

+ (instancetype)bookViewWithSize:(CGSize)size {
  BookView *bookView = (BookView *)[[NSBundle mainBundle] loadNibNamed:@"BookView" owner:self options:nil][0];
  bookView.layer.shadowOffset = SIZE(0, 1);
  bookView.layer.shadowOpacity = 3;
  bookView.sl_width  = size.width;
  bookView.sl_height = size.height;
  return bookView;
}

- (void)setupWithModel:(NSDictionary *)model {
  self.titleLabel.text = model[@"title"];
  self.backgroundColor = model[@"color"];
}
@end
