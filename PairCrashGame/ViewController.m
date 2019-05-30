//
//  ViewController.m
//  PairCrashGame
//
//  Created by Civet on 2019/5/29.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//图片数组
@property(nonatomic,strong) NSMutableArray *arrStr;
//显示图片个数
@property(nonatomic,assign) NSInteger pictureNumber;

@end

@implementation ViewController

- (void)startGame{
    //图像名字数组
    _arrStr = [[NSMutableArray alloc] init];
    for (int k = 0; k < _pictureNumber/2; k++) {
        int random = arc4random() % 7 + 1;
        NSString *strName = [NSString stringWithFormat:@"%d",random];
        //添加到数组中
        [_arrStr addObject:strName];
        [_arrStr addObject:strName];
    }
    //循环创建36个按钮
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            //创建自定义按钮
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //开启动画
            btn.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, self.view.bounds.size.width/6, self.view.bounds.size.height/6);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            
//            btn.frame = CGRectMake(10+50*j, 40+50*i, 50, 50);
            btn.frame = CGRectMake(5+(self.view.bounds.size.width - 10)/6*j, 5+(self.view.bounds.size.height - 10)/6*i, (self.view.bounds.size.width - 10)/6, (self.view.bounds.size.height - 10)/6);
            [UIView commitAnimations];
            //产生随机图片
            int indexrandom = arc4random() % _arrStr.count;
            //从图像数组中取出文件名
            NSString *strImageNumber = _arrStr[indexrandom];
            NSInteger tag = [strImageNumber integerValue];
            
            [_arrStr removeObjectAtIndex:indexrandom];
            
            //产生随机图片
//            int random = arc4random() % 7 +1;
            NSString *strImage = [NSString stringWithFormat:@"%ld.jpg",tag];
            
            UIImage *image = [UIImage imageNamed:strImage];
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            //将按钮的标志位赋值
            btn.tag = tag;;
        }
    }
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)pressBtn:(UIButton *)btn{
    //创建一个静态变量保存第一次按下的按钮
    static UIButton *firstBtn = nil;
    if (firstBtn == nil) {
        firstBtn = btn;
        //锁定第一个按钮
        firstBtn.enabled = NO;
    }
    else{
        //两个按钮图像相同
        if (firstBtn.tag == btn.tag) {
            static int removeNumber = 0;
            removeNumber += 2;
            CATransition *animt = [CATransition animation];
            animt.duration = 1.5;
            //@"cube",@"moveIn",@"reveal",@"fade",@"pageCurl",@"pageUnCurl",@"suckEffect",@"oglFlip",@"rippleEffect"
            animt.type = @"suckEffect";
            [firstBtn.layer addAnimation:animt forKey:nil];
            [btn.layer addAnimation:animt forKey:nil];
            
            firstBtn.hidden = YES;
            btn.hidden = YES;
            firstBtn = nil;
            if (removeNumber == _pictureNumber) {
                removeNumber = 0;
                [self startGame];
            }
        }
        //按钮图像不相同情况
        else{
            firstBtn.enabled = YES;
            firstBtn = nil;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //图片个数
    _pictureNumber = 36;
    [self startGame];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
