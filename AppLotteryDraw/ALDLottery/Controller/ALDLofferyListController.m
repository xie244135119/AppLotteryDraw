//
//  ALDLofferyListController.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDLofferyListController.h"
#import "ALDImageInfoModel.h"
#import "ALDWaterfallLayout.h"
#import "ALDWaterfallLayoutCell.h"
#import <Masonry/Masonry.h>

NSString * const cellIdentifier = @"CellIdentifier";


@interface ALDLofferyListController ()<UICollectionViewDataSource, ALDWaterfallLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<ALDImageInfoModel *> *images;

@end

@implementation ALDLofferyListController


- (NSMutableArray *)images {
    //从plist文件中取出字典数组，并封装成对象模型，存入模型数组中
    if (!_images) {
        _images = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *imageDic in imageDics) {
            ALDImageInfoModel *image = [ALDImageInfoModel imageWithImageDic:imageDic];
            [_images addObject:image];
        }
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)initContentView {
    //创建瀑布流布局
    ALDWaterfallLayout *waterfall = [ALDWaterfallLayout waterFallLayoutWithColumnCount:3];
    //或者一次性设置
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        //设置代理，实现代理方法
    waterfall.delegate = self;
    /*
     //或者设置block
     [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
     //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
     XRImage *image = self.images[indexPath.item];
     return image.imageH / image.imageW * itemWidth;
     }];
     */
    //创建collectionView
   UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:waterfall];
    [collectionView  registerClass:[ALDWaterfallLayoutCell class] forCellWithReuseIdentifier:cellIdentifier];
    if (@available(iOS 11.0, *)){
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

- (void)click {
    [self.images removeAllObjects];
    [self.collectionView reloadData];
}


//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(ALDWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    ALDImageInfoModel *image = self.images[indexPath.item];
    return image.imageH / image.imageW * itemWidth;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        ALDWaterfallLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageURL = self.images[indexPath.item].imageURL;
    return cell;
}


@end
