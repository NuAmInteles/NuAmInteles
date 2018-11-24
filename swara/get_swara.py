from zipfile import ZipFile
import os
import shutil
import sys
import requests

swara_speakers = ["BAS", "CAU", "DCS", "DDM", "EME", "FDS", "HTM", "IPS", "PCS", "PMM", "PSS", "RMS", "SAM", "SDS", "SGS", "TIM", "TSS"]


for speaker in swara_speakers:
    try:
        os.stat(f"download/{speaker}.zip")
    except FileNotFoundError:
        print(f"Downloading {speaker}.zip")
        response = requests.get(f"https://speech.utcluj.ro/swarasc/data/{speaker}.zip", stream=True)
        response.raise_for_status()

        with open(f"download/{speaker}.zip", "wb") as handle:
            for block in response.iter_content(1024*1024):
                handle.write(block)
                print(".", end="")
                sys.stdout.flush()
        print("\n")
        zip_file = ZipFile(f"download/{speaker}.zip")
        zip_file.extractall("work")
        zip_file.close()


for speaker in swara_speakers:
    manifest = open(f"work/{speaker.lower()}-manifest.csv", "w")

    for root, dirs, files in os.walk(f"work/{speaker}/txt/"):
        for filename in files:
            with open(f"{root}/{filename}", "r", encoding="utf-8") as handle:
                for line in handle:
                    words = line.replace(",", "").replace(".", "").replace("\n","").split(" ")

                    transcript_filename = filename.replace('corr', words[0])
                    wav_filename = f"{transcript_filename.replace('txt', 'wav')}"

                    transcript_path = f"output/text/{transcript_filename}"
                    wav_path = f"output/wav/{wav_filename}"

                    with open(transcript_path, "w") as output:
                        output.write(" ".join(words[1:]).lower())

                    rnd = transcript_filename.split("_")[1]
                    # shutil.copy(f"work/{speaker}/wav/{rnd}/{wav_filename}", wav_path)
                    try:
                        os.stat(wav_path)
                    except FileNotFoundError:
                        cmd = f"sox work/{speaker}/wav/{rnd}/{wav_filename} -r 16000 -b 16 -e signed-integer -c 1 {wav_path}"
                        os.system(cmd)

                    manifest.write(os.path.realpath(wav_path) + "," + os.path.realpath(transcript_path) + "\n")

    manifest.close()


