# A MariaDB extension for Chassis
The MariaDB extension automatically sets up your Chassis instance to to use MariaDB.

## Activation
Ensure you have a Chassis instance set up locally already.

```
# In your Chassis dir:
git clone --recursive https://github.com/Chassis/MariaDB.git extensions/mariadb
```

Then you'll need to reprovision
```
cd ..
vagrant provision
```

Alternatively you can add the extension to one of your yaml config files. e.g.
```
# Extensions
#
# Install a list of extensions automatically
extensions:
    - chassis/mariadb
```

Then you'll need to reprovision

```
cd ..
vagrant provision
```

MariaDB has now been installed inside your Chassis box.
