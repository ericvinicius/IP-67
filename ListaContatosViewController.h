//
//  ListaContatosViewController.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 19/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"
#import "FormularioContatoViewController.h"
#import "GerenciadorDeAcoes.h"

@interface ListaContatosViewController : UITableViewController<FormularioContatoViewControllerDelegate>

@property (readonly) GerenciadorDeAcoes *gerenciador;
@property ContatoDao *contatoDao;
@property Contato *contatoSelecionado;

@property NSInteger linhaDestaque;

- (void) exibeMaisAcoes : (UIGestureRecognizer *) gesture;

@end
