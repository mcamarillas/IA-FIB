(deffunction print-justificaciones (?justificacionesBuenas)
	(loop-for-count (?i 1 (length$ ?justificacionesBuenas)) do
		(printout t "     -> "(nth$ ?i ?justificacionesBuenas) crlf)
	)
	(printout t crlf)
 )

 (defclass viviendaMuyBuena
 	(is-a USER)
 	(role concrete)
 	(single-slot v
 		(type INSTANCE)
 		(allowed-classes Vivienda)
 		(create-accessor read-write))
 	(single-slot penalizacion
 		(type INTEGER)
 		(create-accessor read-write))
 	(multislot factoresBuenos
 		(type STRING)
 		(create-accessor read-write))
 	(multislot factoresMalos
 		(type STRING)
 		(create-accessor read-write))
 )

 (defclass viviendaBuena
 	(is-a USER)
 	(role concrete)
 	(single-slot v
 		(type INSTANCE)
 		(allowed-classes Vivienda)
 		(create-accessor read-write))
 	(single-slot penalizacion
 		(type INTEGER)
 		(create-accessor read-write))
 	(multislot factoresBuenos
 		(type STRING)
 		(create-accessor read-write))
 	(multislot factoresMalos
 		(type STRING)
 		(create-accessor read-write))
 )

(defclass viviendaNormal
	(is-a USER)
	(role concrete)
	(single-slot v
		(type INSTANCE)
		(allowed-classes Vivienda)
		(create-accessor read-write))
	(single-slot penalizacion
		(type INTEGER)
		(create-accessor read-write))
	(multislot factoresBuenos
		(type STRING)
		(create-accessor read-write))
	(multislot factoresMalos
		(type STRING)
		(create-accessor read-write))
)

(defclass viviendaMala
	(is-a USER)
	(role concrete)
	(single-slot v
		(type INSTANCE)
		(allowed-classes Vivienda)
		(create-accessor read-write))
	(single-slot penalizacion
		(type INTEGER)
		(create-accessor read-write))
	(multislot factoresBuenos
		(type STRING)
		(create-accessor read-write))
	(multislot factoresMalos
		(type STRING)
		(create-accessor read-write))
)

;; Funcion para recibir una respuesta entera.
(deffunction preguntaInt
	 (?pregunta ?rangini ?rangfi)
	(printout t crlf)
	(format t "%s (De %d hasta %d) " ?pregunta ?rangini ?rangfi)
	(bind ?respuesta (read))
	(while (not(and(>= ?respuesta ?rangini)(<= ?respuesta ?rangfi))) do
		(format t "%s (De %d hasta %d) " ?pregunta ?rangini ?rangfi)
		(bind ?respuesta (read))
	)
	?respuesta
)

;; Funcion para recibir una respuesta De Casa Piso o Indiferente
(deffunction preguntaCasaPiso (?pregunta)
	(printout t crlf)
	(format t "%s (Piso / Casa / Indiferente) " ?pregunta)
	(bind ?respuesta (read))
	(while (not(or(eq ?respuesta Piso)(eq ?respuesta Casa)(eq ?respuesta Indiferente))) do
		(format t "%s (Piso / Casa / Indiferente) " ?pregunta)
		(bind ?respuesta (read))
	)
	?respuesta
)

;; Funcion para recibir una respuesta del la planta que quiere el usuario
(deffunction preguntaPlanta (?pregunta)
	(printout t crlf)
	(format t "%s (Bajo / Medio / Alto / Indiferente) " ?pregunta)
	(bind ?respuesta (read))
	(while (not(or(eq ?respuesta Bajo)(eq ?respuesta Medio) (eq ?respuesta Alto) (eq ?respuesta Indiferente))) do
		(format t "%s (Bajo / Medio / Alto / Indiferente) " ?pregunta)
		(bind ?respuesta (read))
	)
	?respuesta
)

;; Funcion para recibir una respuesta Si No o Indiferente
(deffunction preguntaSiNoIn(?pregunta)
	(printout t crlf)
	(format t "%s (si / no / indiferente) " ?pregunta)
	(bind ?respuesta (read))
	(while (not(or(eq ?respuesta si)(eq ?respuesta s)(eq ?respuesta no)(eq ?respuesta n)(eq ?respuesta indiferente)(eq ?respuesta i))) do
		(format t "%s (si / no / indiferente) " ?pregunta)
		(bind ?respuesta (read))
	)
	(if (or (eq ?respuesta si) (eq ?respuesta s))
       then TRUE
       else FALSE)
)

