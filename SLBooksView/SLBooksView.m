//
//  SLBooksView.m
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/15.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import "SLBooksView.h"
#import "UIView+Extension.h"

@interface SLBooksView ()
{
  PageView *_preView, *_nextView, *_activeView;
  NSInteger _numberOfPages;
}
@property(nonatomic, strong) PageView *curView;

@end

@implementation SLBooksView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initialize];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self initialize];
}

- (void)initialize {
  [self addGestures];
  
  _numberOfPages = 0;
}

- (void)reloadData {
  _numberOfPages = [_dataSource numberOfPageInBooksView:self];
  _preView = _nextView = _activeView = nil;
  self.curView = [_dataSource booksView:self pageViewBeforePageView:_curView];
}

#pragma mark - setter

- (void)setDataSource:(id<BooksViewDataSource>)dataSource {
  if (_dataSource != dataSource) {
    _dataSource = dataSource;
    if (_numberOfPages == 0) {
      _curView = nil;
    } else {
      self.curView = [_dataSource booksView:self pageViewBeforePageView:_curView];
    }
  }
}

- (void)setCurView:(PageView *)curView {
  if (_curView != curView) {
    _curView = curView;
    
    if (curView.index > 0) {
      _preView  = [_dataSource booksView:self pageViewBeforePageView:curView];
    } else {
      _preView = nil;
    }
    
    if (curView.index < _numberOfPages - 1) {
      _nextView = [_dataSource booksView:self pageViewAfterPageView:curView];
    } else {
      _nextView = nil;
    }
    
    [_preView setValue:@(_curView.index - 1) forKey:@"index"];
    [_nextView setValue:@(_curView.index + 1) forKey:@"index"];
    
    _nextView.sl_x = _curView.sl_x = 0;
    _preView.sl_x  = -_preView.sl_width;
    
    [self addSubview:_nextView];
    [self addSubview:_curView];
    [self addSubview:_preView];
  }
}

#pragma mark - private method

- (void)addGestures {
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
  [self addGestureRecognizer:panGesture];
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)panGesture {
  CGPoint point = [panGesture translationInView:self];
  
  if (point.x == 0) {
    if (panGesture.state == UIGestureRecognizerStateEnded ||
        panGesture.state == UIGestureRecognizerStateCancelled) {
      if (!_activeView) {
        return;
      }
      if ([panGesture velocityInView:self].x < 0) {
        [UIView animateWithDuration:0.3 animations:^{
          _activeView.sl_x = -_activeView.sl_width;
        } completion:^(BOOL finished) {
          if (_activeView != _preView) {
            self.curView = _nextView;
          }
        }];
      } else {
        [UIView animateWithDuration:0.3 animations:^{
          _activeView.sl_x = 0;
        } completion:^(BOOL finished) {
          if (_activeView != _curView) {
            self.curView = _preView;
          }          
        }];
      }
    }
    return;
  }

  if(point.x < 0) {
    if (_activeView != _curView &&
        _activeView.sl_x <= -_activeView.sl_width) {
      _activeView.sl_x = -_activeView.sl_width;
      _activeView = _curView;
    }
    if (panGesture.state == UIGestureRecognizerStateBegan) {
      _activeView = _curView;
    }
    if (!_nextView && _activeView == _curView) {
      return;
    }
  } else {
    if (_activeView != _preView && _activeView.sl_x >= 0) {
      _activeView.sl_x = 0;
      _activeView = _preView;
    }
    if (panGesture.state == UIGestureRecognizerStateBegan) {
      _activeView = _preView;
    }
  }
  
  _activeView.center = CGPointMake(_activeView.center.x + point.x, _activeView.center.y);
  [panGesture setTranslation:CGPointZero inView:_activeView];
}

@end
