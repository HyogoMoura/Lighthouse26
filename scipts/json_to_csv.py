import os
import json
import csv
import shutil
from pathlib import Path

RAW_DIR = Path("../data_raw")              # Pasta com JSONs
SEEDS_DIR = Path("../lh_nautical/seeds")   # Pasta seeds do dbt

def convert_json_to_csv(input_file: Path, output_file: Path):
    """Converte um arquivo JSON em CSV."""
    with open(input_file, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Se o JSON for um único objeto, transforma em lista
    if isinstance(data, dict):
        data = [data]

    # Descobre os campos automaticamente
    keys = sorted(list({key for row in data for key in row.keys()}))

    with open(output_file, "w", newline="", encoding="utf-8") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=keys)
        writer.writeheader()
        writer.writerows(data)

    print(f"✔ Convertido: {input_file.name} → {output_file.name}")


def main():
    #caso pasta seed nao exista, criar
    SEEDS_DIR.mkdir(parents=True, exist_ok=True)

    for file in RAW_DIR.glob("*.json"):
        output_file = SEEDS_DIR / f"{file.stem}.csv"
        convert_json_to_csv(file, output_file)
    for file in RAW_DIR.glob("*.csv"):
        output_file = SEEDS_DIR / file.name
        shutil.copy(file, output_file)
        print(f"✔ Movido:Copia do arquivos csv {file.name} → {output_file.name}")


    print("\n🎉 Conversão e atualizacção de dados concluída! Agora rode:")
    print("   dbt seed\n")


if __name__ == "__main__":
    main()