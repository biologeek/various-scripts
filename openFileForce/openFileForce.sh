#!/bin/bash


####################################################################
####	Script de lancement automatisé dans le CRON		####
####------------------------------------------------------------####
####	@author : biologeek					####
####	@version : 1.0.0-SNAPSHOT				####
####	@description : This script launches $COMMANDE_OFFICE 	####
####	to open ODS sheet in LibreOffice. Opens it every day 	####
####	between $HEURE_LANCEMENT_MIN and $HEURE_LANCEMENT_MAX	####
####						####
####								####
####################################################################


. ./openFileForce.prm



if [ cut -c1-2 $DATE_MINUTE -ge $HEURE_LANCEMENT_MIN -a cut -c1-2 $DATE_MINUTE -le $HEURE_LANCEMENT_MAX ]
then

	## Temoin du jour, donc on sort
	if [ -f $FICHIER_TEMOIN_JOUR ]
	then 

		echo "$DATE : Fichier temoin, on laisse tomber" >> $LOG_FILE
		echo "$DATE : >> Sortie" >> $LOG_FILE
		exit 0

	else
	
		## Si temoin de la veille, on le supprime pour pas qu'ils s'accumulent
		if [ -f $TEMOIN_JOUR_M_1 ] 
		then

			rm -f $TEMOIN_JOUR_M_1
	
		fi
	
		## Si le programme est déja lancé, bon beh pas besoin de s'acharner, on sort gentiment 
		if [ $NB_LIGNES_COMMANDE -gt 1 ]
		then 

			echo "$DATE : Fichier deja ouvert, remplir les comptes du jour" >> $LOG_FILE
			echo "$DATE : >> Sortie" >> $LOG_FILE
			exit 0

		else
			## Sinon on ouvre
			echo "$DATE : Ouverture du fichier $FICHIER_COMPTES" >> $LOG_FILE

			$COMMANDE_OFFICE
			RES=$?
			if [ $RES -eq 0 ]
			then 
				touch $TEMOIN_JOUR
			else 
				echo "$DATE : *** Erreur sur ouverture de fichier" >> $LOG_FILE
			fi
		fi
	fi

else
	echo "$DATE : >> Sortie" >> $LOG_FILE

	exit 0
fi





