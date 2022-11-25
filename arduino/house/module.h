#ifndef MODULE_H
#define MODULE_H

class Module {
  public:
    int id;
    virtual void executeAction(int method, String *args);
    virtual String getModuleInfo();
    virtual int getIdModule();

};

#endif