//
// Created by reyre on 20/05/18.
//

#include "Piedestrian.h"

Piedestrian::Piedestrian(int id, int pos_x, int pos_y)
{
    this->id = id;
    this->pos_x = pos_x;
    this->pos_xy= pos_y;
}

int Piedestrian::getId()
{
    return(this->id);
}

int Piedestrian::getPosX()
{
    return(this->pos_x);
}

int Piedestrian::getPosY()
{
    return(this->pos_y);
}
