//
//  ContatoDao.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 19/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#ifndef ContatoDao_h
#define ContatoDao_h
#import "Contato.h"
#import "DAO.h"


#endif /* ContatoDao_h */

@interface ContatoDao : NSObject

@property (strong, readonly) NSMutableArray *contatos;
@property (strong) DAO *dao;

- (void) adicionaContato:(Contato*) contato;
+ (ContatoDao *) contatoDaoIntance;
- (NSInteger) totalDeContatos;
- (Contato *) buscaContatoDaPosicao: (NSInteger) posicao;
- (void) removeContatoDaPosicao: (NSInteger) posicao;
- (NSInteger) buscaPosicaoDoContato: (Contato *) contato;
- (Contato *)novoContato;
@end