//
//  SearchBar.h
//  高仿花田小憩OC版aaaa
//
//  Created by Lee on 16/7/11.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;

@protocol SearchBarDelegate <NSObject>
- (void)searchBarDidCancel:(SearchBar *)searchBar;
- (void)searchBar:(SearchBar *)searchBar search:(NSString *)search;
@end


@interface SearchBar : UIView
@property(nonatomic, weak) id<SearchBarDelegate> delegate;
TextField_(filed)
- (void)clearText;
@end
