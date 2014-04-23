//
//  WeightHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "WeightHomeViewController.h"
#import "PSWeightViewController.h"
#import "PSUserweight.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
@interface WeightHomeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    SHLineGraphView *_lineGraph;
    UIScrollView *graphScrollView;
}

@end

@implementation WeightHomeViewController 

@synthesize user,db;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addWeightSegue"]) {
        // pass user object to home vc
        PSWeightViewController *homeVC = (PSWeightViewController *)segue.destinationViewController;
        homeVC.user = self.user;
        homeVC.db = self.db;
    }
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [user.weights removeAllObjects];
    [db getWeightByUserid:user];
    
    //CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
    
    graphScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 300)];
    [graphScrollView setShowsHorizontalScrollIndicator:NO];
    
    _lineGraph = [[SHLineGraphView alloc] initWithFrame:graphScrollView.bounds];
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelSideMarginsKey : @10,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    _lineGraph.yAxisRange = @(300);
    _lineGraph.yAxisSuffix = @"LB";
    
    NSInteger maxWeights = 0;
    
    NSMutableArray *xAxisValues = [NSMutableArray array];
    for (int i = 1; i <= user.weights.count; i++) {
        [xAxisValues addObject:@{@(i): [NSMutableString stringWithFormat:@"%d", i]}];
    }
    _lineGraph.xAxisValues = xAxisValues;
    
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    NSMutableArray *plottingValues = [NSMutableArray array];
    for (int i = 0; i < user.weights.count; i++) {
        PSUserweight *weights = user.weights[i];
        [plottingValues addObject:@{@(i+1): @(weights.weight)}];
        if (weights.weight > maxWeights) maxWeights = weights.weight;
    }
    
    _lineGraph.yAxisRange = @((ceilf(maxWeights)/10)*10);
    
    _plot1.plottingValues = plottingValues;
    
    NSMutableArray *plottingPointLabels = [NSMutableArray array];
    for (int i = 1; i <= user.weights.count; i++)
    {
        [plottingPointLabels addObject:@(i)];
    }
    
    _plot1.plottingPointsLabels = plottingPointLabels;
    NSDictionary *_plotThemeAttributes = @{
                                           //kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [self.view addSubview:graphScrollView];
    [graphScrollView addSubview:_lineGraph];
    
    CGFloat scale = user.weights.count / 7.0;
    [_lineGraph setFrame:CGRectMake(0, 0, ceilf(self.view.bounds.size.width * scale), graphScrollView.bounds.size.height)];
    [graphScrollView setContentSize:_lineGraph.bounds.size];
    
    [_lineGraph setupTheView];
}

- (void)viewWillAppear:(BOOL)animated
{
   
    UIView *parent = self.view.superview;
    [self.view removeFromSuperview];
    self.view = nil; // unloads the view
    [parent addSubview:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user.weights count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"weightCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PSUserweight * Weights = user.weights[indexPath.row];
    NSString * dateTime = Weights.timeStamp;
    NSArray * timestamp = [dateTime componentsSeparatedByString:@" "];
    
    NSArray * date = [timestamp[0] componentsSeparatedByString:@"-"];
    //NSArray * time = [timestamp[1] componentsSeparatedByString:@":"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Date: %@/%@",date[1],date[2]]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)Weights.weight]];
    
    return cell;
}



- (IBAction)addWeightButton:(id)sender
{
    [self performSegueWithIdentifier:@"addWeightSegue" sender:user];
}
@end
