# Roboshop-shell

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