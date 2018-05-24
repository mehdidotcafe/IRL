//
// Created by reyre on 20/05/18.
//

#include "Car.h"
#include "Street.h"


Car::Car(int id, int pos_x, int pos_y, Street &start, Sensor &sstart) : hstreet(start), hsensor(sstart)
{
    this->id = id;
    this->pos_x = pos_x;
    this->pos_y= pos_y;
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
