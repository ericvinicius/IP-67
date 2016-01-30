//
//  ListaContatosViewController.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 19/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"
#import "JogoDaVelhaViewController.h"

@interface ListaContatosViewController ()

@end

@implementation ListaContatosViewController

- (id)init{
    self = [super init];
    if(self){
        UIImage *imagemDaAba = [UIImage imageNamed:@"contacts"];
        
        UITabBarItem *itemDaBarra = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:imagemDaAba tag:0];
        self.tabBarItem = itemDaBarra;
        
        self.contatoDao = [ContatoDao contatoDaoIntance];
        self.navigationItem.title = @"†Contatos Satanicos†";
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: [self criaBotaoJogoDaVelha], self.editButtonItem, nil];
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: [self criaBotaoAdicionarContato], [self criaBotaoSobre], nil];
        self.linhaDestaque = -1;
    }
    return self;
}

- (UIBarButtonItem *) criaBotaoJogoDaVelha{
    UIImage *ufo = [UIImage imageNamed:@"flame.png"];
    UIButton *ufoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ufoButton.bounds = CGRectMake( 0, 0, ufo.size.width, ufo.size.height );
    [ufoButton setImage:ufo forState:UIControlStateNormal];
    [ufoButton addTarget:self action:@selector(exibeJogoDaVelha) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:ufoButton];
}

- (void) exibeJogoDaVelha{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JogoDaVelhaViewController *jogo = [storyboard instantiateViewControllerWithIdentifier:@"Jogo-da-Velha"];
    [self.navigationController pushViewController:jogo animated:YES];
}

- (void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:longPress];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaDestaque inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    self.linhaDestaque = -1;
}

- (void) exibeMaisAcoes : (UIGestureRecognizer *) gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        if(index){
            self.contatoSelecionado = [self.contatoDao buscaContatoDaPosicao:index.row];
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:self.contatoSelecionado];
            [self.gerenciador acoesDoController:self];
        }
    }
}

- (UIBarButtonItem *) criaBotaoSobre{
    UIImage *ufo = [UIImage imageNamed:@"ufo.png"];
    UIButton *ufoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ufoButton.bounds = CGRectMake( 0, 0, ufo.size.width, ufo.size.height );
    [ufoButton setImage:ufo forState:UIControlStateNormal];
    [ufoButton addTarget:self action:@selector(exibeSobre) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:ufoButton];
}

- (UIBarButtonItem *) criaBotaoAdicionarContato{
    return [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
            target:self
            action:@selector(exibeFormulario)];
}

- (void) exibeFormulario{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyboard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    form.delegate = self;
    if(self.contatoSelecionado){
        form.contato = self.contatoSelecionado;
    }
    [self.navigationController pushViewController:form animated:YES];
}

- (void) exibeSobre{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Agenda Satanica"
                                                                   message:@"Isto é um app para adicionar seus contatos marotos!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"666" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contatoDao.contatos count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tag = @"Cell";
    UITableViewCell *linha = [tableView dequeueReusableCellWithIdentifier:tag];
    
    
    if(!linha){
        linha = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    linha = [self criaContatoNaLinha: indexPath.row naCelula: linha];
    
    return linha;
}

- (UITableViewCell *) criaContatoNaLinha: (NSInteger) numeroDaLinha naCelula: (UITableViewCell *) linha{
    Contato *contato = [self.contatoDao buscaContatoDaPosicao: numeroDaLinha];
    
    if (contato.ehMaroto) {
        UIImage *fire = [UIImage imageNamed:@"flame.png"];
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake( 5, 5, fire.size.width, fire.size.height)];
        imv.image = fire;
        [linha.contentView addSubview:(imv)];
    }
    
    linha.textLabel.textAlignment = NSTextAlignmentCenter;
    linha.textLabel.text = contato.nome;
    
    return linha;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatoDao removeContatoDaPosicao: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.contatoSelecionado = [self.contatoDao buscaContatoDaPosicao:indexPath.row];
    [self exibeFormulario];
    self.contatoSelecionado = nil;
}

- (void) contatoAtualizado: (Contato *) contato{
    self.linhaDestaque = [self.contatoDao buscaPosicaoDoContato:contato];
}

- (void) contatoAdicionado: (Contato *) contato{
    self.linhaDestaque = [self.contatoDao buscaPosicaoDoContato:contato];
}

@end
