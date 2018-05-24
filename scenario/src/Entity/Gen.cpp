//
// Created by reyre on 16/05/18.
//

#include <iostream>

#include "Gen.h"
#include "Map.h"
#include "Piedestrian.h"
#include "Car.h"

Gen::Gen(Map &map) : map(map)
{
}

void Gen::randomize(Network &net, jsonParser &jparse)
{
    static int id_p = 1;
    static int id_c = 1;
    int i = map.street_nbr / 2;
    int seeds;
    srand((unsigned)time(0));

    while (i > 0)
    {
        seeds = (rand()%map.sensor_nbr + 1);
        Piedestrian *Pied = new Piedestrian(id_p, map.lsensor[seeds].pos_x, map.lsensor[seeds].pos_y, map.getStreetsById(map.lsensor[seeds].streetId), map.lsensor[seeds]);
        map.lp.push_back(Pied);
        std::string status("new_piedstrian");
        net.send_s(jparse.CreateP(Pied, status));
        seeds = (rand()%map.street_nbr + 1);
        Car *car = new Car(id_c, map.lstreet[seeds].startX, map.lstreet[seeds].startY, map.lstreet[seeds]);
        map.lc.push_back(car);
        //std::cout << "x :" << Pied->getPosX() << std::endl << "y :" << Pied->getPosY() << std::endl;
        //std::cout << "x :" << map.lsensor[seeds].pos_x << std::endl << "y :" << map.lsensor[seeds].pos_y << std::endl;
        //std::cout<< seeds;
        //std::cout << "id :" << id_c << std::endl << "x :" << map.lstreet[seeds].startX << std::endl << "y :" << map.lstreet[seeds].startY << std::endl << std::endl;
        id_p++;
        id_c++;
        i--;
    }
}

void Gen::move(Map& m,Network &net,jsonParser &jparse)
{
    //piedestrian move
    for (int i = 0; i < map.lp.size(); i++)
    {
        if (map.lp[i]->hsensor.state == SensorsState::RED)
        {
            std::string status("del_piedestrian");
            map.lp.erase(map.lp.begin() + i);
            i--;
            net.send_s(jparse.CreateP(map.lp[i], status));

        }
    }
    //car move
    for (int i = 0; i < map.lc.size(); i++)
    {
        //check si on est sur Y
        if (map.lc[i]->hstreet.startX == map.lc[i]->hstreet.endX)
        {
            // can move ?
            if (map.tileDispo(map.lc[i]->pos_x, map.lc[i]->pos_y + 1) && map.lc[i]->inRange == 0)
            {
                if (map.lc[i]->hstreet.dir == 1)
                    map.lc[i]->pos_y++;
                else
                    map.lc[i]->pos_y--;
            }
            else
            {
                if (map.tileDispo(map.lc[i]->pos_x, map.lc[i]->pos_y + 1) && map.lc[i]->inRange == 1 &&
                    map.lc[i]->hsensor.state == SensorsState::GREEN)
                {
                    if (map.lc[i]->hstreet.dir == 1)
                        map.lc[i]->pos_y++;
                    else
                        map.lc[i]->pos_y--;
                }

            }
        }
        //sinon on est sur X
        else
        {
            // can move ?
            if (map.tileDispo(map.lc[i]->pos_x + 1, map.lc[i]->pos_y) && map.lc[i]->inRange == 0)
            {
                if (map.lc[i]->hstreet.dir == 1)
                    map.lc[i]->pos_x++;
                else
                    map.lc[i]->pos_x--;
            }
            else
            {
                if (map.tileDispo(map.lc[i]->pos_x + 1, map.lc[i]->pos_y) && map.lc[i]->inRange == 1 &&
                    map.lc[i]->hsensor.state == SensorsState::GREEN)
                {
                    if (map.lc[i]->hstreet.dir == 1)
                        map.lc[i]->pos_x++;
                    else
                        map.lc[i]->pos_x--;
                }

            }
        }

        //gere le range des sensors
        if (map.lc[i]->inRange == 0)
        {
            if (map.IsInRange(map.lc[i]->id) == 1)
            {
                std::string status("new_car");
                net.send_s(jparse.CreateC(map.lc[i], status));
            }
        }
        else
        {
            if (map.IsInRange(map.lc[i]->id) == 0)
            {
                std::string status("del_car");
                net.send_s(jparse.CreateC(map.lc[i], status));
            }
        }

        // remove car from list
        if (map.lc[i]->pos_x == map.lc[i]->hstreet.endX && map.lc[i]->pos_y == map.lc[i]->hstreet.endY && map.findInterStreet(map.lc[i]->pos_x, map.lc[i]->pos_y, map.lc[i]->hstreet.id) == 0)
        {
            map.lc.erase(map.lc.begin() + i);
            i--;
        }
    }
}

// debugué read
// pk parserjson genere de la merde parfois ?
// comment on tourne a droite/gauche ?