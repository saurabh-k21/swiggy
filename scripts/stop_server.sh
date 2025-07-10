#!/bin/bash
# Stop the httpd service if it is running
if systemctl is-active --quiet httpd; then
    systemctl stop httpd
fi