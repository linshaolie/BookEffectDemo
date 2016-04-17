//
//  BookView2.h
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/17.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import "PageView.h"

@interface BookView2 : PageView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)bookViewWithSize:(CGSize)size;

- (void)setupWithModel:(NSDictionary *)model;
@end
