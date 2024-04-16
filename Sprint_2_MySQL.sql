##### SPRINT 2 #######
############################# NIVEL 1 #########################
## Exercici 1
/* Mostra totes les transaccions realitzades per empreses d'Alemanya.*/

		SELECT 	*	
    FROM 	transaction 
    WHERE 	company_id 	IN 
			(SELECT	id	
             FROM	company
             WHERE	country = "germany");			

## Exercici 2
/* Màrqueting està preparant alguns informes de tancaments de gestió,
 et demanen que els passis un llistat de les empreses que han realitzat
 transaccions per una suma superior a la mitjana de totes les transaccions.*/

	# 1. Obtener el valor de la mediana de todas las transacciones
    
	SELECT AVG(amount) FROM transactions.transaction;
        
	
	SELECT 	company_name
	FROM 			 company			
	WHERE id IN (SELECT	company_id	
				 FROM transaction 
                 WHERE amount > (SELECT AVG(amount) FROM transaction));


# Exercici 3
/*El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, 
però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. 
Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.*/

		SELECT *			FROM 	transaction
        WHERE	company_id 	IN 
							(SELECT id 
							 FROM 	company 
							 WHERE  company_name LIKE "c%"); 

        
	

# Exercici 4

/* Van eliminar del sistema les empreses que no tenen transaccions registrades,
 lliura el llistat d'aquestes empreses*/

# Sprint 2 - Nivel 2

## Exercici 1
/* Per a això, et demanen la llista de totes les transaccions realitzades per empreses
 que estan situades en el mateix país que aquesta companyia*/

SELECT	*	
FROM 	transaction
WHERE 	company_id IN (
		SELECT id FROM company WHERE country = (SELECT country FROM company WHERE company_name = 'Non Institute'));

# Exercici 2
/* El departament de comptabilitat necessita que trobis l'empresa que ha realitzat 
la transacció de major suma en la base de dades.*/

SELECT	c.company_name,	t.amount	
FROM	company c
JOIN	transaction t	
ON		t.company_id = c.id 
WHERE	t.amount = (SELECT max(amount) FROM transaction);

SELECT 
    company_id,
    (SELECT company_name FROM company WHERE id = t.company_id) 	AS nombre,
    (SELECT max(amount) FROM transaction) 						AS monto
FROM	transaction t
WHERE	amount = (SELECT max(amount) FROM transaction);

# Sprint 2 - Nivell 3
## Exercici 1
/* necessiten el llistat dels països la mitjana de transaccions 
dels quals sigui superior a la mitjana general.*/



SELECT country, ROUND(AVG(total_amount), 2) AS average_amount
FROM	(SELECT	country,
		(SELECT	sum(amount) FROM transaction WHERE company_id = company.id) AS total_amount
         FROM company) AS subtable
GROUP BY country
HAVING average_amount > (SELECT AVG (amount) FROM transaction)
ORDER BY average_amount DESC;


## Exercici 2
/* Vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.*/

SELECT	company_id,
		(SELECT company_name FROM company c WHERE id IN (company_id)) AS nombre,
		CASE 	WHEN num_transactions < 4 		THEN 'Menys de 4 transacciones'
				ELSE 'Més de 4 transaccions' 	END AS result
FROM	(SELECT t.company_id , 
				COUNT(t.id) AS num_transactions  
				FROM transaction t  GROUP BY  t.company_id) AS transaction_counts;




