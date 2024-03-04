##### SPRINT 2 #######

#####################################################################################################
############################# NIVEL 1 ###############################################################
#####################################################################################################

## Exercici 1
/* Mostra totes les transaccions realitzades per empreses d'Alemanya.*/

	SELECT 	*										# Seleciono todo los campos
	FROM 	transactions.company					# 
	JOIN 	transactions.transaction				# 
	ON		transaction.company_id = company.id		# 
	WHERE	company.country = "germany";			# Utilizo la función where para seleccionar solo alemania

## Exercici 2
/* Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.*/

# 1. Obtener el valor de la mediana de todas las transacciones
	SELECT AVG(amount) FROM transactions.transaction;
/* Este valor que obtengo, me servira para usarlo en un where o un having*/

# 2. Obtener una tabla que indique las empresas con nombre de pais que han hecho transacciones mayores que la media
	SELECT 	company.country ,company.id, transaction.amount
	FROM 	transactions.company					# 
	JOIN 	transactions.transaction				# 
	ON		transaction.company_id = company.id		# 
	WHERE	transaction.amount > (SELECT AVG(amount) FROM transactions.transaction);

# 3. Obtener un listado a partir de la tabla anterior de los paises que lo conforman

	SELECT DISTINCT Country
	FROM 
	(   SELECT 	company.Country, company.id, transaction.amount
		FROM 	transactions.company					# 
		JOIN 	transactions.transaction				# 
		ON		transaction.company_id = company.id		# 
		WHERE	transaction.amount > (SELECT AVG(amount) FROM transactions.transaction)
	) AS top
    ORDER BY	Country ASC;




