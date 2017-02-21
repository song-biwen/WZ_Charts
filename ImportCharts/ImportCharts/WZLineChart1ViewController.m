//
//  WZLineChart1ViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/21.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZLineChart1ViewController.h"
#import "ImportCharts-Bridging-Header.h"


@interface WZLineChart1ViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *chatView;

@property (weak, nonatomic) IBOutlet UISlider *slideX;
@property (weak, nonatomic) IBOutlet UISlider *slideY;

@property (weak, nonatomic) IBOutlet UILabel *sliderTextX;
@property (weak, nonatomic) IBOutlet UILabel *sliderTextY;

@end

@implementation WZLineChart1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Line Chart 1";
    
    //设置代理
    self.chatView.delegate = self;
    
    //设置交互样式
    self.chatView.scaleYEnabled = NO;//取消Y轴缩放
    self.chatView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.chatView.dragEnabled = YES;//启用拖拽图标
    self.chatView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.chatView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系统（0~1），摩擦系数越小，惯性越不明显
    
    //设置X轴样式
    ChartXAxis *xAxis = self.chatView.xAxis;
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴的线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//设置X轴文字的位置
    xAxis.labelTextColor = [UIColor colorWithRed:(0X057748 & 0XFF0000 >> 16)/255.0 green:(0X057748 & 0XFF00 >> 8)/255.0  blue:(0X057748 & 0XFF)/255.0 alpha:1.0];//设置X轴文字的颜色
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    xAxis.spaceMin = 4;//设置label间距
    
    
    
    //设置Y轴样式
    self.chatView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *yAxis = self.chatView.leftAxis;
    yAxis.labelPosition = YAxisLabelPositionOutsideChart;//设置文字位置
    yAxis.labelTextColor = [UIColor colorWithRed:(0X057748 & 0XFF0000 >> 16)/255.0 green:(0X057748 & 0XFF00 >> 8)/255.0  blue:(0X057748 & 0XFF)/255.0 alpha:1.0];//设置文字颜色
    yAxis.labelFont = [UIFont systemFontOfSize:10];//设置文字大小
    yAxis.valueFormatter = [[NSNumberFormatter alloc] init];//自定义格式
    yAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置Y轴宽度
    yAxis.axisLineColor = [UIColor blackColor];//设置Y轴颜色
    yAxis.inverted = NO;//是否上下翻转
    yAxis.axisMaxValue = 105;//设置Y轴最大值
    yAxis.axisMinValue = 0;//设置Y轴最小值
    yAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    yAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    
    //设置Y轴的网格样式
    yAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//设置网格颜色
    yAxis.gridLineDashLengths = @[@3.0f,@3.0f];//设置虚线网格样式
    yAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    
    
    //添加限制线
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
    limitLine.lineWidth = 2.0;//设置线宽
    limitLine.lineColor = [UIColor greenColor];//设置颜色
    limitLine.lineDashLengths = @[@5.0f,@5.0f];//设置虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//设置文字位置
    limitLine.valueFont = [UIFont systemFontOfSize:12];//设置字体大小
    limitLine.valueTextColor = [UIColor colorWithRed:(0X057748 & 0XFF0000 >> 16)/255.0 green:(0X057748 & 0XFF00 >> 8)/255.0  blue:(0X057748 & 0XFF)/255.0 alpha:1.0];//设置文字颜色
    [yAxis addLimitLine:limitLine];//Y轴添加限制线
    yAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线在折现的后面
    
    
    //设置图例样式
    self.chatView.descriptionText = @"折线图";//设置描述字体
    self.chatView.descriptionTextColor = [UIColor darkGrayColor];//设置描述字体颜色
    self.chatView.legend.form = ChartLegendFormLine;//图例的样式
    self.chatView.legend.formSize = 30;//图例中线条的长度
    self.chatView.legend.textColor = [UIColor darkGrayColor];//图例文字颜色
    
    
    self.chatView.data = [self setData];
    [self.chatView animateWithXAxisDuration:1.0];
}

//为折线图设置数据
- (LineChartData *)setData{
    
    int xVals_count = 12;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:val y:i];
        [yVals addObject:entry];
    }
    
    LineChartDataSet *set1 = nil;
    if (self.chatView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.chatView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1.values = yVals;
        return data;
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"lineName"];
        //设置折线的样式
        set1.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[UIColor colorWithRed:(0X007FFF & 0XFF0000 >> 16)/255.0 green:(0X007FFF & 0XFF00 >> 8)/255.0  blue:(0X007FFF & 0XFF)/255.0 alpha:1.0]];//折线颜色
        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.circleRadius = 4.0f;//拐点半径
        set1.circleColors = @[[UIColor redColor], [UIColor greenColor]];//拐点颜色
        //拐点中间的空心样式
        set1.drawCircleHoleEnabled = YES;//是否绘制中间的空心
        set1.circleHoleRadius = 2.0f;//空心的半径
        set1.circleHoleColor = [UIColor blackColor];//空心的颜色
        //折线的颜色填充样式
        //第一种填充样式:单色填充
        //        set1.drawFilledEnabled = YES;//是否填充颜色
        //        set1.fillColor = [UIColor redColor];//填充颜色
        //        set1.fillAlpha = 0.3;//填充颜色的透明度
        //第二种填充样式:渐变填充
        set1.drawFilledEnabled = YES;//是否填充颜色
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fillAlpha = 0.3f;//透明度
        set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        
        //点击选中拐点的交互样式
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        set1.highlightColor = [UIColor colorWithRed:(0Xc83c23 & 0XFF0000 >> 16)/255.0 green:(0Xc83c23 & 0XFF00 >> 8)/255.0  blue:(0Xc83c23 & 0XFF)/255.0 alpha:1.0];//点击选中拐点的十字线的颜色
        set1.highlightLineWidth = 1.0/[UIScreen mainScreen].scale;//十字线宽度
        set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //添加第二个LineChartDataSet对象
        //        LineChartDataSet *set2 = [set1 copy];
        //        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        //        for (int i = 0; i < xVals_count; i++) {
        //            double mult = maxYVal + 1;
        //            double val = (double)(arc4random_uniform(mult));
        //            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:val xIndex:i];
        //            [yVals2 addObject:entry];
        //        }
        //        set2.yVals = yVals2;
        //        [set2 setColor:[UIColor redColor]];
        //        set2.drawFilledEnabled = YES;//是否填充颜色
        //        set2.fillColor = [UIColor redColor];//填充颜色
        //        set2.fillAlpha = 0.1;//填充颜色的透明度
        //        [dataSets addObject:set2];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];//文字字体
        [data setValueTextColor:[UIColor grayColor]];//文字颜色
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        //自定义数据显示格式
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setPositiveFormat:@"#0.0"];
        [data setValueFormatter:formatter];
        
        
        return data;
    }
    
}

#pragma mark - ChartViewDelegate

//点击选中折线拐点时回调
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
    NSLog(@"---chartValueSelected---value:");
}
//没有选中折线拐点时回调
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
    NSLog(@"---chartValueNothingSelected---");
}
//放大折线图时回调
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}
//拖拽折线图时回调
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
}

//option按钮点击事件
- (IBAction)optionButtonAction:(UIButton *)sender {
}

- (IBAction)sliderXValueChanged:(UISlider *)sender {
}

- (IBAction)sliderYValueChanged:(id)sender {
}


@end
