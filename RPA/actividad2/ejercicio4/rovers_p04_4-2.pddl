(define (problem roverprob5)
    (:domain Rover5)
    (:objects
        general - Lander
        colour high_res - Mode
        rover0 rover1 - Rover
        rover0store rover1store - Store
        waypoint0 waypoint1 waypoint2 - Waypoint
        camera0 camera1 - Camera
        objective0 - Objective
    )
    (:init
        (at_lander general waypoint0)
        (channel_free general)
        (at rover0 waypoint0)
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
        (at_rock_sample waypoint1)
        (at_soil_sample waypoint2)
        (on_board camera0 rover0)
        (on_board camera1 rover1)
        (supports camera0 colour)
        (supports camera0 high_res)
        (supports camera1 high_res)
        (calibration_target camera0 objective0)
        (calibration_target camera1 objective0)
        (visible_from objective0 waypoint1)
        (visible_from objective0 waypoint2)
        (visible waypoint0 waypoint1)
        (visible waypoint1 waypoint0)
        (visible waypoint0 waypoint2)
        (visible waypoint2 waypoint0)
        (visible waypoint1 waypoint2)
        (visible waypoint2 waypoint1)
        (can_traverse rover0 waypoint0 waypoint1)
        (can_traverse rover0 waypoint1 waypoint0)
        (can_traverse rover0 waypoint1 waypoint2)
        (can_traverse rover0 waypoint2 waypoint1)
        (can_traverse rover1 waypoint1 waypoint0)
        (can_traverse rover1 waypoint0 waypoint1)
        (battery_0 rover0)
        (battery_0 rover1)
    )
    (:goal
        (and
            (communicated_rock_data waypoint1)
            (communicated_soil_data waypoint2)
            (communicated_image_data objective0 high_res)

        )
    )
)