//
//  WZColoredLineChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/28.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZColoredLineChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZColoredLineChartViewController ()
<ChartViewDelegate>

@property (strong, nonatomic) IBOutletCollection(LineChartView) NSArray *chartView;
@end

@implementation WZColoredLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < self.chartView.count; i ++) {
        LineChartData *data = [self dataWithCount:45 range:100];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.0]];
        
        NSArray *colors = @[
                            [UIColor colorWithRed:137/255.f green:230/255.f blue:81/255.f alpha:1.f],
                            [UIColor colorWithRed:240/255.f green:240/255.f blue:30/255.f alpha:1.f],
                            [UIColor colorWithRed:89/255.f green:199/255.f blue:250/255.f alpha:1.f],
                            [UIColor colorWithRed:250/255.f green:104/255.f blue:104/255.f alpha:1.f],
                            ];
        
        [self setupChart:self.chartView[i] data:data color:colors[i % self.chartView.count]];
        
    }
}


- (void)setupChart:(LineChartView *)chartView data:(LineChartData *)data color:(UIColor *)color {
    LineChartDataSet *set = (LineChartDataSet *)[data getDataSetByIndex:0];
    [set setCircleHoleColor:color];
    
    chartView.delegate = self;
    chartView.chartDescription.enabled = NO;
    chartView.drawGridBackgroundEnabled = NO;
    chartView.dragEnabled = YES;
    chartView.pinchZoomEnabled = NO;
    [chartView setScaleEnabled:YES];
    chartView.backgroundColor = color;
    [chartView setViewPortOffsetsWithLeft:10 top:0 right:10 bottom:0];
    
    chartView.legend.enabled = NO;
    
    chartView.xAxis.enabled = NO;
    chartView.leftAxis.enabled = NO;
    chartView.rightAxis.enabled = NO;
    
    chartView.data = data;
    
    [chartView animateWithXAxisDuration:2.5];
    
}

- (LineChartData *)dataWithCount:(int)count range:(double)range {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:arc4random_uniform(range) + 3]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:values];
    set1.lineWidth = 2.0;
    set1.circleRadius = 5.0;
    set1.circleHoleRadius = 2.5;
//    set1.drawCirclesEnabled = NO;
    [set1 setColor:[UIColor whiteColor]];
    [set1 setCircleColor:[UIColor whiteColor]];
    set1.highlightColor = [UIColor whiteColor];
    set1.drawValuesEnabled = NO;
    
    return [[LineChartData alloc] initWithDataSet:set1];
}


#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"%s",__func__);
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    NSLog(@"%s",__func__);
}
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    NSLog(@"%s",__func__);
}
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    NSLog(@"%s",__func__);
}
@end
