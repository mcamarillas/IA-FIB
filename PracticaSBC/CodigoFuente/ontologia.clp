;;; ---------------------------------------------------------
;;; ontologia.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia.owl
;;; :Date 04/12/2021 10:26:28

(defclass Servicio
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (single-slot posX
        (type INTEGER)
        (create-accessor read-write))
    (single-slot posY
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Centro_Cultural
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Centro_Deportivo
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Centro_Escolar
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Centro_Salud
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Centro_Social
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Comercio
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Ocio
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot nocturno
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Parque
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot acceso_perros
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Restauracion
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Transporte_Publico
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
    (multislot es_un
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Universidad
    (is-a Servicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass Vivienda
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Pertenece_a
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot topObjectProperty
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot amueblada
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot aparcamiento
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot isCasa
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot mascotas_permitidas
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot numero_baños
        (type INTEGER)
        (create-accessor read-write))
    (single-slot numero_dormitorios
        (type INTEGER)
        (create-accessor read-write))
    (single-slot piscina
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot posX
        (type INTEGER)
        (create-accessor read-write))
    (single-slot posY
        (type INTEGER)
        (create-accessor read-write))
    (single-slot precio
        (type FLOAT)
        (create-accessor read-write))
    (single-slot superficie
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Casa
    (is-a Vivienda)
    (role concrete)
    (pattern-match reactive)
    (multislot es_una
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot jardin
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot plantas
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Piso
    (is-a Vivienda)
    (role concrete)
    (pattern-match reactive)
    (multislot es_una
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot ascensor
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot balcon
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot piso
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Ciudad
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Tiene
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Distrito
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (single-slot Dispone_de
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot playa
        (type SYMBOL)
        (create-accessor read-write))
)

(definstances instances
    ([CasaPedralbes1] of Casa
         (jardin  "true")
         (plantas  3)
         (amueblada  "true")
         (aparcamiento  "true")
         (numero_baños  4)
         (numero_dormitorios  4)
         (piscina  "true")
         (posX  300)
         (posY  1200)
         (precio  8000)
         (superficie  400)
    )

    ([Pedralbes] of Distrito
         (playa  "false")
    )

    ([PisoPedralbes1] of Piso
    )

)
