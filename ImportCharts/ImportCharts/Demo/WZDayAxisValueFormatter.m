//
//  WZDayAxisValueFormatter.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZDayAxisValueFormatter.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZDayAxisValueFormatter()


@property (nonatomic, strong) BarLineChartViewBase *chatView;

@property (nonatomic, strong) NSArray *months;

@end

@implementation WZDayAxisValueFormatter

- (id)initForChart:(BarLineChartViewBase *)chart {
    self = [super init];
    if (self) {
        self.chatView = chart;
        self.months = [[NSArray alloc] initWithObjects:
                       @"Jan",@"Feb",@"Mar",
                       @"Apr",@"May",@"Jun",
                       @"Jul",@"Aug",@"Sep",
                       @"Oct",@"Nov",@"Dec",
                       nil];
    }
    
    return self;
}

#pragma mark - IChartAxisValueFormatter
- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return [NSString stringWithFormat:@"%d%%",(int)value];
}

@end
