#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <boost/foreach.hpp>
#include <cassert>
#include <exception>
#include <iostream>
#include <sstream>
#include <string>

jsonParser::jsonParser()
{
}

void jsonParser::get(std::string json)
{
    try
    {
        std::stringstream ss;
        boost::property_tree::ptree pt;
        boost::property_tree::read_json(ss, pt);

        BOOST_FOREACH(boost::property_tree::ptree::value_type &v, pt.get_child("particles.electron"))
        {
            assert(v.first.empty());
            std::cout << v.second.data() << std::endl;
        }
        return EXIT_SUCCESS;
    }
    catch (std::exception const& e)
    {
        std::cerr << e.what() << std::endl;
    }
    return EXIT_FAILURE;
}

void jsonParser::print(boost::property_tree::ptree const& pt)
{
    using boost::property_tree::ptree;
    ptree::const_iterator end = pt.end();
    for (ptree::const_iterator it = pt.begin(); it != end; ++it) {
        std::cout << it->first << ": " << it->second.get_value<std::string>() << std::endl;
        print(it->second);
    }
}