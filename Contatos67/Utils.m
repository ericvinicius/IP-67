//
//  Utils.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 21/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface Utils ()

@end

@implementation Utils

static Utils *utils = nil;

- (id) init{
    self = [super init];
    if(self){
        _vetor = [Utils criaVetorDasImagens];
    }
    return self;
}

+ (id) UtilsIntance{
    if(!utils){
        utils = [Utils new];
    }
    return utils;
}

+ (NSMutableArray *) criaVetorDasImagens{
    return [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"android_bones.png"],
     [UIImage imageNamed:@"android_candy.jpeg"], [UIImage imageNamed:@"android_clean.jpg"],
     [UIImage imageNamed:@"android_fix.jpg"], [UIImage imageNamed:@"android_i_am_here.jpg"],
     [UIImage imageNamed:@"android_money.jpg"], [UIImage imageNamed:@"android_open.jpg"],
     [UIImage imageNamed:@"android_root.jpeg"], [UIImage imageNamed:@"android_skate.jpg"],
     [UIImage imageNamed:@"android_zombie.jpg"], [UIImage imageNamed:@"android_wife.jpg"],
     nil];

}

+ (NSInteger) geraNumeroAleatorio{
    return arc4random_uniform(11);
}

- (UIImage *) pegaImagemDaPosicao: (NSInteger) posicao{
    if(posicao >= 10){
        posicao %= 10;
    }
    return self.vetor[posicao];
}

- (UIImage *) pegaEasterEgg{
    return [UIImage imageNamed:@"fe.png"];
}

@end