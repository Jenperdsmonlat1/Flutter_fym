# Flutter_fym
The android app of the project FuckYourMoney


# FuckYourMoney - Présentation

_FuckYourMoney_ est une application créer avec Dart, flutter et firebase pour la plateforme android vous permettant de gérer vos finances personnelles en toute simplicité. L'application tente d'être la plus design possible afin de permettre la meilleure expérience utilisateur possible.

# Installation et configuration

Pour configurer l'application, vous devrez créer un projet, puis ajouter une application pour android en cliquant sur _ajouter une application_ dans votre projet firebase.

Ensuite, vous devez créer 3 collections dans firestore:
- La collection _Depenses_ ainsi que les colonne depense(number), categorie(string) et date(string) devrons être initialisés.
- La collection _Balance_ ainsi que la colonne balance(number) devra être initialisé à 0.
- La collection _Recus_ ainsi que la colonne recu(number) devra aussi être initialisé à 0

Vous devrez aussi télécharger votre fichier **google-services.json** contenant les clés API avant de créer votre base de donnée.
Il sera à placer dans le répertoire `android/app/` du projet.

Maintenant, vous pouvez construire l'apk via la commande suivante:
```shell
flutter build apk
```

ou si vous souhaitez juste tester l'application via un émulateur:
Démarrez l'émulateur via la commande suivante:
```shell
emulator -avd <AVDName> -netspeed full
```

Lancer l'application via la commande suivante:
```shell
flutter run
```


Starrez et partager.
