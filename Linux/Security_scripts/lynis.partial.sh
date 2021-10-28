#!/bin/bash

lynis audit --test-from-group {malware,authentication,networking,storage,filesystems} >> /tmp/lyis.partial_scan.log