;; Funcion para recibir una respuesta Si No
(deffunction preguntaSiNo(?pregunta)
	(printout t crlf)
	(format t "%s (si / no) " ?pregunta)
	(bind ?respuesta (read))
	(while (not(or(eq ?respuesta si)(eq ?respuesta s)(eq ?respuesta no)(eq ?respuesta n))) do
		(format t "%s (si / no) " ?pregunta)
		(bind ?respuesta (read))
	)
	(if (or (eq ?respuesta si) (eq ?respuesta s))
       then TRUE
       else FALSE)
)

;;; template
(deftemplate infoUsuario
		(slot tipo (type STRING))
    (slot precioMax (type INTEGER))
		(slot edad (type INTEGER))
	  (slot numPersonas (type INTEGER))
    (slot numDorms (type INTEGER))
    (slot mascota (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
    (slot hijos (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
    (slot discapacitado (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
	  (slot coche (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
    (slot estudia (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot playa (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot deporte (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot comerFuera (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot transporte (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
    (slot piscina (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
    (slot balcon (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot cultura (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot amueblada (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
		(slot plantita (type STRING) ))


(defrule encontrarResultados "encontrarResultados"
	?infoUsuario <- (infoUsuario
		(tipo ?tipo)
		(precioMax ?pmax)
		(edad ?edad)
		(numDorms ?dorm)
		(numPersonas ?pers)
		(estudia ?est)
		(mascota ?mas)
		(hijos ?hij)
		(coche ?coche)
		(discapacitado ?disc)
		(playa ?playa)
		(deporte ?dep)
		(comerFuera ?com)
		(transporte ?tpublico)
		(piscina ?pis)
		(balcon ?bal)
		(cultura ?culto)
		(amueblada ?mueble)
		(plantita ?plant))
	?p <- (estudiaSolicitud)
	=>

	(bind $?viviendas (find-all-instances ((?inst Vivienda)) TRUE))
	(loop-for-count (?i 1 (length$ $?viviendas)) do

			(bind ?viviendaI (nth$ ?i ?viviendas))

			(bind ?penalizacion 0)

			(bind ?factoresFavorables (create$))
			(bind ?factoresDesfavorables (create$))

			;;COMPROBAR QUE NO SE EXCEDA DEL PRECIO DESEADO
			(bind ?precioI (send ?viviendaI get-precio))

			(if  (<= ?precioI ?pmax)
				then (bind ?penalizacion(+ ?penalizacion 0))
					(bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Precio adecuado"))
				else (bind ?penalizacion(+ ?penalizacion 100))
					(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Precio excesivo"))
			)

			;;COMPROBAR QUE LA VIVIENDA SEA DEL TIPO DESEADO
			(bind ?casa (send ?viviendaI get-isCasa))

			(if (eq ?tipo Indiferente) then (bind ?penalizacion(+ ?penalizacion 0)))

			(if (and(eq ?tipo Piso)(eq ?casa "false"))
				then (bind ?penalizacion(+ ?penalizacion 0))
				(bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Es un piso")))

			(if (and(eq ?tipo Piso)(eq ?casa "true"))
				then (bind ?penalizacion(+ ?penalizacion 100))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una casa")))

			(if (and(eq ?tipo Casa)(eq ?casa "true"))
				then (bind ?penalizacion(+ ?penalizacion 0))
				(bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Es una casa")))

			(if (and(eq ?tipo Casa)(eq ?casa "false"))
				then (bind ?penalizacion(+ ?penalizacion 100))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es un piso")))

			;;NUM DORMITORIOS ADECUADOS
			(bind ?ndorm (send ?viviendaI get-numero_dormitorios))
			(bind ?difdorm (- ?ndorm ?dorm))

			(if (eq ?difdorm 0)
				then (bind ?penalizacion(+ ?penalizacion 0))
				(bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tiene el numero de dormitorios deseado")))

			(if (eq ?difdorm 1)
				then (bind ?penalizacion(+ ?penalizacion 1))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Tiene un dormitorio mas de los pedidos")))

			(if (eq ?difdorm -1)
				then (bind ?penalizacion(+ ?penalizacion 10))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Tiene un dormitorio menos de los pedidos")))

			(if (eq ?difdorm 2)
				then (bind ?penalizacion(+ ?penalizacion 10))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Tiene dos dormitorios mas de los pedidos")))

			(if (and(> ?difdorm 2)(< ?difdorm -1))
				then (bind ?penalizacion(+ ?penalizacion 100))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "El numero de dormitorios se distancia mucho de los pedidos")))

			;;MASCOTAS
			(bind ?m (send ?viviendaI get-mascotas_permitidas))

			(if (eq ?mas TRUE)
				then (if  (eq ?m "true")
					then (bind ?penalizacion(+ ?penalizacion 0))
					else (bind ?penalizacion(+ ?penalizacion 1000))
						(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La casa no admite mascotas"))
				)
			)

			;;AMUEBLADA
			(bind ?amu (send ?viviendaI get-amueblada))

			(if (eq ?mueble TRUE)
				then (if  (eq ?amu "true")
					then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La casa esta amueblada"))
					else (bind ?penalizacion(+ ?penalizacion 100))
						(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La casa no esta amueblada"))
				)
			)


			;;GRANDARIA CASA EN FUNCION DEL NUMERO DE GENTE

			(bind ?t (send ?viviendaI get-superficie))


			(bind ?tp (<= ?t 60))
			(bind ?tm (and(> ?t 60) (<= ?t 100)))
			(bind ?tg (> ?t 100))



			(bind ?pg (<= ?pers 2))
			(bind ?ag (and(> ?pers 2)(<= ?pers 5)))
			(bind ?mg (> ?pers 5))

			(if (and (eq ?pg TRUE) (eq ?tg TRUE))
				then (bind ?penalizacion(+ ?penalizacion 5))
				(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La casa puede resultar demasiado grande"))
				else (if (and (eq ?ag TRUE) (eq ?tp TRUE))
						then (bind ?penalizacion(+ ?penalizacion 5))
						(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La casa puede resultar pequeña"))
						else (if (and(eq ?mg TRUE) (eq ?tp TRUE))
									then (bind ?penalizacion(+ ?penalizacion 10))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La casa puede resultar demasiado pequeña"))
									else (if (and (eq ?mg TRUE) (eq ?tm TRUE))
									then (bind ?penalizacion(+ ?penalizacion 5))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La casa puede resultar pequeña"))
								)
							)
					)

			)

			;;PLAYA
			(bind ?x (send ?viviendaI get-posX))
			(bind ?y (send ?viviendaI get-posY))

			(bind ?playaX (>= ?x 4000))

			(if (eq ?playa TRUE)
					then (if (eq ?playaX FALSE)
							then (bind ?distPlaya (+ (abs (- ?x 4000)) (abs (- ?y 0))))
								(if (<= ?distPlaya 1000)
									then (bind ?penalizacion(+ ?penalizacion 0))
									(bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La playa se encuentra cerca de la vivienda"))
									else (if (<= ?distPlaya 3000)
										then (bind ?penalizacion(+ ?penalizacion 5))
										(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La playa se encuentra un poco lejos de la vivienda"))
										else
											then (bind ?penalizacion(+ ?penalizacion 10))
											(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La playa se encuentra lejos de la vivienda"))

										)
								)
								else (if (<= ?y 1000)
											then (bind ?penalizacion(+ ?penalizacion 0))
											(bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La playa se encuentra cerca de la vivienda"))
											else (if (<= ?y 3000)
												then (bind ?penalizacion(+ ?penalizacion 5))
												(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La playa se encuentra un poco lejos de la vivienda"))
												else
													then (bind ?penalizacion(+ ?penalizacion 10))
													(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La playa se encuentra lejos de la vivienda"))

												)
										)
					)
			)


			;;PISCINA
			(bind ?piscis (send ?viviendaI get-piscina))

			(if (eq ?pis TRUE)
				then (if (eq ?piscis "true")
							then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La vivienda tiene piscina"))
							else (bind ?penalizacion(+ ?penalizacion 10))
							(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La vivienda no tiene piscina"))

					)
			)

			;;BALCON
			(if (and (eq ?bal TRUE) (eq ?casa "false"))
				then
				(bind ?balcony(send ?viviendaI get-balcon))
				(if (eq ?balcony "true")
							then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La vivienda tiene balcon"))
							else (bind ?penalizacion(+ ?penalizacion 10))
							(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La vivienda no tiene balcon"))

					)
			)

			;;ASCENSOR
			(if (and (eq ?casa FALSE) (or (eq ?disc TRUE) (>= ?edad 70)))
				then
				(bind ?asc(send ?viviendaI get-ascenor))
				(if (eq ?asc "true")
							then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La vivienda tiene ascensor"))
							else (bind ?penalizacion(+ ?penalizacion 10))
							(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La vivienda no tiene ascenor"))

					)
			)

			;;APARCAMIENTO
			(if (eq ?coche TRUE)
				then
				(bind ?pq(send ?viviendaI get-aparcamiento))
				(if (eq ?pq "true")
							then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La vivienda tiene aparcamiento"))
							else (bind ?penalizacion(+ ?penalizacion 5))
							(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "La vivienda no tiene aparcamiento"))

					)
			)

			;;TRANSPORTE PUBLICO
			(if (eq ?tpublico TRUE)
			then
				(bind ?tpcc 0)
				(bind ?tpmm 0)
				(bind $?transportes (find-all-instances ((?inst Transporte_Publico)) TRUE))
				(loop-for-count (?i 1 (length$ $?transportes)) do
						(bind ?tpI (nth$ ?i ?transportes))
						(bind ?xtp (send ?tpI get-posX))
						(bind ?ytp (send ?tpI get-posY))
						(bind ?disttp (+ (abs (- ?x ?xtp)) (abs (- ?y ?ytp))))

						(bind ?tpc (<= ?disttp 1000))
						(bind ?tpm (and(> ?disttp 1000) (<= ?disttp 3000)))

						(if (eq ?tpc TRUE)
						then (bind ?tpcc 1)
						else (if (eq ?tpm TRUE)
									then (bind ?tpmm 1))
						)
				)

					(if (eq ?tpcc 1)
					then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes transportes publicos cerca"))
					else (if (eq ?tpmm 1)
								then (bind ?penalizacion(+ ?penalizacion 2))
								(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun transporte publico muy cerca"))
								else (bind ?penalizacion(+ ?penalizacion 10))
								(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los transportes publicos se encuentran lejos de esta vivienda"))
								)
					)
				)


			;;OCIO
			(if (or (>= ?edad 70) (eq ?hij TRUE))
			then
				(bind ?occ 0)
				(bind $?ocios (find-all-instances ((?inst Ocio)) TRUE))
				(loop-for-count (?i 1 (length$ $?ocios)) do
						(bind ?oI (nth$ ?i ?ocios))
						(bind ?xo (send ?oI get-posX))
						(bind ?yo (send ?oI get-posY))
						(bind ?disto (+ (abs (- ?x ?xo)) (abs (- ?y ?yo))))

						(bind ?oc (<= ?disto 1000))

						(if (eq ?oc TRUE)
						then (bind ?occ 1))
				)

					(if (eq ?occ 1)
					then (bind ?penalizacion(+ ?penalizacion 5))
							(bind ?factoresDesfavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "La vivienda tiene centra un centro de ocio nocturno")))
				)

			;; CENTRO MEDICO
			(if (or (>= ?edad 70) (eq ?disc TRUE) )
			then
				(bind ?cscc 0)
				(bind ?csmm 0)
				(bind $?medicos (find-all-instances ((?inst Centro_Salud)) TRUE))
				(loop-for-count (?i 1 (length$ $?medicos)) do
						(bind ?csI (nth$ ?i ?medicos))
						(bind ?xcs (send ?csI get-posX))
						(bind ?ycs (send ?csI get-posY))
						(bind ?distcs (+ (abs (- ?x ?xcs)) (abs (- ?y ?ycs))))

						(bind ?csc (<= ?distcs 1000))
						(bind ?csm (and(> ?distcs 1000) (<= ?distcs 2500)))

						(if (eq ?csc TRUE)
						then (bind ?cscc 1)
						else (if (eq ?csm TRUE)
									then (bind ?csmm 1))
						)
				)

					(if (eq ?cscc 1)
					then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un centro de salud cerca"))
					else (if (eq ?csmm 1)
								then (bind ?penalizacion(+ ?penalizacion 2))
								(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun centro de salud muy cerca"))
								else (bind ?penalizacion(+ ?penalizacion 5))
								(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los centros de salud se encuentran lejos de esta vivienda"))
								)
					)
				)



				;; CENTRO ESCOLAR
				(if (eq ?hij TRUE)
				then
					(bind ?cecc 0)
					(bind ?cemm 0)
					(bind $?escuelas (find-all-instances ((?inst Centro_Escolar)) TRUE))
					(loop-for-count (?i 1 (length$ $?escuelas)) do
							(bind ?ceI (nth$ ?i ?escuelas))
							(bind ?xce (send ?ceI get-posX))
							(bind ?yce (send ?ceI get-posY))
							(bind ?distce (+ (abs (- ?x ?xce)) (abs (- ?y ?yce))))

							(bind ?cec (<= ?distce 1200))
							(bind ?cem (and(> ?distce 1200) (<= ?distce 3000)))

							(if (eq ?cec TRUE)
							then (bind ?cecc 1)
							else (if (eq ?cem TRUE)
										then (bind ?cemm 1))
							)
					)

						(if (eq ?cecc 1)
						then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un centro escolar cerca"))
						else (if (eq ?cemm 1)
									then (bind ?penalizacion(+ ?penalizacion 2))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun centro escolar muy cerca"))
									else (bind ?penalizacion(+ ?penalizacion 5))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los centros escolares se encuentran lejos de esta vivienda"))
									)
						)
					)

			;;COMPROBAR QUE LA PLANTA DEL PISO ES ADECUADA
			(if (and (eq ?casa "false") (not(eq ?plant Indiferente)))
			then
						(bind ?pl (send ?viviendaI get-piso))
						(bind ?pb (<= ?pl 2))
						(bind ?pm (and(> ?pl 2) (<= ?pl 6)))
						(bind ?pa (> ?pl 6))

						(if (eq ?plant Bajo)
						then (if (eq ?pb TRUE)
									then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Es una planta baja"))
									else (if (eq ?pm TRUE)
												then (bind ?penalizacion(+ ?penalizacion 1))
												(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una planta media"))
												else (bind ?penalizacion(+ ?penalizacion 5))
												(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una planta alta"))
												)
									)
						else (if (eq ?plant Medio)
									then (if (eq ?pm TRUE)
												then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Es una planta media"))
												else (if (eq ?pb TRUE)
															then (bind ?penalizacion(+ ?penalizacion 1))
															(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una planta baja"))
															else (bind ?penalizacion(+ ?penalizacion 1))
															(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una planta alta"))
															)
												)

									else (if (eq ?pa TRUE)
												then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Es una planta alta"))
												else (if (eq ?pb TRUE)
															then (bind ?penalizacion(+ ?penalizacion 5))
															(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una planta baja"))
															else (bind ?penalizacion(+ ?penalizacion 1))
															(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Es una planta media"))
															)
												)
									)

						)
			)

			;; CENTRO CULTURAL
			(if (eq ?culto TRUE)
			then
				(bind ?ccc 0)
				(bind ?mcc 0)
				(bind $?centrosCulturales (find-all-instances ((?inst Centro_Cultural)) TRUE))
				(loop-for-count (?i 1 (length$ $?centrosCulturales)) do
						(bind ?ccI (nth$ ?i ?centrosCulturales))
						(bind ?xcc (send ?ccI get-posX))
						(bind ?ycc (send ?ccI get-posY))
						(bind ?distcc (+ (abs (- ?x ?xcc)) (abs (- ?y ?ycc))))

						(bind ?cc (<= ?distcc 1000))
						(bind ?cm (and(> ?distcc 1000) (<= ?distcc 3000)))

						(if (eq ?cc TRUE)
						then (bind ?ccc 1)
						else (if (eq ?cm TRUE)
									then (bind ?mcc 1))
						)
				)

					(if (eq ?ccc 1)
					then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un centro cultural cerca"))
					else (if (eq ?mcc 1)
								then (bind ?penalizacion(+ ?penalizacion 1))
								(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun centro cultural muy cerca"))
								else (bind ?penalizacion(+ ?penalizacion 2))
								(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los centros culturales se encuentran lejos de esta vivienda"))
								)
					)
				)

				;; PARQUE
				(if (or (>= ?edad 70) (eq ?hij TRUE) (eq ?disc TRUE) (eq ?mas TRUE))
				then
					(bind ?pcc 0)
					(bind ?pmm 0)
					(bind ?ppcc 0)
					(bind ?ppmm 0)
					(bind $?parques (find-all-instances ((?inst Parque)) TRUE))
					(loop-for-count (?i 1 (length$ $?parques)) do
							(bind ?pI (nth$ ?i ?parques))
							(bind ?xp (send ?pI get-posX))
							(bind ?yp (send ?pI get-posY))
							(bind ?distp (+ (abs (- ?x ?xp)) (abs (- ?y ?yp))))

							(bind ?pc (<= ?distp 500))
							(bind ?pm (and(> ?distp 500) (<= ?distp 1500)))

							(bind ?paperros (send ?pI get-acceso_perros))

							(if (eq ?pc TRUE)
							then (bind ?pcc 1) (if (eq ?paperros "true") then (bind ?ppcc 1))
							else (if (eq ?pm TRUE)
										then (bind ?pmm 1) (if (eq ?paperros "true") then (bind ?ppmm 1)))
							)
					)

						(if (or(eq ?disc TRUE) (eq ?hij TRUE) (>= ?edad 70))
							then (if (eq ?pcc 1)
										then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un parque cerca"))
										else (if (eq ?pmm 1)
													then (bind ?penalizacion(+ ?penalizacion 2))
													(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun parque muy cerca"))
													else (bind ?penalizacion(+ ?penalizacion 5))
													(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los parques se encuentran lejos de esta vivienda"))
													)
									)
						)
						(if (eq ?mas TRUE)
							then (if (eq ?ppcc 1)
										then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un parque que admite mascotas cerca"))
										else (if (eq ?ppmm 1)
													then (bind ?penalizacion(+ ?penalizacion 2))
													(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun parque que admita mascotas muy cerca"))
													else (bind ?penalizacion(+ ?penalizacion 5))
													(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los parques que admiten mascotas se encuentran lejos de esta vivienda"))
													)
									)
						)

					)

				;; UNI
				(if (eq ?est TRUE)
				then
					(bind ?ucc 0)
					(bind ?umm 0)
					(bind $?unis (find-all-instances ((?inst Universidad)) TRUE))
					(loop-for-count (?i 1 (length$ $?unis)) do
							(bind ?uI (nth$ ?i ?unis))
							(bind ?xu (send ?uI get-posX))
							(bind ?yu (send ?uI get-posY))
							(bind ?distu (+ (abs (- ?x ?xu)) (abs (- ?y ?yu))))

							(bind ?uc (<= ?distu 2200))
							(bind ?um (and(> ?distu 2200) (<= ?distu 5000)))

							(if (eq ?uc TRUE)
							then (bind ?ucc 1)
							else (if (eq ?um TRUE)
										then (bind ?umm 1))
							)
					)

						(if (eq ?ucc 1)
						then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes una universidad cerca"))
						else (if (eq ?umm 1)
									then (bind ?penalizacion(+ ?penalizacion 1))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ninguna universidad muy cerca"))
									else (bind ?penalizacion(+ ?penalizacion 5))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Las universidades se encuentran lejos de esta vivienda"))
									)
						)
					)

				;; RESTAURANTES
				(if (eq ?com TRUE)
				then
					(bind ?rc 0)
					(bind ?rm 0)
					(bind $?restaurantes (find-all-instances ((?inst Restauracion)) TRUE))
					(loop-for-count (?i 1 (length$ $?restaurantes)) do
							(bind ?rI (nth$ ?i ?restaurantes))
							(bind ?xr(send ?rI get-posX))
							(bind ?yr (send ?rI get-posY))
							(bind ?distr (+ (abs (- ?x ?xr)) (abs (- ?y ?yr))))

							(bind ?rcc (<= ?distr 600))
							(bind ?rmm (and(> ?distr 600) (<= ?distr 2000)))


							(if (eq ?rcc TRUE)
							then (bind ?rc 1)
							else (if (eq ?rmm TRUE)
										then (bind ?rm 1))
							)
					)

						(if (eq ?rc 1)
						then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un restaurante cerca"))
						else (if (eq ?rm 1)
									then (bind ?penalizacion(+ ?penalizacion 1))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun restaurante a la vuelta de la esquina"))
									else (bind ?penalizacion(+ ?penalizacion 5))
									(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los restaurantes se encuentran lejos de esta vivienda"))
									)
						)
					)

					;; CENTROS DEPORTIVOS
					(if (eq ?dep TRUE)
					then
						(bind ?dc 0)
						(bind ?dm 0)
						(bind $?restaurantes (find-all-instances ((?inst Restauracion)) TRUE))
						(loop-for-count (?i 1 (length$ $?restaurantes)) do
								(bind ?dI (nth$ ?i ?restaurantes))
								(bind ?xd(send ?dI get-posX))
								(bind ?yd (send ?dI get-posY))
								(bind ?distd (+ (abs (- ?x ?xd)) (abs (- ?y ?yd))))

								(bind ?dcc (<= ?distd 1000))
								(bind ?dmm (and(> ?distd 1000) (<= ?distd 3000)))


								(if (eq ?dcc TRUE)
								then (bind ?dc 1)
								else (if (eq ?dmm TRUE)
											then (bind ?dm 1))
								)
						)

							(if (eq ?dc 1)
							then (bind ?factoresFavorables (insert$ ?factoresFavorables (+ (length$ ?factoresFavorables) 1) "Tienes un centro deportivo cerca"))
							else (if (eq ?dm 1)
										then (bind ?penalizacion(+ ?penalizacion 1))
										(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "No tienes ningun centro deportivo a la vuelta de la esquina"))
										else (bind ?penalizacion(+ ?penalizacion 5))
										(bind ?factoresDesfavorables (insert$ ?factoresDesfavorables (+ (length$ ?factoresDesfavorables) 1) "Los centros deportivos se encuentran lejos de esta vivienda"))
										)
							)
						)





			;;La guardamos como clase de tipo "candidato" -> la subclase es segun la puntuación que ha obtenido
			(if (<= ?penalizacion 10) then (make-instance (gensym) of viviendaMuyBuena (v ?viviendaI) (penalizacion ?penalizacion) (factoresBuenos ?factoresFavorables)  (factoresMalos ?factoresDesfavorables)))
			(if (and (> ?penalizacion 10) (<= ?penalizacion 50)) then (make-instance (gensym) of viviendaBuena (v ?viviendaI) (penalizacion ?penalizacion) (factoresBuenos ?factoresFavorables)  (factoresMalos ?factoresDesfavorables)))
			(if (and (> ?penalizacion 50) (<= ?penalizacion 100)) then (make-instance (gensym) of viviendaNormal (v ?viviendaI) (penalizacion ?penalizacion) (factoresBuenos ?factoresFavorables)  (factoresMalos ?factoresDesfavorables)))
			(if (> ?penalizacion 100) then (make-instance (gensym) of viviendaMala (v ?viviendaI) (penalizacion ?penalizacion) (factoresBuenos ?factoresFavorables)  (factoresMalos ?factoresDesfavorables)))

	)


	(printout t crlf)
	(printout t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   CASAS MALAS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" crlf)
	(printout t crlf)

	(bind ?respuestas (find-all-instances ((?inst viviendaMala)) TRUE))
	(printout t crlf)
	(loop-for-count (?i 1 (length$ ?respuestas)) do
			(bind ?vI (nth$ ?i ?respuestas))
			(printout t "-> Vivienda " ?i ":")
			(printout t " "(instance-name (send ?vI get-v)) " " crlf)
			(printout t crlf)
			(printout t "PUNTOS A FAVOR:" crlf)
			(print-justificaciones(send ?vI get-factoresBuenos))
			(printout t crlf)
			(printout t "PUNTOS EN CONTRA:" crlf)
			(print-justificaciones(send ?vI get-factoresMalos))
			(printout t "=============================================================================================" crlf)
			(printout t crlf)

	)

	(printout t crlf)
	(printout t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   CASAS NORMALES  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" crlf)
	(printout t crlf)

	(bind ?respuestas (find-all-instances ((?inst viviendaNormal)) TRUE))
	(printout t crlf)
	(loop-for-count (?i 1 (length$ ?respuestas)) do
			(bind ?vI (nth$ ?i ?respuestas))
			(printout t "-> Vivienda " ?i ":")
			(printout t " "(instance-name (send ?vI get-v)) " " crlf)
			(printout t crlf)
			(printout t "PUNTOS A FAVOR:" crlf)
			(print-justificaciones(send ?vI get-factoresBuenos))
			(printout t crlf)
			(printout t "PUNTOS EN CONTRA:" crlf)
			(print-justificaciones(send ?vI get-factoresMalos))
			(printout t "=============================================================================================" crlf)
			(printout t crlf)

	)

	(printout t crlf)
	(printout t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   CASAS BUENAS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" crlf)
	(printout t crlf)

	(bind ?respuestas (find-all-instances ((?inst viviendaBuena)) TRUE))
	(printout t crlf)
	(loop-for-count (?i 1 (length$ ?respuestas)) do
			(bind ?vI (nth$ ?i ?respuestas))
			(printout t "-> Vivienda " ?i ":")
			(printout t " "(instance-name (send ?vI get-v)) " " crlf)
			(printout t crlf)
			(printout t "PUNTOS A FAVOR:" crlf)
			(print-justificaciones(send ?vI get-factoresBuenos))
			(printout t crlf)
			(printout t "PUNTOS EN CONTRA:" crlf)
			(print-justificaciones(send ?vI get-factoresMalos))
			(printout t "=============================================================================================" crlf)
			(printout t crlf)

	)

	(bind ?respuestas (find-all-instances ((?inst viviendaMuyBuena)) TRUE))
	(if (eq (length$ ?respuestas) 0) then (printout t "No hemos encontrado ninguna vivienda perfecta para usted" crlf)
		else (printout t crlf)
		(printout t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   CASAS MUY BUENAS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" crlf)
		(printout t crlf)
		(printout t crlf)
		(loop-for-count (?i 1 (length$ ?respuestas)) do
				(bind ?vI (nth$ ?i ?respuestas))
				(printout t " "(instance-name (send ?vI get-v)) " " crlf)
				(printout t crlf)
				(printout t "PUNTOS A FAVOR:" crlf)
				(print-justificaciones(send ?vI get-factoresBuenos))
				(printout t crlf)
				(printout t "PUNTOS EN CONTRA" crlf)
				(print-justificaciones(send ?vI get-factoresMalos))
				(printout t "=============================================================================================" crlf)
				(printout t crlf)

		)
	)

	(retract ?p)
)


(defrule main "main"

	(initial-fact)
	=>
	(printout t crlf)
	(printout t "--------------------------------------------------------------" crlf)
	(printout t "------------- SISTEMA RECOMENDADOR DE VIVIENDAS --------------" crlf)
	(printout t "--------------------------------------------------------------" crlf)
	(assert (preguntitas))
	)

	(defrule preguntitas "Pregunta las preferencias deseadas por los usuarios"
	?p <- (preguntitas)
	=>
	;;Precio maximo
	(bind ?tipo (preguntaCasaPiso "-> ¿Estas buscando una casa, un piso o te es indiferente?"))
	(bind ?pmax (preguntaInt "->  ¿Precio mensual maximo que estas dispuesto a pagar?" 0 100000))
	(bind ?edad (preguntaInt "->  ¿Cuantos años tienes?" 18 120))
	(bind ?dorm (preguntaInt "->  ¿Numero de dormitorios?" 1 8))
	(bind ?pers (preguntaInt "->  ¿Numero de personas que viviran en la vivienda?" 1 10))
	(bind ?est (preguntaSiNoIn "->  ¿Buscas vivienda cerca de un centro universitario?"))
	(bind ?mas (preguntaSiNo "->  ¿Tienes mascota?"))
	(bind ?hij (preguntaSiNo "->  ¿Tienes hijos pequeños?"))
	(bind ?coche (preguntaSiNoIn "->  ¿Quieres que la vivienda tenga parking?"))
	(bind ?disc (preguntaSiNo "->  ¿Eres o vives con alguna persona con algun tipo de discapacidad?"))
	(bind ?playa (preguntaSiNoIn "->  ¿Quieres vivir cerca de la playa?"))
	(bind ?dep (preguntaSiNo "->  ¿Fruecuentas centros deportivos?"))
	(bind ?com (preguntaSiNoIn "->  ¿Desea que la vivienda cuente con centros de restauracion cercanos?"))
	(bind ?tpublico (preguntaSiNo "->  ¿Utilizas frecuentemente el transporte publico?"))
	(bind ?pis (preguntaSiNoIn "->  ¿Quieres que la vivienda tenga piscina?"))
	(bind ?bal FALSE)
	(if (or (eq ?tipo Piso) (eq ?tipo Indiferente))
			then (bind ?bal (preguntaSiNoIn "->  ¿Quieres balcon?")))
	(bind ?culto(preguntaSiNo "->  ¿Visitas centros culturales con frecuencia?"))
	(bind ?mueble (preguntaSiNoIn "->  ¿Quieres la vivienda amueblada?"))
	(bind ?plant Indiferente)
	(if (or (eq ?tipo Piso) (eq ?tipo Indiferente))
			then (bind ?plant (preguntaPlanta "->  ¿Prefrefieres vivir en un piso en una planta baja, media o alta?")))


	(retract ?p)
	(assert (infoUsuario
		(tipo ?tipo)
		(precioMax ?pmax)
		(edad ?edad)
		(numDorms ?dorm)
		(numPersonas ?pers)
		(estudia ?est)
		(mascota ?mas)
		(hijos ?hij)
		(coche ?coche)
		(discapacitado ?disc)
		(playa ?playa)
		(deporte ?dep)
		(comerFuera ?com)
		(transporte ?tpublico)
		(piscina ?pis)
		(balcon ?bal)
		(cultura ?culto)
		(amueblada ?mueble)
		(plantita ?plant)
		)
	)
	(assert (estudiaSolicitud))
)
