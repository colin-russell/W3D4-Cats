//
//  ViewController.m
//  W3D4 Cats
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CatCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *photoObjects;
@property (weak, nonatomic) IBOutlet UICollectionView *catCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoObjects = [NSMutableArray new];
    [self setupCollectionView];
    [self flickrNSURLsetup];

}

- (void)setupCollectionView {
    self.catCollectionView.dataSource = self;
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(150, 100);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 5, 20);
    flowLayout.headerReferenceSize = CGSizeMake(0, 22);
    
    [self.catCollectionView setCollectionViewLayout:flowLayout];
}

#pragma mark -NSURL GET

- (void)flickrNSURLsetup {
    NSURL *flickrCatUrl = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=178d9e3064aa836a8bac2c18eea8957e&tags=cat"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:flickrCatUrl];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *flickrDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *photoDict = flickrDict[@"photos"][@"photo"];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        for (NSDictionary *dict in photoDict) {
            Photo *photo = [[Photo alloc] initWithPhotoDictionary:dict];
            //NSLog(@"URL:%@", photo.url);
            [self.photoObjects addObject:photo];
            //NSLog(@"count: %lu", self.photoObjects.count);
        }
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            [self.catCollectionView reloadData];
        }];
    }];
    
    [dataTask resume];
}


#pragma mark - UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *label = [cell viewWithTag:1];
    Photo *photo = self.photoObjects[indexPath.item];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo.url]]];
    label.text = photo.title;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoObjects.count;
}

@end
