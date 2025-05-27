(define (domain Rover6)
    (:requirements :typing :strips :disjunctive-preconditions :conditional-effects)
    (:types
        rover waypoint store camera mode lander objective
    )
    (:predicates
        (at ?r - rover ?w - waypoint)
        (at_lander ?l - lander ?w - waypoint)
        (can_traverse ?r - rover ?w1 - waypoint ?w2 - waypoint)
        (equipped_for_soil_analysis ?r - rover)
        (equipped_for_rock_analysis ?r - rover)
        (equipped_for_imaging ?r - rover)
        (empty ?s - store)
        (have_rock_analysis ?r - rover ?w - waypoint)
        (have_soil_analysis ?r - rover ?w - waypoint)
        (full ?s - store)
        (calibrated ?c - camera ?r - rover)
        (supports ?c - camera ?m - mode)
        (available ?r - rover)
        (visible ?w1 - waypoint ?w2 - waypoint)
        (have_image ?r - rover ?o - objective ?m - mode)
        (communicated_soil_data ?w - waypoint)
        (communicated_rock_data ?w - waypoint)
        (communicated_image_data ?o - objective ?m - mode)
        (at_soil_sample ?w - waypoint)
        (at_rock_sample ?w - waypoint)
        (visible_from ?o - objective ?w - waypoint)
        (store_of ?s - store ?r - rover)
        (calibration_target ?c - camera ?o - objective)
        (on_board ?c - camera ?r - rover)
        (channel_free ?l - lander)
        (battery_0 ?r - rover)
        (battery_1 ?r - rover)
        (battery_2 ?r - rover)
        (battery_3 ?r - rover)
        (battery_4 ?r - rover)
    )

    (:action navigate
        :parameters (?r - rover ?f - waypoint ?t - waypoint)
        :precondition (and
            (at ?r ?f)
            (can_traverse ?r ?f ?t)
            (visible ?f ?t)
            (available ?r)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (not (at ?r ?f))
            (at ?r ?t)

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )
    (:action recharge
        :parameters (?r - rover ?l - lander ?w - waypoint)
        :precondition (and
            (at ?r ?w)
            (at_lander ?l ?w)
            (or (battery_0 ?r) (battery_1 ?r) (battery_2 ?r) (battery_3 ?r))
        )
        :effect (and
            (when
                (battery_0 ?r)
                (and (not (battery_0 ?r)) (battery_4 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_4 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_4 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_4 ?r)))
        )
    )
    (:action sample_soil
        :parameters (?r - rover ?s - store ?w - waypoint)
        :precondition (and
            (at ?r ?w)
            (at_soil_sample ?w)
            (equipped_for_soil_analysis ?r)
            (store_of ?s ?r)
            (empty ?s)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (not (empty ?s))
            (full ?s)
            (have_soil_analysis ?r ?w)
            (not (at_soil_sample ?w))

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )

    (:action sample_rock
        :parameters (?r - rover ?s - store ?w - waypoint)
        :precondition (and
            (at ?r ?w)
            (at_rock_sample ?w)
            (equipped_for_rock_analysis ?r)
            (store_of ?s ?r)
            (empty ?s)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (not (empty ?s))
            (full ?s)
            (have_rock_analysis ?r ?w)
            (not (at_rock_sample ?w))

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )
    (:action drop
        :parameters (?r - rover ?s - store)
        :precondition (and
            (store_of ?s ?r)
            (full ?s)
        )
        :effect (and
            (not (full ?s))
            (empty ?s)
        )
    )

    (:action calibrate
        :parameters (?r - rover ?c - camera ?o - objective ?w - waypoint)
        :precondition (and
            (at ?r ?w)
            (equipped_for_imaging ?r)
            (on_board ?c ?r)
            (calibration_target ?c ?o)
            (visible_from ?o ?w)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (calibrated ?c ?r)

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )
    (:action take_image
        :parameters (?r - rover ?w - waypoint ?o - objective ?c - camera ?m - mode)
        :precondition (and
            (at ?r ?w)
            (calibrated ?c ?r)
            (on_board ?c ?r)
            (equipped_for_imaging ?r)
            (supports ?c ?m)
            (visible_from ?o ?w)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (have_image ?r ?o ?m)
            (not (calibrated ?c ?r))

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )

    (:action communicate_soil_data
        :parameters (?r - rover ?l - lander ?p - waypoint ?rw - waypoint ?lw - waypoint)
        :precondition (and
            (at ?r ?rw)
            (have_soil_analysis ?r ?p)
            (at_lander ?l ?lw)
            (visible ?rw ?lw)
            (available ?r)
            (channel_free ?l)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (communicated_soil_data ?p)
            (not (channel_free ?l))
            (channel_free ?l)

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )

    (:action communicate_rock_data
        :parameters (?r - rover ?l - lander ?p - waypoint ?rw - waypoint ?lw - waypoint)
        :precondition (and
            (at ?r ?rw)
            (have_rock_analysis ?r ?p)
            (at_lander ?l ?lw)
            (visible ?rw ?lw)
            (available ?r)
            (channel_free ?l)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (communicated_rock_data ?p)
            (not (channel_free ?l))
            (channel_free ?l)

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )

    (:action communicate_image_data
        :parameters (?r - rover ?l - lander ?o - objective ?m - mode ?rw - waypoint ?lw - waypoint)
        :precondition (and
            (at ?r ?rw)
            (have_image ?r ?o ?m)
            (at_lander ?l ?lw)
            (visible ?rw ?lw)
            (available ?r)
            (channel_free ?l)
            (or (battery_4 ?r) (battery_3 ?r) (battery_2 ?r) (battery_1 ?r))
        )
        :effect (and
            (communicated_image_data ?o ?m)
            (not (channel_free ?l))
            (channel_free ?l)

            (when
                (battery_4 ?r)
                (and (not (battery_4 ?r)) (battery_3 ?r)))
            (when
                (battery_3 ?r)
                (and (not (battery_3 ?r)) (battery_2 ?r)))
            (when
                (battery_2 ?r)
                (and (not (battery_2 ?r)) (battery_1 ?r)))
            (when
                (battery_1 ?r)
                (and (not (battery_1 ?r)) (battery_0 ?r)))
        )
    )
)