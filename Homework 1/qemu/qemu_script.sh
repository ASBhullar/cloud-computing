#!/bin/bash

# Define CPU and memory configurations
cpus=(1 2)
mems=(1024 2048) # Memory in MB

# Define disk images paths
disk_images=("path/to/disk_raw.img" "path/to/disk_qcow2.img")

# Define user and host for SSH
username="aj"
hostname="localhost" # or the IP address of the QEMU guest
ssh_port="22" # Replace with your QEMU SSH port if not the default

# Path to the sysbench executable on the guest
sysbench_path="sysbench"

# Function to run QEMU with the specified disk image, CPUs, and memory
run_qemu() {
    disk_image=$1
    cpu_count=$2
    memory_size=$3

    # Start QEMU with the current configuration
    qemu-system-aarch64 \
        -accel hvf \
        -cpu cortex-a57 \
        -M virt,highmem=off \
        -m $memory_size \
        -smp $cpu_count \
        -drive file=$disk_image,if=virtio,format=qcow2 \
        -nographic \
        -device virtio-net-device,netdev=net0 \
        -netdev user,id=net0 \
        -device virtio-blk-device,drive=hd0 \
        -drive file=$disk_image,if=none,id=hd0 \
        -vga none \
        -device ramfb \
        -usb \
        -device usb-kbd \
        -device usb-mouse &
}

# Main loop to run the experiments
for cpu in "${cpus[@]}"; do
    for mem in "${mems[@]}"; do
        for img in "${disk_images[@]}"; do
            echo "Testing with $cpu CPUs, $mem MB memory, using disk image $img"
            result_file="result_cpu${cpu}_mem${mem}_$(basename $img .img).txt"
            
            # Run QEMU with the specified configuration
            run_qemu $img $cpu $mem
            
            # Wait for the QEMU VM to start and SSH to become available
            sleep 60 # Adjust based on your system's boot time

            # SSH to the QEMU VM and run the sysbench test
            sshpass -p 'aj' ssh -o StrictHostKeyChecking=no -p $ssh_port $username@$hostname "$sysbench_path --test=cpu --cpu-max-prime=20000 run" > "$result_file"
            
            # Shutdown the QEMU VM
            sshpass -p 'aj' ssh -o StrictHostKeyChecking=no -p $ssh_port $username@$hostname "sudo poweroff"

            # Wait for QEMU VM to shutdown
            sleep 10
        done
    done
done

echo "Testing completed."
