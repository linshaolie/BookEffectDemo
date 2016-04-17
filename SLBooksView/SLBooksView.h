//
//  SLBooksView.h
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/15.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"

NS_ASSUME_NONNULL_BEGIN

@class SLBooksView;

@protocol BooksViewDataSource <NSObject>

@required

- (PageView *)booksView:(SLBooksView *)booksView pageViewBeforePageView:(PageView *__nullable)pageView;

- (PageView *)booksView:(SLBooksView *)booksView pageViewAfterPageView:(PageView *)pageView;

- (NSInteger)numberOfPageInBooksView:(SLBooksView *)booksView;
@end


@interface SLBooksView : UIView

- (void)reloadData;

@property (nonatomic, weak, nullable) IBOutlet id <BooksViewDataSource> dataSource;
//@property (nonatomic, weak, nullable) id <BooksViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END