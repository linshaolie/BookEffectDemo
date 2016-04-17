//
//  BookView.h
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/16.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"

@interface BookView : PageView

@property(nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)bookViewWithSize:(CGSize)size;

- (void)setupWithModel:(NSDictionary *)model;
@end
