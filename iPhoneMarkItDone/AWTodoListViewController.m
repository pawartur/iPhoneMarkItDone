//
//  AWTodoListViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MFSideMenu.h"
#import "AWMarkItDoneAPIManager.h"
#import "AWToDoListFetchedResultsTableController.h"
#import "AWTodoListViewController.h"
#import "AWToDoFiltersViewController.h"
#import "AWCoolFooter.h"
#import "ToDo.h"
#import "ToDoList.h"
#import "ToDoContext.h"

@interface AWTodoListViewController (){
    BOOL _sideMenuInitialized;
}

@property (nonatomic, strong) AWToDoListFetchedResultsTableController *tableController;

@end

@implementation AWTodoListViewController

@synthesize tableController = _tableController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ToDos";
    AWMarkItDoneAPIManager *apiManager = [AWMarkItDoneAPIManager sharedManager];
    self.tableController = [apiManager fetchedResultsTableControllerForToDoListViewController:self];
    [self setupSideMenuBarButtonItem];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableController loadTable];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_sideMenuInitialized) {
        AWToDoFiltersViewController *sideMenuViewController = [[AWToDoFiltersViewController alloc] init];
        sideMenuViewController.delegate = self;
        [MFSideMenuManager configureWithNavigationController:self.navigationController sideMenuController:sideMenuViewController];
        _sideMenuInitialized = YES;
    }
}

-(void)viewController:(AWToDoFiltersViewController *)viewController didSelectToDoFilter:(id)toDoFilter{
    NSString *resourcePath = self.tableController.resourcePath;
    if ([toDoFilter isKindOfClass:[ToDoList class]]) {
        resourcePath = [resourcePath stringByAppendingQueryParameters:@{ @"todo_list" : ((ToDoList *)toDoFilter).objectId }];
    }else if ([toDoFilter isKindOfClass:[ToDoContext class]]){
        resourcePath = [resourcePath stringByAppendingQueryParameters:@{ @"todo_context" : ((ToDoContext *)toDoFilter).objectId }];
    }
    self.tableController.resourcePath = resourcePath;
    [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    [self.tableController loadTable];
}

@end
