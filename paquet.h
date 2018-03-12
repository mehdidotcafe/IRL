#pragma once

typedef enum e_event {
  NEW_CAR, MOVE_CAR, DEL_CAR, NEW_PIEDESTRIAN, MOVE_PIEDESTRIAN, DEL_PIEDESTRIAN
} event;

typedef enum e_state {
  RED, ORANGE, GREEN
} state;

typedef struct s_entity {
  unsigned int id;

} entity;

typedef struct s_paquet_sent {
  event         event;
  // id of the redlight / sensor
  unsigned int  id;
  entity      entity;
} paquet_send;

typedef struct s_paquet_received {
  state         state;
  // id of the redlight / sensor
  unsigned int  id;
} paquet_received;
