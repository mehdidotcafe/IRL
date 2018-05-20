//
// Created by reyre on 16/05/18.
//

#include "Loop.h"

Loop::Loop()
{

}

void Loop::run(Network &net)
{
    while (1) // gestion d'erreur a la place de zero
    {
        net.send_s("test");
        net.read_s();
    }
}