//
//  JogoDaVelhaViewController.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 25/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JogoDaVelhaViewController.h"

#define LINHAS 2
#define COLUNAS 2

@implementation JogoDaVelhaViewController
// YES = x
//  NO = o
BOOL jogador;
NSInteger jogadas;

- (void) viewWillAppear:(BOOL)animated {
    jogadas = 0;
    jogador = YES;
    NSLog(@"|||||||||||||||||||||||||||||||||||||");
    
}

- (IBAction) clickNoBotao:(id) sender{
    jogadas++;
    UIButton *button = sender;
    [button setTitle:[self textoAtual] forState:UIControlStateNormal];
    [button setEnabled:NO];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    if(jogadas >= 5){
        [self verificaGanhador];
    } else if(jogadas >= 9){
        [self velha];
    }
}

- (void) velha{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Iiiiih deu Velha!"
                                                                   message:@"O jogo deu empate"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self reinicia];}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) reinicia{
    [self trocaJogadorPara:@"x"];
    jogadas = 0;
    for (UIButton* bt in self.vetor) {
        [bt setTitle:@" " forState:UIControlStateNormal];
        [bt setEnabled:YES];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor blackColor]];
    }
}

- (NSString *) textoAtual{
    NSString *player;
    if(jogador){
        player = @"x";
    } else {
        player = @"o";
    }
    [self trocaJogadorPara:player];
    return player;
}

- (void) trocaJogadorPara: (NSString*) player{
    self.jogadorAtual.text = [NSString stringWithFormat: @"Jogador Atual: (%@)", player];
    if([player isEqualToString:@"x"]){
        jogador = NO;
    } else {
        jogador = YES;
    }
}

- (void) verificaGanhador{
    [self verificaGanhadorComBotao:self.vetor[0] comBotaoDois:self.vetor[1] comBotaoTres:self.vetor[2]];
    [self verificaGanhadorComBotao:self.vetor[3] comBotaoDois:self.vetor[4] comBotaoTres:self.vetor[5]];
    [self verificaGanhadorComBotao:self.vetor[6] comBotaoDois:self.vetor[7] comBotaoTres:self.vetor[8]];
    
    [self verificaGanhadorComBotao:self.vetor[0] comBotaoDois:self.vetor[3] comBotaoTres:self.vetor[6]];
    [self verificaGanhadorComBotao:self.vetor[1] comBotaoDois:self.vetor[4] comBotaoTres:self.vetor[7]];
    [self verificaGanhadorComBotao:self.vetor[2] comBotaoDois:self.vetor[5] comBotaoTres:self.vetor[8]];
    
    [self verificaGanhadorComBotao:self.vetor[2] comBotaoDois:self.vetor[4] comBotaoTres:self.vetor[6]];
    [self verificaGanhadorComBotao:self.vetor[0] comBotaoDois:self.vetor[4] comBotaoTres:self.vetor[8]];
    
}

- (void) verificaGanhadorComBotao: (UIButton *) bt1 comBotaoDois: (UIButton *) bt2 comBotaoTres: (UIButton *) bt3{
    NSString *txt1 = bt1.currentTitle;
    NSString *txt2 = bt2.currentTitle;
    NSString *txt3 = bt3.currentTitle;
    NSLog([NSString stringWithFormat:@"bt1=%@ | bt2=%@ | bt3=%@ ", txt1, txt2, txt3]);
    NSLog(@"------------------------------------");
    if ([txt1 isEqualToString: txt2] && [txt2 isEqualToString: txt3]) {
        if([txt1  isEqualToString: @"x"]){
            [self ganhador:YES comBotao:bt1 comBotaoDois:bt2 comBotaoTres:bt3];
            
        } else if ([txt1 isEqualToString:@"o"]) {
            [self ganhador: NO comBotao:bt1 comBotaoDois:bt2 comBotaoTres:bt3];
        }
    }
}

- (void) ganhador: (BOOL) ganhador comBotao: (UIButton *) bt1 comBotaoDois: (UIButton *) bt2 comBotaoTres: (UIButton *) bt3{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ganhador"
                                                                   message:[NSString stringWithFormat: @"Jogador (%@) ganhou", ganhador ? @"x" : @"o"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self reinicia];}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end