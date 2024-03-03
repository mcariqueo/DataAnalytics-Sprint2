


## Exercici 1

Mostra totes les transaccions realitzades per empreses d'Alemanya.

    SELECT 	*										 Selecciono todo los campos
    FROM 	transactions.company					 
    JOIN 	transactions.transaction                
    ON		transaction.company_id = company.id
    WHERE	company.country = "germany";			
                        # Utilizo la función where para seleccionar solo alemania


Ese codigo devuelve 118 filas que contiene informacion de las empresas que han realiado transacciones de Alemania.


[Output workbench](output_n1e1.md)



## Exercici 2

Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.



## Exercici 3
El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.

## Exercici 4
Van eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.
