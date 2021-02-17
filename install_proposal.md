Installation
============

**Sollte bei der Installation irgendwelche Probleme bzw. komisches Verhalten auftreten, die ihr nicht
lösen könnt, dann bitte einen Post-It-Note mit der Problembeschreibung, aktuellem Zustand und ggf. Namen
auf den Rechner kleben und sich einem anderen Rechner zuwenden**


Installation
---------------------------

* Entstauben/Grundgereinigen
* PC an entsprechenden Arbeitsplatz anschließen
  * Ein Displaykabel anschließen
    * abhängig davon, was für Anschlüsse bereitstehen
    * Bei mehreren Möglichkeiten den besten Anschluss wählen (DP -> HDMI -> DVI -> VGA)
    * Bsp. PC mit DVI und VGA => DVI nutzen
  * Maus und Tastatur per USB anschließen
    * Wenn Maus an Tastatur angeschlossen ist, muss die Maus nicht an den PC angeschlossen werden
  * USB-Stick mit HeyAlter Image an einen USB 3-Port anschließen
    * Falls es keinen USB 3-Port gibt, irgendeinen USB-Port nutzen
  * Kaltgerätekabel bzw. Netzteil anschließen
* PC starten und das BIOS öffnen
  * In das BIOS kommt man in den meisten Fällen mit F2 oder ESC
  * BIOS Einstellungen:
    * Boot Security: Disable
    * Boot Mode
      * CSM oder
      * Legacy
      * am besten nicht UEFI (da funktioniert aktuell die automatische Installation nicht vollständig)
    * CPU Virtualisierung: ON
* BIOS Einstellungen speichern, PC neustarten und PC übers Bootmenü vom USB-Stick starten
  * Bootmenü ist in den meisten Fällen mit F12 oder F9 erreichbar
  * Dort USB-Stick auswählen
    * Wenn dieser dort doppelt auftaucht, den Eintrag ohne UEFI nehmen
* Das System installiert sich von selbst
  * Bei der Aufforderung den USB-Stick abzuziehen, den USB-Stick abziehen und PC mit Enter neustarten
* Einloggen mit Passwort `schule`
* `setup.sh` auf dem Desktop ausführen
  * Hier wird nochmal nach dem Passwort `schule` gefragt. Dies muss blind eingegeben werden und mit Enter bestätigt werden!
  * Computerspecs prüfen, mind. 4 Gb und 2 CPU-Kerne
  * Webcambild sollte bei vorhandener Webcam sichtbar sein
  * CD Laufwerk schließen, nachdem sie sich automatisch öffnet  
  * Chrome schließen, wenn er sich öffnet
* Prüfen, ob WLAN-Netzwerke gefunden werden können
* `cleanup.sh` auf dem Desktop ausführen 
* Fertig
