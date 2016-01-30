//
//  Utils.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 21/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#ifndef Utils_h
#define Utils_h


#endif /* Utils_h */

#import <UIKit/UIKit.h>

@interface Utils : NSObject

@property (strong, readonly) NSMutableArray *vetor;

+ (NSMutableArray *) criaVetorDasImagens;
- (UIImage *) pegaImagemDaPosicao: (NSInteger) posicao;
+ (id) UtilsIntance;
- (UIImage *) pegaEasterEgg;

@end