#include <ArduinoJson.h>
#include "module_config.h"
#include <vector>
#include "module.h"
#include "led_module.h"
#include "servo_module.h"
#include <memory>

#define ID_LED 1

class HouseProtocol {
public:

  std::vector<Module *> module_array;

  HouseProtocol() {this->setupModules();}
  ~HouseProtocol() {
    for (auto i = module_array.begin(); i != module_array.end(); ++i) {
      delete *i;
    }
  }

  Module* findModuleById(int id) {
    for (auto &elem: module_array) {
      if (elem->getIdModule() == id) {
        Serial.println(elem->getIdModule());
        return elem;
      }
    }
    return nullptr;
  }

  void setupModules() {
    for (int i = 0; i < NBR_MODULES; i++) {
      if (LIST_MODULES[i].id == 1) {
        module_array.push_back(new LedModule(LIST_MODULES[i].id, 14));
      }
      if (LIST_MODULES[i].id == 2) {
        module_array.push_back(new ServoModule(LIST_MODULES[i].id, 5));
      }
    }
  }


  void deserializeMQTT(char *payload) {
    DynamicJsonDocument doc(1024);
    deserializeJson(doc, payload);
    auto module = this->findModuleById(doc["id"]);
    String arg1= doc["args"][0];
    String args[1] = {arg1};
    if (module)
      module->executeAction(doc["id_function"], args);
      //auto info = this->findModuleById(1)->getModuleInfo();
      //Serial.println(info);
    }



};

