#!/usr/bin/env bash

function __ybenv_varz() {
    curl $(hostname -i):12000/varz
}
