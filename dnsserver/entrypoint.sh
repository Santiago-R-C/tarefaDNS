#!/bin/bash
#chmod a+x safsdadfs
# chmod a+w /var/log/bind -R

named -u bind "$@"