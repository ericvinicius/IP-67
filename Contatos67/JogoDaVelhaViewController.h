//
//  JogoDaVelhaViewController.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 25/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#ifndef JogoDaVelhaViewController_h
#define JogoDaVelhaViewController_h


#endif /* JogoDaVelhaViewController_h */

#import <UIKit/UIKit.h>

@interface JogoDaVelhaViewController : UIViewController

@property IBOutlet UILabel *jogadorAtual;
@property IBOutletCollection(UIButton) NSMutableArray *vetor;

- (void) clickNoBotao:(id) button;

@end