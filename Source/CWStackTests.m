//
//  CWStackTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CWStackTests.h"
#import "CWStack.h"

@implementation CWStackTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicPush {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack1 = [[CWStack alloc] init];
	
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:array];
	
	[stack1 push:[array objectAtIndex:0]];
	[stack1 push:[array objectAtIndex:1]];
	[stack1 push:[array objectAtIndex:2]];
	[stack1 push:[array objectAtIndex:3]];
	
	STAssertTrue([[stack1 description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

-(void)testBasicEnumeration {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	__block NSInteger index = 0;
	
	[stack popToObject:@"This" withBlock:^(id obj) {
		if (index == 0) {
			STAssertTrue([(NSString *)obj isEqualToString:@"sentence"], @"strings should be equal");
			index++;
		} else if (index == 1) {
			STAssertTrue([(NSString *)obj isEqualToString:@"a"], @"strings should be equal");
			index++;
		} else if (index == 2) {
			STAssertTrue([(NSString *)obj isEqualToString:@"is"], @"strings should be equal");
			index++;
		} else {
			STAssertTrue(FALSE, @"should not get here");
		}
	}];
}

-(void)testClearStack {
	
	CWStack *stack1 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"one",@"and",@"two", nil]];
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"foo",@"bar",nil]];
	
	[stack1 clearStack];
	[stack2 clearStack];
	
	STAssertTrue([[stack1 description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

-(void)testBottomAndTopStackObjects {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	STAssertTrue([(NSString *)[stack bottomOfStackObject] isEqualToString:@"This"], @"Bottom stack object should be equal");
	STAssertTrue([(NSString *)[stack topOfStackObject] isEqualToString:@"sentence"], @"Top of stack object should be equal");
}

-(void)testPopToBottomOfStack {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	[stack popToBottomOfStack];
	
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"This"]];
	
	STAssertTrue([[stack description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end