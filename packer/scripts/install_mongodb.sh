#!/bin/bash
apt update
apt-get install mongodb -y
systemctl start mongodb
systemctl enable mongodb
