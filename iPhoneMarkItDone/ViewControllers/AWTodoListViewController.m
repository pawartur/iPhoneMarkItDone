//
//  AWTodoListViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWMarkItDoneAPIManager.h"
#import "AWFetchedResultsTableController.h"
#import "AWTodoListViewController.h"
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

@end
