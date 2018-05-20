//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_PIEDESTRIAN_H
#define SCENARIO_PIEDESTRIAN_H

class Piedestrian
{
public:
    Piedestrian::Piedestrian(int id, int pos_x, int pos_y);
    int getId();
    int getPosX();
    int getPosY();
private:
    int id;
    int pos_x;
    int pos_y;
};

#endif //SCENARIO_PIEDESTRIAN_H
