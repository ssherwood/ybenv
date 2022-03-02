#!/usr/bin/env bash

#
#
#

function ybenv() {
    COMMAND="$1"
    QUALIFIER="$2"
  
    case "$COMMAND" in
    c)
        COMMAND="create"
        ;;
    start)
        COMMAND="start"
        ;;
    stop)
        COMMAND="stop"
        ;;
    v)
        COMMAND="version"
        ;;
    esac

    # no command provided
    if [[ -z "$COMMAND" ]]; then
        __ybenv_help
        return 1
    fi

    # Check if it is a valid command
    CMD_FOUND=""
    CMD_TARGET="${YBENV_DIR}/src/ybenv-${COMMAND}.sh"
    if [[ -f "$CMD_TARGET" ]]; then
        CMD_FOUND="$CMD_TARGET"
    fi

    # couldn't find the command
    if [[ -z "$CMD_FOUND" ]]; then
        echo ""
        __ybenv_echo_red "Invalid command: $COMMAND"
        echo ""
        __ybenv_help
    fi


    # Check whether the command exists as an internal function...
    #
    # NOTE Internal commands use underscores rather than hyphens,
    # hence the name conversion as the first step here.
    CONVERTED_CMD_NAME=$(echo "$COMMAND" | tr '-' '_')

    # Store the return code of the requested command
    local final_rc=0
 
    # Execute the requested command
    if [ -n "$CMD_FOUND" ]; then
        # It's available as a shell function
        __ybenv_"$CONVERTED_CMD_NAME" "$QUALIFIER" "$3" "$4"
        final_rc=$?
    fi

    return $final_rc
}
