//
//  GerenciadorDeAcoes.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 22/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#ifndef GerenciadorDeAcoes_h
#define GerenciadorDeAcoes_h


#endif /* GerenciadorDeAcoes_h */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Contato.h"




@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property Contato *contato;
@property UIViewController *controller;

- (id) initWithContato: (Contato *) contato;
- (void) acoesDoController: (UIViewController *) controller;

@end
