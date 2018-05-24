//
// Created by reyre on 20/05/18.
//

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <boost/foreach.hpp>
#include <cassert>
#include <exception>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include "src/Entity/Street.h"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>

// Short alias for this namespace
namespace pt = boost::property_tree;

int main()
{
    // Create a root
    pt::ptree root;
    // Load the json file in this ptree
    pt::read_json("../map.json", root);
    std::vector<Street> lstreets;

    int matrix[05[5];
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
    for(int i = 0;i<lstreets.size();i++)
    {
        std::cout << lstreets[i].id << "," << lstreets[i].dir << "," << lstreets[i].startX << "," << lstreets[i].endX << "," << lstreets[i].startY << "," << lstreets[i].endY << std::endl;
    }
    return (0);
}
