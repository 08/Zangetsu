/*
//  CWLinkedList.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/26/12.
//  Copyright (c) 2012. All rights reserved.
//


Copyright (c) 2012 Colin Wheeler

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#import "CWLinkedList.h"

@interface CWLinkedListNode : NSObject
@property(nonatomic, retain) CWLinkedListNode *next;
@property(nonatomic, retain) id data;
@end

@implementation CWLinkedListNode

@synthesize next = _next;
@synthesize data = _data;

- (id)init
{
    self = [super init];
    if (self) {
        _next = nil;
		_data = nil;
    }
    return self;
}

@end

@interface CWLinkedList ()
@property(readwrite,assign) NSUInteger count;
@property(nonatomic,retain) CWLinkedListNode *head;
@property(nonatomic,weak) CWLinkedListNode *tail;
-(void)throwOutOfRangeException;
@end

@implementation CWLinkedList

@synthesize head = _head;
@synthesize tail = _tail;
@synthesize count = _count;

- (id)init
{
    self = [super init];
    if (self) {
        _head = nil;
		_tail = nil;
		_count = 0;
    }
    return self;
}

-(void)addObject:(id)anObject
{
	if(!anObject) { 
		CWDebugLog(@"Attempting to add nil object... exiting now");
		return;
	}
	
	CWLinkedListNode *node = [[CWLinkedListNode alloc] init];
	node.data = anObject;
	
	if (self.head) {
		self.tail.next = node;
		self.tail = node;
	} else {
		self.head = node;
		self.tail = node;
	}
	
	self.count++;
}

-(void)removeObjectAtIndex:(NSUInteger)index
{
	if(index > (self.count - 1))
		[self throwOutOfRangeException];
	
	if (index == 0) {
		if (self.count > 1) {
			self.head = self.head.next;
		} else {
			self.head = nil;
		}
		self.count--;
		return;
	}
	
	NSUInteger current = 0;
	CWLinkedListNode *node = self.head;
	while (current != ( index - 1 )) {
		node = node.next;
		current++;
	}
	
	CWLinkedListNode *nodeToBeRemoved = node.next;
	node.next = node.next.next;
	nodeToBeRemoved.next = nil;
	self.count--;
}

-(void)removeObject:(id)object
{
	if(!self.head) { return; }
	NSUInteger index = 0;
	NSUInteger max = (self.count - 1);
	CWLinkedListNode *currentNode = self.head;
	
	if ([currentNode.data isEqual:object]) {
		[self removeObjectAtIndex:0];
		return;
	}
	
	do {
		CWLinkedListNode *nextNode = currentNode.next;
		if ([nextNode.data isEqual:object]) {
			currentNode.next = currentNode.next.next;
			nextNode.next = nil;
			self.count--;
			return;
		}
		currentNode = currentNode.next;
		index++;
	} while ((index < max) && currentNode);
}

-(id)objectAtIndex:(NSUInteger)index
{
	if (!self.head)
		[self throwOutOfRangeException];
	
	NSUInteger current = 0;
	CWLinkedListNode *currentNode = self.head;
	
	while (current != index) {
		currentNode = currentNode.next;
		current++;
	}
	
	return currentNode.data;
}

-(void)throwOutOfRangeException
-(void)enumerateObjectsWithBlock:(void(^)(id object, BOOL *stop))block
{
	NSException *exception = [NSException exceptionWithName:@"CWLinkLinkInvalidRangeException"
	if(!self.head) { return; }
	BOOL shouldStop = NO;
	NSUInteger index = 0;
	NSUInteger max = self.count;
	CWLinkedListNode *currentNode = self.head;
	
	while ((index < max) && currentNode) {
		block(currentNode.data, &shouldStop);
		if(shouldStop == YES) { return; }
		currentNode = currentNode.next;
		index++;
	}
}

													 reason:@"Index out of bounds"
												   userInfo:nil];
	@throw exception;
}

@end
