//
// Created by reyre on 20/05/18.
//

#include "Car.h"

Car::Car(int id, int pos_x, int pos_y)
{
    this->id = id;
    this->pos_x = pos_x;
    this->pos_xy= pos_y;
}

int Car::getId()
{
    return(this->id);
}

int Car::getPosX()
{
    return(this->pos_x);
}

int Car::getPosY()
{
    return(this->pos_y);
}
