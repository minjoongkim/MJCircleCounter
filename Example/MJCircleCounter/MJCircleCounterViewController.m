//
//  MJCircleCounterViewController.m
//  MJCircleCounter
//
//  Created by minjoongkim on 08/08/2016.
//  Copyright (c) 2016 minjoongkim. All rights reserved.
//

#import "MJCircleCounterViewController.h"

@interface MJCircleCounterViewController ()

@end

@implementation MJCircleCounterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _circleCounter.delegate = self;
    _circleCounter.timerLabel = _lbl_second;
    
    [self.circleCounter startWithSeconds:60 remainTime:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)circleCounterTimeDidExpire:(MJCircleCounter *)circleCounter {
    //시간이 끝나면 OTP생성하는 함수 실행.
    NSLog(@"time end");
}
@end
