//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_CAR_H
#define SCENARIO_CAR_H

class Car
{
public:
    Car::Car(int id, int pos_x, int pos_y);
    int getId();
    int getPosX();
    int getPosY();
private:
    int id;
    int pos_x;
    int pos_y;
};

#endif //SCENARIO_CAR_H
