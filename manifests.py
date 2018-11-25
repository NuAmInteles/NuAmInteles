import os
import random

language_model = set()
language_model_txt = open("assets/language_model.txt", "w")
#manifest = open("assets/manifest.csv", "w")

manifest = []

for root, dirs, files in os.walk("assets/converted/"):
    for file in files:
        phrase = file.split("_")[:-2]

        fixit = {"sase": "șase", "sapte": "șapte", "noua": "nouă", "opreste": "oprește", "porneste": "pornește", "masina": "mașina", "verifica": "verifică"}
        
        phrase_fixed = " ".join([ fixit.get(word, word) for word in phrase ])

        language_model.update(phrase_fixed)

        wav_file = os.path.realpath(file)
        phrase_file = os.path.realpath(f"assets/text/{'_'.join(phrase)}.txt")

        with open(phrase_file, "w") as w:
            w.write(phrase_fixed)

        manifest.append(f"{wav_file},{phrase_file}\n")

language_model_txt.close()

train_csv = open("assets/train.csv", "w", encoding="utf-8")
validate_csv = open("assets/validate.csv", "w", encoding="utf-8")
test_csv = open("assets/test.csv", "w", encoding="utf-8")

length = len(manifest)

train_index = int(length * 0.8)
validate_index = int(length * 0.9)

random.shuffle(manifest)

for line in manifest[0:train_index]:
    train_csv.write(line)
for line in manifest[train_index:validate_index]:
    validate_csv.write(line)
for line in manifest[validate_index:]:
    test_csv.write(line)

