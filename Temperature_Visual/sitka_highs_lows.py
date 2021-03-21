'''

Höchst- und Tiefsttemperaturen in Sitka, Alaska vorbereiten und darstellen

'''


import csv
from datetime import datetime
import matplotlib.pyplot as plt

# CSV Datei mit den Temperaturen
filename = 'data/sitka_weather_2018_simple.csv.txt'
with open(filename) as f:
    reader = csv.reader(f)
    # Erste Zeile ist die Überschrift
    header_row = next(reader)
    print(header_row)

    # Datum, Höchsttemperatur und Tiefsttemperatur speichern in lists
    dates, highs, lows = [], [], []

    # Gehen die eingelesene Datei durch und speichern die passenden Dateien
    for row in reader:
        # Datum formatieren
        current_date = datetime.strptime(row[2], '%Y-%m-%d')
        # Höchst an vorletzter Stelle
        high = int(row[5])
        # Tiefst an letzter Stelle
        low = int(row[6])
        dates.append(current_date)
        highs.append(high)
        lows.append(low)

# Temperaturen plotten
plt.style.use('seaborn')
fig, ax = plt.subplots()
ax.plot(dates, highs, c='red', alpha=0.5)
ax.plot(dates, lows, c='blue', alpha=0.5)
plt.fill_between(dates, highs, lows, facecolor='blue', alpha=0.1)

# Formatierung vom Plot
plt.title("Daily high and low temperatures - 2018", fontsize=24)
plt.xlabel('', fontsize=16)
fig.autofmt_xdate()
plt.ylabel("Temperature(°F)", fontsize=16)
plt.tick_params(axis='both', which='major', labelsize=16)

plt.show()