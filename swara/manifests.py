import random

swara_speakers = ["BAS", "CAU", "DCS", "DDM", "EME", "FDS", "HTM", "IPS", "PCS", "PMM", "PSS", "RMS", "SAM", "SDS", "SGS", "TIM", "TSS"]

train_csv = open("output/train.csv", "w", encoding="utf-8")
validate_csv = open("output/validate.csv", "w", encoding="utf-8")
test_csv = open("output/test.csv", "w", encoding="utf-8")

for speaker in swara_speakers:
    with open(f"work/{speaker.lower()}-manifest.csv", encoding="utf-8") as manifest:
        lines = manifest.readlines()

        length = len(lines)

        train_index = int(length * 0.7)
        validate_index = int(length * 0.9)

        random.shuffle(lines)

        for line in lines[0:train_index]:
            train_csv.write(line)
        for line in lines[train_index:validate_index]:
            validate_csv.write(line)
        for line in lines[validate_index:]:
            test_csv.write(line)
