//
// Created by reyre on 20/05/18.
//

#include "Sensor.h"

Sensor::Sensor(int id, int pos_x, int pos_y)
{
    this->id = id;
    this->pos_x = pos_x;
    this->pos_xy= pos_y;
}

int Sensor::getId()
{
    return(this->id);
}

int Sensor::getPosX()
{
    return(this->pos_x);
}

int Sensor::getPosY()
{
    return(this->pos_y);
}

SensorsState getState()
{
    return (this->state);
}
