# TODO

- [x] Support imprimé en 3D (forme simple) avec openscad
- [ ] LEDs
    - Tester php (script qui modifi le contenu d'un fichier de conf /run/raspicam-led -> 0 ou 1)
    - Tester LED (classique, pas IR) sur RPi GPIO (Python)
    - Écrire le daemon qui allume/eteind la LED en fonction de /run/raspicam-led et le script init correspondant
- [ ] Installer/tester les LEDs infra rouge (GPIO, pas d'epoxy côté LED -> simple câble male/femelle pour chaque pattes de chaque LED) -> branchement serie ou parallele?, quelle resistance?, quelle intensité?, quelle tension? (+ synchro avec prise photos ?)
    -  IR led 950nm https://www.sparkfun.com/products/9349
    -  IR led 850nm (better for IR camera -> watch comments) https://www.sparkfun.com/products/9469
    -  https://www.sparkfun.com/products/10557
    -  https://www.sparkfun.com/products/9854

- [ ] Btn alim ON/OFF + led indiquant l'état ON/OFF du service
- [ ] HTTPS
- [ ] Accès à l'interface web depuis l'extérieur (internet) => renforcer la sécurité (iptables, apache, https, php/python, ssh, logs connexions, alertes, sudo, ...) (+ faire routeur/firewall/proxy RPi avant ?)
- [ ] Interface web interactive: PHP + apache ou python + serveur web python embarqué ?

- [ ] Servo moteurs pour diriger la caméra
- [ ] Prendre les photos seulement quand la page web est consultée pour réduire la conso ?
- [ ] Afficher la date de la prise de vue dans l'interface web
- [ ] Traitement des images avec opencv ?

