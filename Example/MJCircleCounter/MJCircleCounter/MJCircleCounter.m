//
//  MJCircleCounter.m
//  NativeApp
//
//  Created by 모바일보안팀 on 2016. 5. 17..
//  Copyright © 2016년 Kyuho Lee. All rights reserved.
//

#import "MJCircleCounter.h"

@interface MJCircleCounter()

@end

@implementation MJCircleCounter
@synthesize timerLabel;

- (void)baseInit {
    self.circleColor = [UIColor redColor];
    self.circleBackgroundColor = [UIColor grayColor];
    self.circleFillColor = [UIColor clearColor];
    self.circleTimerWidth = 35.0f;
    
    self.completedTimeUpToLastStop = 0;
    _elapsedTime = 0;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    
    return self;
}

- (void)startWithSeconds:(NSInteger)seconds remainTime:(NSInteger)remainTime{
    
    self.totalTime = seconds;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(timerFired)
                                                userInfo:nil
                                                 repeats:YES];
    
    _isRunning = YES;
    _isStart = YES;
    _isFinish = NO;
    
    self.lastStartTime = [NSDate dateWithTimeIntervalSinceNow:0];
    self.completedTimeUpToLastStop = remainTime;
    _elapsedTime = 0;
    
    [self.timer fire];
}

- (void)timerFired {
    if (!_isRunning) {
        return;
    }
    
    _elapsedTime = (self.completedTimeUpToLastStop +
                    [[NSDate date] timeIntervalSinceDate:self.lastStartTime]);
    
    // Check if timer has expired.
    if (self.elapsedTime > self.totalTime) {
        [self timerCompleted];
    }
    
    timerLabel.text = [NSString stringWithFormat:@"%li", (long)ceil(_totalTime - _elapsedTime)];
    
    [self setNeedsDisplay];
}

- (void)resume {
    _isRunning = YES;
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    self.lastStartTime = now;
    [self.timer setFireDate:now];
}

- (void)stop {
    _isRunning = NO;
    
    self.completedTimeUpToLastStop += [[NSDate date] timeIntervalSinceDate:self.lastStartTime];
    _elapsedTime = self.completedTimeUpToLastStop;
    
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)reset {
    [self.timer invalidate];
    self.timer = nil;
    
    _elapsedTime = 0;
    _isRunning = NO;
    _isStart = NO;
    _isFinish = NO;
}


- (void)timerCompleted {
    [self.timer invalidate];
    
    _isRunning = NO;
    _isFinish = YES;
    
    _elapsedTime = self.totalTime;
    
    if ([self.delegate respondsToSelector:@selector(circleCounterTimeDidExpire:)]) {
        [self.delegate circleCounterTimeDidExpire:self];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat radius = CGRectGetWidth(rect)/2.0f - self.circleTimerWidth/2.0f;
    CGFloat angleOffset = M_PI_2;
    
    // Draw the background of the circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);
    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    0 - M_PI_2,
                    M_PI + M_PI_2,
                    0);
    CGContextSetStrokeColorWithColor(context, [self.circleBackgroundColor CGColor]);
    CGContextSetFillColorWithColor(context, [self.circleFillColor CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // Draw the remaining amount of timer circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);
    CGFloat startAngle = (((CGFloat)self.elapsedTime) / (CGFloat)self.totalTime)*M_PI*2;
    
    if (!_isRunning && !_isStart && !_isFinish) {
        // If the timer hasn't started yet, fill the whole circle. (startAngle will be NaN)
        startAngle = 0;
    }
    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    startAngle - angleOffset,
                    2*M_PI - angleOffset,
                    0);
    CGContextSetStrokeColorWithColor(context, [self.circleColor CGColor]);
    CGContextStrokePath(context);
    
}

@end
