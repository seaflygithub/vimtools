#!/bin/bash
objectlist=`ls config/objects/`
for object in $objectlist
do
    echo "get:$object"
done
