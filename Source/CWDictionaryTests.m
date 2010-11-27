//
//  CWDictionaryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Zangetsu/Zangetsu.h>
#import "CWDictionaryTests.h"

@implementation CWDictionaryTests

/**
 Test for cw_dictionaryContainsKey to make sure it works properly. In this
 case it should return true for finding the object in the dictionary.
 */
-(void)testContainsKey
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	STAssertTrue([dictionary cw_dictionaryContainsKey:@"bar"],@"Dictionary should contain key bar");
}

@end