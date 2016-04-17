//
//  PageView.h
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/17.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BookViewDelegate <NSObject>

@required
@property(nonatomic, readonly) NSInteger index;

@end

@interface PageView : UIView <BookViewDelegate>

@property(nonatomic, readonly) NSInteger index;

@end

NS_ASSUME_NONNULL_END