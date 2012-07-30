//
//  AWTodoListViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWMarkItDoneAPIManager.h"
#import "AWTodoListViewController.h"
#import "AWCoolHeader.h"
#import "AWCoolFooter.h"
#import "ToDo.h"

@interface AWTodoListViewController ()

@property (nonatomic, strong) RKFetchedResultsTableController *tableController;

@end

@implementation AWTodoListViewController

@synthesize tableController = _tableController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ToDos";
    /**
    AWMarkItDoneAPIManager *apiManager = [AWMarkItDoneAPIManager sharedManager];
    self.tableController = [[apiManager objectManager] fetchedResultsTableControllerForTableViewController:self];
    self.tableController.autoRefreshFromNetwork = YES;
    self.tableController.pullToRefreshEnabled = YES;
    self.tableController.resourcePath = @"/todos";
    self.tableController.variableHeightRows = NO;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];
    self.tableController.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSBundle *restKitResources = [NSBundle restKitResourcesBundle];
    UIImage *arrowImage = [restKitResources imageWithContentsOfResource:@"blueArrow" withExtension:@"png"];
    [[RKRefreshTriggerView appearance] setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    [[RKRefreshTriggerView appearance] setLastUpdatedFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
    [[RKRefreshTriggerView appearance] setArrowImage:arrowImage];
    
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"ToDoCell";
    cellMapping.reuseIdentifier = @"ToDoCell";
    [cellMapping mapKeyPath:@"name" toAttribute:@"nameLabel.text"];
    
    [self.tableController mapObjectsWithClass:[ToDo class] toTableCellsWithMapping:cellMapping];
     **/
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.tableController loadTable];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AWCoolHeader *header = [[AWCoolHeader alloc] init];
    header.titleLabel.text = @"All";
    header.lightColor = [UIColor colorWithRed:0.0/255.0 green:123.0/255.0 blue:204.0/255.0 alpha:1.0];
    header.darkColor = [UIColor colorWithRed:0.0/255.0 green:123.0/255.0 blue:204.0/255.0 alpha:1.0];
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AWCoolFooter *footer = [[AWCoolFooter alloc] init];
    return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

@end
