#ifndef __HELLO_H__
#define __HELLO_H__

#ifdef helloShared_EXPORTS
#define HELLO_API  __declspec(dllexport)
#else   
#define HELLO_API  __declspec(dllimport)
#endif // !helloShared_EXPORTS

class HELLO_API Hello
{
public:
    void print();
};

#endif
