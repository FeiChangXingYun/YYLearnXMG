//
//  VideoPlayerViewController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/12.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerViewController ()
@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;
@end

@implementation VideoPlayerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //网络视频路径
    NSString *webVideoPath = @"http://111.47.4.141:9888/play/live.html?access_type=0&data_type=0&type=0&dev_id=e0ff3544-db3c-474c-b5fc-456e05689ea6&client_sup_ip=192.168.1.5&client_sup_port=8000&client_sup_id=hyszcms&dev_sup_id=hyszms&ch=0&username=admin&password=1111";
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:webVideoUrl];
    self.currentPlayerItem = playerItem;
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    avLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:avLayer];
    
    [self.player play];

}


@end
