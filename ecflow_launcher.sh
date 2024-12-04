(
    # Manejo de señales para cerrar el túnel si se interrumpe el script
    trap 'kill $SSH_PID 2>/dev/null; exit' INT TERM EXIT

    # Check if certificate is valid
    tsh status --proxy jump.ecmwf.int >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Teleport certificate is not valid. Trying to get one..."
        eclogin
    else
        echo "Teleport certificate is valid"
    fi

    # Launch ecflow_ui in the background
    ecflow_ui -pc4 &

    # Save the PID of the ecflow_ui process
    EC_FLOW_PID=$!

    # Launch the SSH tunnel also in the background
    ssh -C -N -D 9050 -J sp4e@jump.ecmwf.int sp4e@hpc-login &

    # Save the PID of the SSH process
    SSH_PID=$!

    # Wait for the ecflow_ui process to finish
    wait $EC_FLOW_PID

    # If ecflow_ui finishes, kill the SSH process
    kill $SSH_PID 2>/dev/null
) > ~/dotfiles/ecflow.log 2>&1 &
