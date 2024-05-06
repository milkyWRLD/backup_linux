#!/bin/bash

input_dir="PhotoIn"
output_dir="PhotoOut"

start_time=$(date +%s)

echo "$(date) Создание папки для обработанных фотографий..."
mkdir -p "$output_dir"

log_file="photo_processing_log.txt"

archive_dir="PhotoArh"

echo "$(date) Создание папок для архивированных фотографий..."
mkdir -p "$archive_dir/Originals"
mkdir -p "$archive_dir/Processed"

echo "$(date) Начало архивации исходных изображений." >> "$log_file"
for photo in "$input_dir"/*.jpg; do
    echo "$(date) Архивация фотографии $photo..."
    tar -czvf "$archive_dir/Originals/$(basename "$photo").tar.gz" "$photo"
done
originals_size=$(du -sh "$archive_dir/Originals" | cut -f1)
echo "$(date) Архивация исходных изображений завершена. Размер архива: $originals_size." >> "$log_file"

echo "$(date) Начало сжатия изображений. Размер исходных изображений: $originals_size." >> "$log_file"
for photo in "$input_dir"/*.jpg; do
    echo "$(date) Обработка фотографии $photo..."
    output_photo="$output_dir/$(basename "$photo")"
    # Изменяем цветокоррекцию на увеличение насыщенности цвета
    convert "$photo" -modulate 100,150,100 -quality 85 "$output_photo"
    # Архивируем обработанное изображение
    tar -czvf "$archive_dir/Processed/$(basename "$output_photo").tar.gz" "$output_photo"
done
processed_size=$(du -sh "$output_dir" | cut -f1)
echo "$(date) Сжатие изображений завершено. Размер сжатых изображений: $processed_size." >> "$log_file"

end_time=$(date +%s)
execution_time=$((end_time-start_time))
0-=0
echo "$(date) Обработанные фото находятся в папке $output_dir." >> "$log_file"
echo "$(date) Исходные фото заархивированы в $archive_dir/Originals." >> "$log_file"
echo "$(date) Обработанные фото заархивированы в $archive_dir/Processed." >> "$log_file"
echo "$(date) Время выполнения скрипта: $execution_time секунд" >> "$log_file"
