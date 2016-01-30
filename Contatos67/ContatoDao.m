//
//  ContatoDao.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 19/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContatoDao.h"
#import "DAO.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

- (id) init{
    self = [super init];
    if(self){
        _contatos = [NSMutableArray new];
        self.dao = [DAO new];
        [self insereContatos];
        [self carregaContatos];
    }
    return self;
}

- (void) adicionaContato:(Contato*) contato{
    [self.contatos addObject:contato];
    NSLog(@"Contatos : %@", self.contatos);
}

+ (ContatoDao *) contatoDaoIntance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

- (NSInteger) totalDeContatos {
    return [self.contatos count];
}

- (Contato *) buscaContatoDaPosicao: (NSInteger) posicao{
    return self.contatos[posicao];
}

- (void) removeContatoDaPosicao: (NSInteger) posicao{
    [self.contatos removeObjectAtIndex:posicao];
}

- (NSInteger) buscaPosicaoDoContato: (Contato *) contato{
    return [self.contatos indexOfObject:contato];
}

- (void) insereContatos {
    NSUserDefaults *sharedPrefs = [NSUserDefaults standardUserDefaults];
    BOOL jaInseriuContato = [sharedPrefs boolForKey:@"dados_inseridos"];
    if (!jaInseriuContato) {
    
        Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                     inManagedObjectContext: [self.dao managedObjectContext]];
        contato.nome = @"Eric Vinicius Camargo de Campos";
        contato.telefone = @"998126455";
        contato.endereco = @"Av. Leonardo da Vince, 2713 - São Paulo, SP";
        contato.site = @"https://github.com/ericvinicius";
        contato.email = @"eric.camargo@gmail.com";
        contato.latitude = [NSNumber numberWithDouble:-23.5883034];
        contato.longitude = [NSNumber numberWithDouble:-46.632369];
    
        [self.dao saveContext];
        [sharedPrefs setBool:YES forKey:@"dados_inseridos"];
        [sharedPrefs synchronize];
    }
}

- (void) carregaContatos{
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    
    NSArray *contatosImutaveis = [[self.dao managedObjectContext] executeFetchRequest:buscaContatos error:nil];
    _contatos = [contatosImutaveis mutableCopy];
}

- (Contato *)novoContato{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                         inManagedObjectContext:[self.dao managedObjectContext]];
}

@end

