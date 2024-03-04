

## Exercici 1

Mostra totes les transaccions realitzades per empreses d'Alemanya.

Para resolver este exercici utilizo el siguiente cogido: 

    SELECT 	*										 
    FROM 	transactions.company					 
    JOIN 	transactions.transaction                
    ON		transaction.company_id = company.id
    WHERE	company.country = "germany";			
    # Utilizo la función where para seleccionar solo Alemania


Ese código devuelve 118 filas que contiene información de las empresas que han realizado transacciones de Alemania.

El output 
[Output workbench](output_n1e1.md)


## Exercici 2

Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.

Informe de tancament de gestion: 

1. Obtener el valor de la mediana de todas las transacciones

        SELECT AVG(amount) FROM transactions.transaction;



2. Obtener una tabla que indique las empresas con nombre de pais que han hecho transacciones mayyores que la media

	    SELECT  company.country ,company.id, transaction.amount
	    FROM 	transactions.company					# 
	    JOIN 	transactions.transaction				# 
	    ON		transaction.company_id = company.id		# 
	    WHERE	transaction.amount > (SELECT AVG(amount) FROM transactions.transaction);

3. Obtener un listado a partir de la tabla anterior de los paises que lo conforman

        SELECT DISTINCT Country
        FROM 
        (   SELECT 	company.Country, company.id, transaction.amount
            FROM 	transactions.company					 
            JOIN 	transactions.transaction				 
            ON		transaction.company_id = company.id		 
            WHERE	transaction.amount > (SELECT AVG(amount) FROM transactions.transaction)) AS tabla_subquery

        ORDER BY	Country ASC;



## Exercici 3
El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.

## Exercici 4
Van eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.
