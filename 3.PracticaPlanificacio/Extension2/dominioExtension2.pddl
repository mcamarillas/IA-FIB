(define (domain dominioExtension2)
    (:requirements :adl :typing :fluents)
    (:types habitacion reserva - object)

    (:predicates
        (reservada ?res - reserva ?hab - habitacion)
        (resuelta ?res - reserva)
    )

    (:functions
        (total-cost)
        (plazas ?hab - habitacion)
        (pcardinalhab ?hab - habitacion)
        (pcardinalres ?res - reserva)
        (personas ?res - reserva)
        (inicio ?res - reserva)
        (fin ?res - reserva)
        (num-res)
    )

    (:action reservar_Habitacion_Perfecta
        :parameters (?res - reserva ?hab - habitacion)
        :precondition (and (not (resuelta ?res)) (<= (personas ?res) (plazas ?hab)) (= (pcardinalhab ?hab) (pcardinalres ?res))
                        (forall (?res2 - reserva)
                            (or (not (reservada ?res2 ?hab))
                                (or
          	                    (< (fin ?res) (inicio ?res2))
          	                    (< (fin ?res2) (inicio ?res))
          	                    )
          	                )
                        )
                    )
        :effect (and (resuelta ?res) (reservada ?res ?hab))
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
        :effect (and (resuelta ?res) (reservada ?res ?hab) (increase (total-cost) 1))
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
        :effect (and (resuelta ?res)(increase (total-cost) (num-res)))
    ) 
)
