//
//  MJCircleCounterViewController.h
//  MJCircleCounter
//
//  Created by minjoongkim on 08/08/2016.
//  Copyright (c) 2016 minjoongkim. All rights reserved.
//

@import UIKit;
#import "MJCircleCounter.h"

@interface MJCircleCounterViewController : UIViewController <MJCircleCounterDelegate>

@property (retain, nonatomic) IBOutlet MJCircleCounter *circleCounter;
@property (retain) IBOutlet UILabel *lbl_second;

@end
