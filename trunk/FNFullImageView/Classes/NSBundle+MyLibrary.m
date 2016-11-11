//
//  NSBundle+MyLibrary.m
//  Pods
//
//  Created by JR on 16/8/16.
//
//

#import "NSBundle+MyLibrary.h"
#import "FNFullImageViewController.h"

@implementation NSBundle (MyLibrary)


+ (NSBundle *)myLibraryBundle {
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSURL *bundleUrl = [bundle URLForResource:@"FNFullImageView" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleUrl];
    return bundle;
}

@end
