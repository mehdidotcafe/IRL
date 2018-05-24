CC	        = g++

RM	        = rm -f

CLASSES     = src/class/

SRC_PATH    = src/

BOOST       += -lboost_system -lboost_thread -lpthread

CPPFLAGS	+= -std=c++11

NAME	    = scenario

SRC	= main.cpp \
      $(SRC_PATH)/Entity/Car.cpp \
      $(SRC_PATH)/Entity/Gen.cpp \
      $(SRC_PATH)/Entity/Map.cpp \
      $(SRC_PATH)/Entity/Piedestrian.cpp \
      $(SRC_PATH)/Entity/Sensor.cpp \
      $(SRC_PATH)/Entity/Street.cpp \
      $(SRC_PATH)/Json/jsonParser.cpp \
      $(SRC_PATH)/Network/Network.cpp \
      $(SRC_PATH)Loop.cpp \

OBJ	= $(SRC:.cpp=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(OBJ) -o $(NAME) $(BOOST)

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all