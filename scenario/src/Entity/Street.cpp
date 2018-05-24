//
// Created by reyre on 20/05/18.
//

#include "Street.h"

Street::Street(int id, int dir, int startX, int endX, int startY, int endY)
{
    this->id = id;
    this->dir = dir;
    this->startX = startX;
    this->startY = startY;
    this->endX = endX;
    this->endY = endY;
}