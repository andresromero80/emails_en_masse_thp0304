# The Hacking Project

# Week 3 - Day 4 : Send Emails

## Team : THP Rennes - Mafia-BZH

Mailer File

Le fichier à vocation à envoyer les emails grâce à la gem gmail.

## Contributors :

* Erwan Baudiniere
* Alexandre Peccard 
* Andres Romero
* Arnaud Granval

## Présentation de l'équipe

* Erwan s'est occupé de faire tourner le twitter bot
* Andres a mis en place le système de scrapping
* Arnaud a créer le mailer
* Alexandre à gérer les views pour rendre le programme interactif.

# HowTo

## Description

Le programme s'articule autour de la classe Index qui instancie plusieurs managers et fait appel à eux via les méthodes :

* ``` call_scrapper ``` apelle la classe ScrapperManager qui gère la récupération de données sur un ensemble de pages web.

* ``` call_twitter_manager ``` apelle la classe TwitterManager qui initialise les clés de l'API twitter,
	prends le nom des communes et fais une recherche sur twitter à partir de ce nom en ajoutant mairie. Il renvoie le handle du
	premier résultat et le follow.
* ``` call_mailer ```

Toutes ces classes transmettent leurs résultats à la classe DBManager qui s'occupe de les sauvegarder dans un fichier CSV. C'est également elle qui fournit les données nécessaires aux fonctionnement des autres managers.

## Mode d'emploi

Lorsque vous executez le programme un menu vous propose diverses options :

* 1	pour utiliser le scrapping

* 2 pour utiliser le bot Twitter

* 3	pour envoyer des emails

* 4 pour quitter le programme

# Nos résultats

* 3 départements couverts comprenant environ 1200 communes
* Autour de 600 contacts récupérés
* Peu de mairies ont un compte twitter
* BEAUCOUP de mails envoyés