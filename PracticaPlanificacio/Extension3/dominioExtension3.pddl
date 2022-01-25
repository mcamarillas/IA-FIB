(define (domain dominioExtension3)
    (:requirements :adl :typing :equality :fluents)
    (:types habitacion reserva - object)

    (:predicates
        (reservada ?res - reserva ?hab - habitacion)
        (resuelta ?res - reserva)
    )

    (:functions
        (reservasNoAsignadas)
        (plazasMalgastadas)
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
          	                    (< (fin ?res) (inicio ?res2))
          	                    (< (fin ?res2) (inicio ?res))
          	                    )
          	                )
                        )
                    )
        :effect (and (resuelta ?res) (reservada ?res ?hab)  (increase (plazasMalgastadas) (-  (plazas ?hab) (personas ?res))))
    )

    (:action denegar_Reserva
        :parameters (?res - reserva ?hab - habitacion)
        :precondition (and (not (resuelta ?res)) (or (> (personas ?res) (plazas ?hab))
                        (exists (?res2 - reserva)
                            (and (reservada ?res2 ?hab)
                                (or
                                  (and (> (fin ?res) (inicio ?res2)) (< (fin ?res) (fin ?res2)))
                                  (and (> (fin ?res2) (inicio ?res)) (< (fin ?res2) (fin ?res)))
                                  )
                              )
                          )
                    	)
                    )
        :effect (and (resuelta ?res)(increase (reservasNoAsignadas) 1))
    ) 


)
