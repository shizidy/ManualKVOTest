//
//  ViewController.m
//  ManualKVOTest
//
//  Created by wdyzmx on 2019/9/7.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"Han meimei";
    //自动实现监听observer
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100 / 2, [UIScreen mainScreen].bounds.size.height / 2 - 50 / 2 - 50, 100, 50)];
    [self.view addSubview:button];
    [button setTitle:@"button" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100 / 2, [UIScreen mainScreen].bounds.size.height / 2 - 50 / 2 + 50, 100, 50)];
    [self.view addSubview:button2];
    [button2 setTitle:@"button2" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)buttonAction:(UIButton *)btn {
    self.name = @"Li lei";
    
}
//手动触发observeValueForKeyPath
- (void)buttonAction2:(UIButton *)btn {
    [self willChangeValueForKey:@"name"];
    [self didChangeValueForKey:@"name"];
}

- (void)setName:(NSString *)name {
    _name = name;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return NO;//取消自动发送
    } else {
        return [super automaticallyNotifiesObserversForKey:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", keyPath);
    NSLog(@"%@", object);
    NSLog(@"%@", [change valueForKey:NSKeyValueChangeOldKey]);
    NSLog(@"%@", [change valueForKey:NSKeyValueChangeNewKey]);
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"name"];
}
@end
