//
//  MJCircleCounter.h
//  NativeApp
//
//  Created by 모바일보안팀 on 2016. 5. 17..
//  Copyright © 2016년 Kyuho Lee. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol MJCircleCounterDelegate;

@interface MJCircleCounter : UIView


@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *lastStartTime;

@property (assign, nonatomic) NSTimeInterval totalTime;

@property (assign, nonatomic) NSTimeInterval completedTimeUpToLastStop;


/// The receiver of all counter delegate callbacks.
@property (nonatomic, strong) id<MJCircleCounterDelegate> delegate;

/// 원의 색.
@property (nonatomic, strong) UIColor *circleColor;

/// 원의 배경색.
@property (nonatomic, strong) UIColor *circleBackgroundColor;

/// 안쪽원의 색
@property (nonatomic, strong) UIColor *circleFillColor;

/// 원의 두께.
@property (nonatomic, assign) CGFloat circleTimerWidth;

/// 시작했는지 알아보는 변수.
@property (nonatomic, assign, readonly) BOOL isStart;

/// 돌아가고 있는지 알아보는 변수.
@property (nonatomic, assign, readonly) BOOL isRunning;

/// 끝났는지 알아보는 함수.
@property (nonatomic, assign, readonly) BOOL isFinish;

/// The amount of time that the timer has completed. It takes into account any stops/resumes
/// and is updated in real time.
@property (assign, nonatomic, readonly) NSTimeInterval elapsedTime;

//남은 시간을 보여주는 label
@property (nonatomic, strong) UILabel *timerLabel;
//시작하는 함수.
- (void)startWithSeconds:(NSInteger)seconds remainTime:(NSInteger)remainTime;
//멈추는 함수.
- (void)stop;
//resume 하는 함수.
- (void)resume;
//reset 하는 함수.
- (void)reset;

@end

@protocol MJCircleCounterDelegate <NSObject>

@optional
//끝나면 호출하는 함수.
- (void)circleCounterTimeDidExpire:(MJCircleCounter *)circleCounter;

@end


