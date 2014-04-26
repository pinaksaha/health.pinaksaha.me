//
//  BloodSugarHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "BloodSugarHomeViewController.h"
#import "PSBloodSugarViewController.h"
#import "PSUserBloodsugar.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
@interface BloodSugarHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    SHLineGraphView *_lineGraph;
    UIScrollView *graphScrollView;
}
@end

@implementation BloodSugarHomeViewController


@synthesize user,db;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addBloodSugarSegue"]) {
        // pass user object to home vc
        PSBloodSugarViewController *homeVC = (PSBloodSugarViewController *)segue.destinationViewController;
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
    [user.bloodSugars removeAllObjects];
    [db getBloodSugarByUserid:user];
    
    graphScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 300)];
    [graphScrollView setShowsHorizontalScrollIndicator:NO];
    
    _lineGraph = [[SHLineGraphView alloc] initWithFrame:graphScrollView.bounds];
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:12],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:12],
                                       kYAxisLabelSideMarginsKey : @12,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    _lineGraph.yAxisRange = @(300);
    _lineGraph.yAxisSuffix = @"mmol/L";
    
    NSInteger maxBlodSugarLevel = 0;
    // X vlaues
    NSMutableArray *xAxisValues = [NSMutableArray array];
    for (int i = 1; i <= user.bloodSugars.count; i++)
    {
        [xAxisValues addObject:@{@(i): [NSMutableString stringWithFormat:@"%d", i]}];
    }
    
    _lineGraph.xAxisValues = xAxisValues;
    
    SHPlot *_plot2 = [[SHPlot alloc] init];
    
    NSMutableArray *plottingValues = [NSMutableArray array];
    for (int i = 0; i < user.bloodSugars.count; i++) {
        PSUserBloodsugar *bloodSugars = user.bloodSugars[i];
        [plottingValues addObject:@{@(i+1): @(bloodSugars.bloodSugarLevel)}];
        if (bloodSugars.bloodSugarLevel > maxBlodSugarLevel) maxBlodSugarLevel = bloodSugars.bloodSugarLevel;
    }
    
    _lineGraph.yAxisRange = @((ceilf(maxBlodSugarLevel)/10)*10);
    
    _plot2.plottingValues = plottingValues;
    
    NSMutableArray *plottingPointLabels = [NSMutableArray array];
    for (int i = 1; i <= user.bloodSugars.count; i++)
    {
        [plottingPointLabels addObject:@(i)];
    }
    
    _plot2.plottingPointsLabels = plottingPointLabels;
    NSDictionary *_plotThemeAttributes = @{
                                           //kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot2.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot2];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [self.view addSubview:graphScrollView];
    [graphScrollView addSubview:_lineGraph];
    
    CGFloat scale = user.bloodSugars.count / 7.0;
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
    return [user.bloodSugars count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"bloodSugarCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PSUserBloodsugar * bloodSugar = user.bloodSugars[indexPath.row];
    
    //Clean up the time stamp
    
    NSString * dateTime = bloodSugar.createdAt;
    NSArray * timestamp = [dateTime componentsSeparatedByString:@" "];
    
    NSArray * date = [timestamp[0] componentsSeparatedByString:@"-"];
    NSArray * time = [timestamp[1] componentsSeparatedByString:@":"];
    
    //NSLog(@"M: %@ D:%@",date[1],date[2]);
    //NSLog(@"H: %@ M:%@",time[0],time[1]);
    //Display in cell
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)bloodSugar.bloodSugarLevel]];
    [cell.textLabel setText:[NSString stringWithFormat:@"Date: %@/%@ Time: %@:%@ ",date[1],date[2],time[0],time[1]]];
    return cell;
}


- (IBAction)addBloodSugarButton:(id)sender
{
    [self performSegueWithIdentifier:@"addBloodSugarSegue" sender:user];
}
@end
