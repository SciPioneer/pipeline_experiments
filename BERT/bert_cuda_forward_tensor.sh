#!/bin/bash

export MASTER_PORT=29500
export MASTER_ADDR=$(scontrol show hostname ${SLURM_NODELIST} | head -n 1)
export CUDA_VISIBLE_DEVICES=${SLURM_LOCALID}

python -u bert_cuda_forward_tensor.py \
	--nlayers=96 \
	--emsize=8192 \
	--nhid=32768 \
	--nhead=16 \
        --world_size=${SLURM_NTASKS} \
        --rank=${SLURM_PROCID} \
        --master_addr=${MASTER_ADDR} \
        --master_port=${MASTER_PORT}

