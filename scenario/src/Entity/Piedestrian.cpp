//
// Created by reyre on 20/05/18.
//

#include "Piedestrian.h"
#include "Street.h"

Piedestrian::Piedestrian(int id, int pos_x, int pos_y, Street &start, Sensor &sstart) : hstreet(start), hsensor(sstart)
{
    this->id = id;
    this->pos_x = pos_x;
    this->pos_y = pos_y;
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

