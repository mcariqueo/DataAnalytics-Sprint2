##### SPRINT 2 #######

###############################################################################
############################# NIVEL 1 #########################################
###############################################################################

## Exercici 1
/* Mostra totes les transaccions realitzades per empreses d'Alemanya.*/

SELECT 	*										# Seleciono todo los campos
FROM 	transactions.company					# 
JOIN 	transactions.transaction
ON		transaction.company_id = company.id
WHERE	company.country = "germany";			# Utilizo la función where para seleccionar solo alemania

## Exercici 2
/* Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.*/



  