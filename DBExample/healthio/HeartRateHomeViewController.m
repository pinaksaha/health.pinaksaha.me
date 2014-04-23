//
//  HeartRateHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "HeartRateHomeViewController.h"
#import "PSUSER.h"
#import "PSDBManager.h"
#import "PSUserHeartrate.h"
#import "PSHeartRateViewController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"


@interface HeartRateHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    SHLineGraphView *_lineGraph;
    UIScrollView *graphScrollView;
}

@end

@implementation HeartRateHomeViewController

@synthesize  db, user;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addHeartRateSegue"]) {
        // pass user object to home vc
        PSHeartRateViewController *homeVC = (PSHeartRateViewController *)segue.destinationViewController;
        homeVC.user = user;
        homeVC.db = db;
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
    self.HeartRateData.text = user.username;
    [user.heartRates removeAllObjects];
    [db getHeartRateByUserid:user];
    
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
    _lineGraph.yAxisSuffix = @"bpm";
    
    NSInteger maxHeartrate = 0;
    
    NSMutableArray *xAxisValues = [NSMutableArray array];
    for (int i = 1; i <= user.heartRates.count; i++) {
        [xAxisValues addObject:@{@(i): [NSMutableString stringWithFormat:@"%d", i]}];
    }
    _lineGraph.xAxisValues = xAxisValues;
    
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    NSMutableArray *plottingValues = [NSMutableArray array];
    for (int i = 0; i < user.heartRates.count; i++) {
        PSUserHeartrate *heartrate = user.heartRates[i];
        [plottingValues addObject:@{@(i+1): @(heartrate.bmp)}];
        if (heartrate.bmp > maxHeartrate) maxHeartrate = heartrate.bmp;
    }
    
    _lineGraph.yAxisRange = @((ceilf(maxHeartrate)/10)*10);
    
    _plot1.plottingValues = plottingValues;
    
    NSMutableArray *plottingPointLabels = [NSMutableArray array];
    for (int i = 1; i <= user.heartRates.count; i++)
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
    
    CGFloat scale = user.heartRates.count / 7.0;
    [_lineGraph setFrame:CGRectMake(0, 0, ceilf(self.view.bounds.size.width * scale), graphScrollView.bounds.size.height)];
    [graphScrollView setContentSize:_lineGraph.bounds.size];
    
    [_lineGraph setupTheView];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    ///
    
    UIView *parent = self.view.superview;
    [self.view removeFromSuperview];
    self.view = nil; // unloads the view
    [parent addSubview:self.view];
  
    //[user.heartRates removeAllObjects];
    //[db getHeartRateByUserid:user];
    //[super viewWillAppear:animated];
    //[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user.heartRates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeartRateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PSUserHeartrate *heartrate = user.heartRates[indexPath.row];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)heartrate.bmp]];
    
    NSString * dateTime = heartrate.createdAt;
    NSArray * timestamp = [dateTime componentsSeparatedByString:@" "];
    
    NSArray * date = [timestamp[0] componentsSeparatedByString:@"-"];
    //NSArray * time = [timestamp[1] componentsSeparatedByString:@":"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Date: %@/%@",date[1],date[2]]];
    
    return cell;
}

- (IBAction)makeNewEntry:(id)sender
{
    [self performSegueWithIdentifier:@"addHeartRateSegue" sender:user];
}
@end
