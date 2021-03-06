/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "FBTestManagerTestReporterComposite.h"

@interface FBTestManagerTestReporterComposite ()

@property (nonatomic, copy) NSArray<id<FBTestManagerTestReporter>> *reporters;

@end

@implementation FBTestManagerTestReporterComposite

+ (instancetype)withTestReporters:(NSArray<id<FBTestManagerTestReporter>> *)reporters
{
  return [[self alloc] initWithTestReporters:reporters];
}

- (instancetype)initWithTestReporters:(NSArray<id<FBTestManagerTestReporter>> *)reporters
{
  self = [super init];
  if (!self) {
    return nil;
  }

  _reporters = [reporters copy];

  return self;
}

#pragma mark -

- (void)testManagerMediatorDidBeginExecutingTestPlan:(FBTestManagerAPIMediator *)mediator
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediatorDidBeginExecutingTestPlan:mediator];
  }
}

- (void)testManagerMediator:(FBTestManagerAPIMediator *)mediator
                  testSuite:(NSString *)testSuite
                 didStartAt:(NSString *)startTime
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediator:mediator testSuite:testSuite didStartAt:startTime];
  }
}

- (void)testManagerMediator:(FBTestManagerAPIMediator *)mediator
    testCaseDidFinishForTestClass:(NSString *)testClass
                           method:(NSString *)method
                       withStatus:(FBTestReportStatus)status
                         duration:(NSTimeInterval)duration
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediator:mediator
        testCaseDidFinishForTestClass:testClass
                               method:method
                           withStatus:status
                             duration:duration];
  }
}

- (void)testManagerMediator:(FBTestManagerAPIMediator *)mediator
    testCaseDidFailForTestClass:(NSString *)testClass
                         method:(NSString *)method
                    withMessage:(NSString *)message
                           file:(NSString *)file
                           line:(NSUInteger)line
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediator:mediator
        testCaseDidFailForTestClass:testClass
                             method:method
                        withMessage:message
                               file:file
                               line:line];
  }
}

- (void)testManagerMediator:(FBTestManagerAPIMediator *)mediator
    testBundleReadyWithProtocolVersion:(NSInteger)protocolVersion
                        minimumVersion:(NSInteger)minimumVersion
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediator:mediator
        testBundleReadyWithProtocolVersion:protocolVersion
                            minimumVersion:minimumVersion];
  }
}

- (void)testManagerMediator:(FBTestManagerAPIMediator *)mediator
    testCaseDidStartForTestClass:(NSString *)testClass
                          method:(NSString *)method
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediator:mediator testCaseDidStartForTestClass:testClass method:method];
  }
}

- (void)testManagerMediator:(FBTestManagerAPIMediator *)mediator
        finishedWithSummary:(FBTestManagerResultSummary *)summary
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediator:mediator finishedWithSummary:summary];
  }
}

- (void)testManagerMediatorDidFinishExecutingTestPlan:(FBTestManagerAPIMediator *)mediator
{
  for (id<FBTestManagerTestReporter> reporter in self.reporters) {
    [reporter testManagerMediatorDidFinishExecutingTestPlan:mediator];
  }
}

@end
