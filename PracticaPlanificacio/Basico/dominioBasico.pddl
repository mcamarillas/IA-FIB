(define (domain dominioBasico)
    (:requirements :adl :typing)
    (:types habitacion reserva - object)

    (:predicates
        (reservada ?res - reserva ?hab - habitacion)
        (resuelta ?res - reserva)
    )

    (:functions
        (plazas ?hab - habitacion)
        (personas ?res - reserva)
        (inicio ?res - reserva)
        (fin ?res - reserva)
    )

    (:action reservar_Habitacion
        :parameters (?res - reserva ?hab - habitacion)
        :precondition (and (not (resuelta ?res)) (<= (personas ?res) (plazas ?hab))
                        (forall (?res2 - reserva)
                            (or (not (reservada ?res2 ?hab))
                                (or
          	                    (and (< (fin ?res) (inicio ?res2)))
          	                    (and (< (fin ?res2) (inicio ?res)))
          	                    )
          	                )
                        )
                    )
        :effect (and (resuelta ?res) (reservada ?res ?hab))
    )
)
