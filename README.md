# openvpn-interface

An OpenVPN wrapper script that binds routing to the VPN interface device.


# Usage

Just supply an open ip table identifier and an ovpn config file.

```
$ sudo openvpn-interface.sh 10 config.ovpn
```

Then you can use both the VPN and the default routing based on the interface your programs binds.

```
$ curl https://icanhazip.com/
$ curl --interface tun0 https://icanhazip.com/
```

Full CLI help outout.

```
usage: openvpn-interface.sh ip_table_id ovpn_config_file [openvpn_arguments]

1.0.0 - Copyright (c) 2019 Alexander O'Mara MPL-2.0

positional arguments:
  ip_table_id          IP tables table ID to use
  ovpn_config_file     The ovpn config file
  openvpn_arguments    Optional additional openvpn arguments
```


# Bugs

If you find a bug or have compatibility issues, please open a ticket under issues section for this repository.


# License

Copyright (c) 2019 Alexander O'Mara

Licensed under the Mozilla Public License, v. 2.0


# Donations

If you find my software useful, please consider supporting independent and open-source software development by making a modest donation on my website at [alexomara.com](https://alexomara.com).
