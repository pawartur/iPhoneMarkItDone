//
//  AWTodoListViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MFSideMenu.h"
#import "AWMarkItDoneAPIManager.h"
#import "AWFetchedResultsTableController.h"
#import "AWTodoListViewController.h"
#import "AWToDoFiltersViewController.h"
#import "AWCoolFooter.h"
#import "ToDo.h"

@interface AWTodoListViewController ()

@property (nonatomic, strong) AWFetchedResultsTableController *tableController;

@end

@implementation AWTodoListViewController

@synthesize tableController = _tableController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ToDos";
    AWMarkItDoneAPIManager *apiManager = [AWMarkItDoneAPIManager sharedManager];
    self.tableController = [apiManager fetchedResultsTableControllerForToDoListViewController:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableController loadTable];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AWToDoFiltersViewController *sideMenuViewController = [[AWToDoFiltersViewController alloc] init];
    UINavigationController *nc = self.navigationController;
    [MFSideMenuManager configureWithNavigationController:self.navigationController sideMenuController:sideMenuViewController];
    [self setupSideMenuBarButtonItem];
}

@end
