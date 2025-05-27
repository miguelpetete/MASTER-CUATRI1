(define (problem roverprob-big)
    (:domain Rover6)
    (:objects
        landerA - lander
        colour high_res - mode
        rover0 rover1 - rover
        rover0store rover1store - store
        waypoint0 waypoint1 waypoint2 waypoint3 waypoint4 - waypoint ;annadimos un nuevo waypoint
        camera0 camera1 - camera
        objective0 objective1 - objective
    )
    (:init
        (at_lander landerA waypoint0)
        (channel_free landerA)

        (at rover0 waypoint3)
        (at rover1 waypoint4)
        (available rover0)
        (available rover1)

        (store_of rover0store rover0)
        (store_of rover1store rover1)
        (empty rover0store)
        (empty rover1store)

        (equipped_for_soil_analysis rover0)
        (equipped_for_rock_analysis rover0)
        (equipped_for_imaging rover0)
        (equipped_for_imaging rover1)

        (at_rock_sample waypoint1)
        (at_soil_sample waypoint2)

        (on_board camera0 rover0)
        (on_board camera1 rover1)

        (supports camera0 colour)
        (supports camera0 high_res)
        (supports camera1 high_res)

        (calibration_target camera0 objective0)
        (calibration_target camera1 objective1)

        (visible_from objective0 waypoint1)
        (visible_from objective0 waypoint3)
        (visible_from objective1 waypoint2)
        (visible_from objective1 waypoint4) ;damos visibilidad al waypoint4

        (visible waypoint0 waypoint1)
        (visible waypoint1 waypoint0)
        (visible waypoint1 waypoint2)
        (visible waypoint2 waypoint1)
        (visible waypoint2 waypoint3)
        (visible waypoint3 waypoint2)
        (visible waypoint3 waypoint4) ;annadimos info del waypoint4
        (visible waypoint4 waypoint3) ;annadimos info del waypoint4

        (visible waypoint0 waypoint3)
        (visible waypoint3 waypoint0)

        ;annadimos tambien el waypoint4
        (can_traverse rover0 waypoint0 waypoint1)
        (can_traverse rover0 waypoint1 waypoint0)
        (can_traverse rover0 waypoint1 waypoint2)
        (can_traverse rover0 waypoint2 waypoint1)
        (can_traverse rover0 waypoint2 waypoint3)
        (can_traverse rover0 waypoint3 waypoint2)
        (can_traverse rover0 waypoint3 waypoint0)
        (can_traverse rover0 waypoint0 waypoint3)
        (can_traverse rover0 waypoint4 waypoint3)
        (can_traverse rover0 waypoint3 waypoint4)

        (can_traverse rover1 waypoint0 waypoint1)
        (can_traverse rover1 waypoint1 waypoint0)
        (can_traverse rover1 waypoint1 waypoint2)
        (can_traverse rover1 waypoint2 waypoint1)
        (can_traverse rover1 waypoint2 waypoint3)
        (can_traverse rover1 waypoint3 waypoint2)
        (can_traverse rover1 waypoint3 waypoint0)
        (can_traverse rover1 waypoint0 waypoint3)
        (can_traverse rover1 waypoint4 waypoint3)
        (can_traverse rover1 waypoint3 waypoint4)

        (battery_4 rover0) ;inicializamos la bateria al maximo
        (battery_4 rover1) ;idem para rover1
    )
    (:goal
        (and
            (communicated_rock_data waypoint1)
            (communicated_soil_data waypoint2)
            (communicated_image_data objective0 colour)
            (communicated_image_data objective1 high_res) ;annadimos una restriccion mas para que haya interaccion con las baterias
        )
    )
)