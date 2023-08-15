# Roboshop-shell
This project is built with docs from
https://github.com/learndevopsonline/learndevopsonline

https://learndevopsonline.github.io/learndevopsonline/build/docs/RoboShop-Project/catalogue/

### SED Command Options

# Delete some lines
    - based on line numbers
        sed -i -e '1d' passwd
    - string based delete
        sed -i -e '/nologin/ d' passwd

# Add some lines
    - sed -i -e '1 a Hello' -e '/mongod/ a Hello World' passwd
# Modify some lines
    sed -i -e '2 cHello Universe' -e '/centos/ c Hello Galaxy' passwd


# Delete some word
    sed -i -e 's|Hello||g' passwd

# Modify (substitute) some words
    sed -i -e 's|bin|BIN|g' passwd
    sed -i -e '10s|bin|BIN|g' passwd

#### Instead of | we can use /, ?, :, ;, #, @

# Functions
    A name given to a set of commands is called a function.

### Declare a function
    function_name() {
        echo Hello World
    }
    
### Call function
    function_name

#### We can send inputs to the function and we can assess them with special variables $1-$n, $*, $#

    function_name() {
        echo First Argument = $1
        echo Second Argument = $2
        echo All Arguments = $*
        echo No of Arguments = $#
    }

    function_name1 123 xyz

## Redirectors command  (>, <, &>/dev/null)
        >file # this will overwrite the content
        >>file # this will append to the content
        &>>file # this will append output and error to the file

    &>/dev/null #this is used in a case we do not need any kind 
    of output or error to a file for future reference, 
    we try to nullify the output with the help of /dev/null