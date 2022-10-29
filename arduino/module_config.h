typedef struct module_config {
  std::string module_name;
  int id;
  std::string description;
} module_config_t;

const int NBR_MODULES = 2;


const module_config_t LIST_MODULES[NBR_MODULES]  = {
  {.module_name="Led simple", .id=1, .description="Led simple"},
  {.module_name="Servo", .id=2, .description="Servo"}
};
