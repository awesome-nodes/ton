# Awesome nodes TON

Telegram Open Network (TON) is a next-generation blockchain and communication platform developed by the founders of the popular messenger Telegram

Official testnet site is: https://test.ton.org
### System requirements for TON full node

Testnet:

| Resource | Minimal option   | Recommended option |
|----------|------------------|--------------------|
| Memory   | 4 GB _*_         | 8 GB and more      | 
| CPU      | 2 Cores          | 8 Cores            |
| Disk     | 3-5 GB per day   | for the Testnet    |
| Type     | HDD              | SSD or RAID        |
| Network  | 20 Mbps Up/Down  | 100 Mbps Up/Down   |

_*_ Compilation may not pass with 2 GBytes of RAM

Mainnet: (based on the official How-To)

| Resource | Minimal option   | Recommended option      |
|----------|------------------|-------------------------|
| Memory   | 256 MB           | 8 GBytes and more       | 
| CPU      | 2 CPU x 8 Cores  | 16 Cores and more       |
| Disk     | _*_              | 512 GB SSD for hot data |
| Disk     | _*_              | 8 TB HDD for archive    |
| Network  | 100 Mbps Up/Down | 1 Gbps Up/Down          |

_*_ There is no estimation before the Mainnet launch 

### Contents
- [Deployment in Ubuntu 18.04](#ubuntu-18.04)
- [Dockerfile for TON fullnode](https://github.com/akme/ton-node)

## Deployment in Ubuntu 18.04
This recipe can be used for direct deployment in Ubuntu, creating Docker images and Packer images for a Full Node

* [./ubuntu-18.04/build.sh](ubuntu-18.04/build.sh) - Update system and build code
* [./ubuntu-18.04/configure.sh](ubuntu-18.04/configure.sh) - Generate initial config

You may run full install with the folowing bash commands.
Assumed root priveleges for creating directories (`sudo -i`)
```bash
wget -O - https://raw.githubusercontent.com/awesome-nodes/ton/master/ubuntu-18.04/build.sh | bash
wget -O - https://raw.githubusercontent.com/awesome-nodes/ton/master/ubuntu-18.04/configure.sh | bash
```
After a successful install, you may start node like this:
```bash
validator-engine -C /var/ton-work/etc/ton-global.config.json --db /var/ton-work/db/ -l /var/ton-work/log/log -t 2
```
where `-t x` means number of the threads for a multicore configuration. Default value is 8.

Inside the log directory, there are separates log files for the each thread. I would recommend using `-t 1` for the first launch for easier debugging.
