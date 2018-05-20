#ifndef SCENARIO_JSONPARSER_H
#define SCENARIO_JSONPARSER_H

class jsonParser
{
public:
    jsonParser();
    void jsonParser::get(std::string json);
    void jsonParser::print(boost::property_tree::ptree const& pt);
private:
};

#endif //SCENARIO_JSONPARSER_H
