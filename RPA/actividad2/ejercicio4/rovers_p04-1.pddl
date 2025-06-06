(define (problem roverprob_battery)
    (:domain Rover2)

    (:objects
        general - Lander
        colour high_res low_res - Mode
        rover0 rover1 - Rover
        rover0store rover1store - Store
        waypoint0 waypoint1 waypoint2 waypoint3 - Waypoint
        camera0 camera1 - Camera
        objective0 objective1 - Objective
    )

    (:init
        (visible waypoint1 waypoint0)
        (visible waypoint0 waypoint1)
        (visible waypoint2 waypoint0)
        (visible waypoint0 waypoint2)
        (visible waypoint2 waypoint1)
        (visible waypoint1 waypoint2)
        (visible waypoint3 waypoint0)
        (visible waypoint0 waypoint3)
        (visible waypoint3 waypoint1)
        (visible waypoint1 waypoint3)
        (visible waypoint3 waypoint2)
        (visible waypoint2 waypoint3)

        (at_soil_sample waypoint0)
        (at_rock_sample waypoint1)
        (at_soil_sample waypoint2)
        (at_rock_sample waypoint2)
        (at_soil_sample waypoint3)
        (at_rock_sample waypoint3)

        (at_lander general waypoint0)
        (channel_free general)
        (at rover0 waypoint3)
        (at rover1 waypoint1)
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

        (can_traverse rover0 waypoint3 waypoint0)
        (can_traverse rover0 waypoint0 waypoint3)
        (can_traverse rover0 waypoint3 waypoint1)
        (can_traverse rover0 waypoint1 waypoint3)
        (can_traverse rover0 waypoint1 waypoint2)
        (can_traverse rover0 waypoint2 waypoint1)
        (can_traverse rover1 waypoint1 waypoint0)
        (can_traverse rover1 waypoint0 waypoint1)

        (on_board camera0 rover0)
        (on_board camera1 rover1)
        (calibration_target camera0 objective1)
        (calibration_target camera1 objective0)
        (supports camera0 colour)
        (supports camera0 high_res)
        (supports camera1 colour)
        (supports camera1 high_res)

        (battery_full rover0)
        (battery_full rover1)

        (visible_from objective0 waypoint0)
        (visible_from objective0 waypoint1)
        (visible_from objective1 waypoint2)
    )

    (:goal
        (and
            (communicated_soil_data waypoint2)
            (communicated_rock_data waypoint3)
            (communicated_image_data objective1 high_res)
        )
    )
)