CC	        = g++

RM	        = rm -f

CLASSES     = src/class/

SRC_PATH    = src/

BOOST       += -lboost_system -lboost_thread -lpthread

CPPFLAGS	+= -std=c++11

NAME	    = scenario

SRC	= main.cpp \
      $(SRC_PATH)Gen.cpp \
      $(SRC_PATH)Loop.cpp \
      $(SRC_PATH)Network.cpp \

OBJ	= $(SRC:.cpp=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(OBJ) -o $(NAME) $(BOOST)

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all