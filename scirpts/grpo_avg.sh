export WANDB_API_KEY=<Your WANDB_API_KEY>

# 多机训练设置
export NPROC_PER_NODE=8
export NNODES=$WORLD_SIZE
export NODE_RANK=$RANK

swift rlhf \
    --rlhf_type grpo \
    --model '<MODEL_NAME>' \
    --external_plugins   \
    --reward_funcs  '<reward funcs>' \
    --reward_weights '<a list for reward funcs weights>' \
    --reward_thread_num 4 \
    --train_type full \
    --use_vllm true \
    --vllm_mode colocate \
    --vllm_gpu_memory_utilization 0.4  \
    --vllm_max_model_len  12000 \
    --vllm_tensor_parallel_size 4  \
    --torch_dtype bfloat16 \
    --dataset datasets/grpo_data.jsonl \
    --max_completion_length 8192 \
    --num_train_epochs 1 \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 1 \
    --learning_rate 1e-6 \
    --gradient_accumulation_steps 1 \
    --eval_steps 200 \
    --save_steps 30 \
    --save_total_limit 20 \
    --logging_steps 1 \
    --max_length 12000 \
    --output_dir '<output_path>' \
    --warmup_ratio 0.05 \
    --dataloader_num_workers 4 \
    --dataset_num_proc 4 \
    --num_generations 8 \
    --temperature 0.7 \
    --deepspeed zero3 \
    --sequence_parallel_size 4 \
    --overlong_filter true \
    --report_to tensorboard wandb \
    --log_completions true \
    --dynamic_sample true \
    --log_entropy true \
    --dataset_shuffle false