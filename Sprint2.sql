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

# Exercici 3
/*El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.*/

SELECT *
        FROM 	transactions.company					# 
	    JOIN 	transactions.transaction				# 
	    ON		transaction.company_id = company.id		# 
        WHERE   company.company_name LIKE "c%"; 

# Exercici 4

/* Van eliminar del sistema les empreses que no tenen transaccions registrades,
 lliura el llistat d'aquestes empreses*/
  


#  Hago una comparacion manual del numero de compañyas en cada tabla:  
		SELECT DISTINCT company_id	FROM transaction;
		SELECT 			company_id	FROM transaction;
		SELECT  		id  		FROM company;

## Opcion 1:
/* para ellos deberia entonces tener un tipo de join en el que tenga las emprseas que no tienen transacciones*/

/* Puedo usar un left join y buscar valores que sean nulo. Es decir, con un left join tendré una tabla con aquellas compañias que estando en la tabla company, en la tabla transacition no estan y por lo mismo, en este join el valor será null*/ 

 		SELECT 		company.id, 
					transaction.amount
		FROM 		transactions.company						
		LEFT JOIN	transactions.transaction		 
		ON			transaction.company_id = company.id		
        WHERE 		transactions.company.id IS NULL;

/* tambien pudria utilizar una subquery para realizar la misma consulta*/ 

		SELECT	company_id, transaction.amount
		FROM	transaction
		WHERE	company_id NOT IN (SELECT id FROM company);

/* el IN sirve para specify multiple possible values for a column, esto lo realiza a traves de una lista de valores , tipo tupla.
puedo generar una subquery con los valores de una tabla, que en este caso es lo que hago i*/


