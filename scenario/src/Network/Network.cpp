//
// Created by reyre on 18/05/18.
//

#include <boost/asio.hpp>
#include <boost/array.hpp>
#include <iostream>

#include "Network.h"

Network::Network(std::string h, int p)
{
    this->host = h;
    this->port = p;
    boost::asio::io_service ios;
    boost::asio::ip::tcp::endpoint endpoint(boost::asio::ip::address::from_string(this->host), this->port);

    this->socket = boost::asio::ip::tcp::socket(ios);
    this->socket.connect(endpoint);
}

void Network::send_s(std::string message)
{
    boost::array<char, 4096> buf;
    std::copy(message.begin(),message.end(),buf.begin());
    boost::system::error_code error;

    socket.write_some(boost::asio::buffer(buf, message.size()), error);
}

void Network::read_s()
{
    boost::array<char, 4096> buf;
    boost::system::error_code error;

    size_t len = socket.read_some(boost::asio::buffer(buf), error);

    if (error == boost::asio::error::eof)
    {
        std::cout << "Error" << std::endl;
        exit(0);
    }
    else if (error)
        throw boost::system::system_error(error);

    std::cout.write(buf.data(), len);
}

Network::~Network()
{
    this->socket.close();
}