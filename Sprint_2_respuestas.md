
# Sprint 2: Nivel 1

## Exercici 1

Mostra totes les transaccions realitzades per empreses d'Alemanya.

Para resolver este exercici utilizo el siguiente código: 

```sql
SELECT 	*
FROM 	transactions.company					 
JOIN 	transactions.transaction                
ON      transaction.company_id = company.id
WHERE	company.country = "germany";			
```

Utilizo la función WHERE para seleccionar solo las empresas de Alemania.
Este código devuelve 118 filas que contienen información de las empresas que han realizado transacciones desde Alemania.

![logo](files_sprin2\S2N1E1.png)

</details>

## Exercici 2

Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.

Informe de tancament de gestion: 

**Paso 1**: Obtener el valor de la media de todas las transacciones

```sql
SELECT AVG(amount) FROM transactions.transaction;
```

|AVG(amount)|
|-----------|
|256.735520|


**Paso 2**: Obtener una tabla que indique las empresas que han hecho transacciones mayores que la media

```sql
	SELECT 	DISTINCT company.company_name
	FROM 	transactions.company					# 
	JOIN 	transactions.transaction				# 
	ON		transaction.company_id = company.id		# 
	WHERE	transaction.amount > (SELECT AVG(amount) FROM transactions.transaction)
    ORDER BY company.company_name;
```

Utilizo las funciones AVG() y DISTINCT para calcular la media de las transacciones y obtener una lista única de países respectivamente.

El output es el siguiente:

![logo](files_sprin2\S2N1E2.png)


## Exercici 3

El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.

1. Lo primero es udentificar aquellas compañias que cumplent esto. En este caso bastarà con un JOIN y un WHERE con el comando LIKE.

```sql 
SELECT *
FROM 	transactions.company					# 
JOIN 	transactions.transaction				# 
ON		transaction.company_id = company.id		# 
WHERE   company.company_name LIKE "c%"; 
```
El comando _**LIKE**_ permite buscar un patrón, que en este caso es que la primera letra comience por "c".

El resultado es la siguiente tabla: 

![logo](files_sprin2\S2N1E3.png)


## Exercici 4

Van eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.

Hago una comparacion manual del numero de compañyas en cada tabla:  

```sql
SELECT DISTINCT company_id	FROM transaction;
SELECT          company_id	FROM transaction;
SELECT          id          FROM company;
```
Con esto observo que tanto transaction como company tienen el mismo numero de filas (100). Lo que indica que es posible que esten todas contenidas.

### Opcion 1

Para ello, deberia tener un tipo de join en el que tenga las emprseas que no tienen transacciones. Puedo usar un left join y buscar valores que sean nulo. 

Es decir, con un left join tendré una tabla con aquellas compañias que estando en la tabla company, en la tabla transacition no estan y por lo mismo, en este join el valor será null

```sql
SELECT          company.id, 
                transaction.amount
FROM            transactions.company						
LEFT JOIN       transactions.transaction		 
ON              transaction.company_id = company.id		
WHERE           transactions.company.id IS NULL;
```

### Opcion 2
Tambien podría utilizar una subquery para realizar la misma consulta

```sql
SELECT	company_id, transaction.amount
FROM	transaction
WHERE	company_id NOT IN (SELECT id FROM company);
```
- El _IN_ sirve para specify multiple possible values for a column, 
- Puedo generar una subquery con los valores de una tabla

En otras palabras, esta parte de la consulta selecciona solo aquellas filas de la tabla _**transaction**_ cuyo _company_id_ no está presente en la columna _id_ de la tabla _**company**_.

En ambos casos el resultado es null o vacio.


![](files_sprin2/S2N1E4.png)