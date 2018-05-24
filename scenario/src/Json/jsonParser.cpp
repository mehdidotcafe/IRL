#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <boost/foreach.hpp>
#include <cassert>
#include <exception>
#include <iostream>
#include <sstream>
#include <string>

#include "jsonParser.h"
#include "../Entity/Street.h"
#include "../Entity/Sensor.h"

namespace pt = boost::property_tree;

jsonParser::jsonParser()
{
}

std::vector<Street> jsonParser::getMap(int nbr_street, std::string map)
{
    pt::ptree root;
    pt::read_json(map, root);
    std::vector<Street> lstreets;

    int matrix[nbr_street][6];
    int x = 0;

    for (pt::ptree::value_type &row : root.get_child("streets"))
    {
        int y = 0;
        for (pt::ptree::value_type &cell : row.second)
        {
            matrix[x][y] = cell.second.get_value<int>();
            y++;
        }
        Street street_tmp(matrix[x][0], matrix[x][1],matrix[x][2], matrix[x][3],matrix[x][4],matrix[x][5]);
        lstreets.push_back(street_tmp);
        x++;
    }
    return (lstreets);
}

std::vector<Sensor> jsonParser::getSensors(std::string map)
{
    pt::ptree root;
    pt::read_json(map, root);
    std::vector<Sensor> lsensors;

    int matrix[6][6];
    int x = 0;

    for (pt::ptree::value_type &row : root.get_child("sensors"))
    {
        int y = 0;
        for (pt::ptree::value_type &cell : row.second)
        {
            matrix[x][y] = cell.second.get_value<int>();
            y++;
        }
        Sensor sensor_tmp(matrix[x][0], matrix[x][1],matrix[x][2], matrix[x][3]);
        lsensors.push_back(sensor_tmp);
        x++;
    }
    return (lsensors);
}

std::string jsonParser::CreateP(Piedestrian *p, std::string status)
{
    std::string res;

    pt::ptree root;
    root.put("event", status);
    root.put("sensor_id", p->hsensor.id);
    root.put("entity_id", p->id);
    root.put("x", p->pos_x);
    root.put("y", p->pos_y);
    std::stringstream ss;
    boost::property_tree::json_parser::write_json(ss, root);
    return (ss.str());
}

std::string jsonParser::CreateC(Car *c, std::string status)
{
    std::string res;

    pt::ptree root;
    root.put("event", status);
    root.put("sensor_id", "test");
    root.put("entity_id", c->id);
    root.put("x", c->pos_x);
    root.put("y", c->pos_y);
    pt::write_json(std::cout, root);
    return (res);
}

void JsonParser::changeSensorState(std::string json_r, std::vector<Sensor> &ls)
{
    pt::ptree root;
    pt::read_json(map, root);

    int matrix[6][6];
    int x = 0;

    for (pt::ptree::value_type &row : root.get_child("sensors"))
    {
        int y = 0;
        for (pt::ptree::value_type &cell : row.second)
        {
            matrix[x][y] = cell.second.get_value<int>();
            y++;
        }
        for(int i = 0; i < ls.size(); i++)
        {
            if (matrix[x][1] == ls[i].id)
            {
                if (matrix[x][0] == "RED")
                    ls[i].state = SensorsState::RED;
                else if (matrix[x][0] == "GREEN")
                    ls[i].state = SensorsState::GREEN;
                else
                    ls[i].state = SensorsState::ORANGE;
            }

        }
        x++;
    }
}

void jsonParser::displayMap(std::vector<Street> lstreets)
{
    for(int i = 0; i < lstreets.size(); i++)
    {
        std::cout << lstreets[i].id << "," << lstreets[i].dir << "," << lstreets[i].startX << "," << lstreets[i].endX << "," << lstreets[i].startY << "," << lstreets[i].endY << std::endl;
    }
}

void jsonParser::displaySensor(std::vector<Sensor> lsensors)
{
    for(int i = 0; i < lsensors.size(); i++)
    {
        std::cout << lsensors[i].id << "," << lsensors[i].pos_x << "," << lsensors[i].pos_y << std::endl;
    }
}
