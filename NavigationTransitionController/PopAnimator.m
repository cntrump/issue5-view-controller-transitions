//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "PopAnimator.h"

@implementation PopAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *containerView = transitionContext.containerView;
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];

    CGFloat w = CGRectGetWidth(containerView.frame);
    toViewController.view.transform = CGAffineTransformMakeTranslation(-0.5 * w, 0);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation(w, 0);
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
