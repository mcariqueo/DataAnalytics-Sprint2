##### SPRINT 2 #######
############################# NIVEL 1 #########################
## Exercici 1
/* Mostra totes les transaccions realitzades per empreses d'Alemanya.*/

	SELECT 	*										
	FROM 	transactions.company					 
	JOIN 	transactions.transaction				 
	ON		transaction.company_id = company.id		 
	WHERE	company.country = "germany";			

## Exercici 2
/* Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.*/

	# 1. Obtener el valor de la mediana de todas las transacciones
    
	SELECT AVG(amount) FROM transactions.transaction;
    
	/* Este valor que obtengo, me servira para usarlo en un where o un having*/

	/* 2. Obtener una tabla que indique las empresas con nombre de pais 
    que han hecho transacciones mayores que la media*/
    
	SELECT 	DISTINCT company.company_name
	FROM 	transactions.company					# 
	JOIN 	transactions.transaction				# 
	ON		transaction.company_id = company.id		# 
	WHERE	transaction.amount > (SELECT AVG(amount) FROM transactions.transaction)
    ORDER BY company.company_name;


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
		SELECT  		id  		FROM company;	
   		SELECT 			company_id	FROM transaction;
        SELECT DISTINCT company_id	FROM transaction;

## Opcion 1:
/* para ellos deberia entonces tener un tipo de join en el que tenga las empreseas que no tienen transacciones*/

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



# Sprint 2 - Nivel 2

## Exercici 1
/* Per a això, et demanen la llista de totes les transaccions realitzades per empreses
 que estan situades en el mateix país que aquesta companyia*/

SELECT transaction.* FROM transaction 
JOIN company on company.id = transaction.company_id
WHERE company.country = 
	(SELECT distinct company.country FROM transaction 
    JOIN company on company.id = transaction.company_id
    WHERE company_name = "Nunc interdum incorporated");

# Exercici 2
/* El departament de comptabilitat necessita que trobis l'empresa que ha realitzat 
la transacció de major suma en la base de dades.*/

SELECT company.company_name FROM transaction 
join   company on company.id = transaction.company_id
WHERE amount = (SELECT max(amount) FROM transaction);

# Sprint 2 - Nivell 3
## Exercici 1
/* necessiten el llistat dels països la mitjana de transaccions dels quals sigui superior a la mitjana general.*/

SELECT DISTINCT company.country FROM transaction
JOIN company on company.id = transaction.company_id
WHERE amount > (SELECT AVG (amount) FROM transaction)
ORDER BY 1;

## Exercici 2
/* Vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.*/

SELECT 		company.company_name,
    CASE	WHEN COUNT(transaction.id) < 4	THEN "Menys de 4 transacciones"
			ELSE "Més de 4 transaccions"	END AS result
FROM		transaction
JOIN		company ON company.id = transaction.company_id
GROUP BY	company.company_name;




SELECT 
    company.company_name,
    CASE 
        WHEN COUNT(transaction.id) > 4 THEN 'Más de 4 transacciones' 
        ELSE 'Menos de 4 transacciones' 
    END AS cantidad_transacciones
FROM 
    transaction
JOIN 
    company ON company.id = transaction.company_id
GROUP BY 
    company.company_name;


