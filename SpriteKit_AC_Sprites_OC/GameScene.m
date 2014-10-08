//
//  GameScene.m
//  SpriteKit_AC_Sprites_OC
//
//  Created by Julio César Fernández Muñoz on 5/10/14.
//  Copyright (c) 2014 AppleCoding. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

{
    NSString *naveTocada;
    BOOL tocoNave;
}

-(void)didMoveToView:(SKView *)view {
    /* Configura aquí tu escena */
 
    SKSpriteNode *nave1 = [[SKSpriteNode alloc] initWithImageNamed:@"Spaceship"];
    SKSpriteNode *nave2 = [[SKSpriteNode alloc] initWithImageNamed:@"Spaceship"];
    // Creamos dos constantes con dos naves: nave1 y nave2

    nave1.position = CGPointMake(400, 200);
    nave2.position = CGPointMake(400, 400);
    // Cambios su propiedad "position" para colocarlas en 200,200 y 400,400
    
    nave1.zPosition = 2;
    nave2.zPosition = 1;
    
    nave1.xScale = 0.5f;
    nave1.yScale = 0.5f;
    nave2.xScale = 0.4f;
    nave2.yScale = 0.4f;
    
    nave1.name = @"nave1";
    nave2.name = @"nave2";

    [self addChild:nave1];
    [self addChild:nave2];
    
    tocoNave = NO;

    // Las colocamos en pantalla añadiendo a la escena con addChild
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Se lanza cuando se inicia un toque */
    
    UITouch *touch = touches.anyObject;
    CGPoint position = [touch locationInNode:self];
    // Recuperamos la posición que se ha tocado
    
    SKSpriteNode *spriteTocado = (SKSpriteNode*) [self nodeAtPoint:position];
    if (spriteTocado != nil) {
        tocoNave = YES;
        // Encendemos el semáforo
        naveTocada = spriteTocado.name;
        // Guardamos el valor del nombre de la nave tocada
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    if (tocoNave) {
        CGPoint position = [touch locationInNode:self];
        // Posición tocada
        
        CGPoint previousPosition = [touch previousLocationInNode:self];
        // Posición previa
        
        CGPoint moveTo = CGPointMake(position.x - previousPosition.x, position.y - previousPosition.y);
        // Restamos los valores x e y de ambas posiciones para obtener la diferencia entre ambas posiciones
        
        SKSpriteNode *spriteTocado = (SKSpriteNode*) [self childNodeWithName:naveTocada];
        // Recuperamos nuestra nave a través de su nombre
        
        spriteTocado.position = CGPointMake(spriteTocado.position.x + moveTo.x, spriteTocado.position.y + moveTo.y);
        // Cambiamos la posición sumando la diferencia de las posiciones actuales y anterior a la posición actual de la nave
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (tocoNave) {
        tocoNave = NO;
        naveTocada = nil;
        // Fuera semáforo
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (tocoNave) {
        tocoNave = NO;
        naveTocada = nil;
        // Fuera semáforo
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Se llama antes de renderizar cada frame */
}

@end
