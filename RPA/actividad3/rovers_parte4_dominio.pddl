(define (domain Rover4)
       (:requirements :typing :strips :disjunctive-preconditions :conditional-effects)
       (:types
              rover waypoint store camera mode lander objective battery ; se incorpora la bateria
              )

       (:predicates
              (at ?x - rover ?y - waypoint)
              (at_lander ?x - lander ?y - waypoint)
              (can_traverse ?r - rover ?x - waypoint ?y - waypoint)
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
              (visible ?w - waypoint ?p - waypoint)
              (have_image ?r - rover ?o - objective ?m - mode)
              (communicated_soil_data ?w - waypoint)
              (communicated_rock_data ?w - waypoint)
              (communicated_image_data ?o - objective ?m - mode)
              (at_soil_sample ?w - waypoint)
              (at_rock_sample ?w - waypoint)
              (visible_from ?o - objective ?w - waypoint)
              (store_of ?s - store ?r - rover)
              (calibration_target ?i - camera ?o - objective)
              (on_board ?i - camera ?r - rover)
              (on_board_battery ?b - battery ?r - rover) ; se equipa la bateria
              (channel_free ?l - lander)
              (battery_level_full ?b - battery); estos son los niveles de bateria
              (battery_level_high ?b - battery)
              (battery_level_medium ?b - battery)
              (battery_level_low ?b - battery)
              (battery_level_very_low ?b - battery)
              (battery_level_critical ?b - battery)
              (battery_level_very_critical ?b - battery)
              (battery_level_empty ?b - battery)

       )

       (:action navigate
              :parameters (?x - rover ?y - waypoint ?z - waypoint ?b - battery)
              :precondition (and (can_traverse ?x ?y ?z) (available ?x) (at ?x ?y) (on_board_battery ?b ?x)
                     (visible ?y ?z) (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b)
                            (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b)
                            (battery_level_very_critical ?b)) ; se incorpora la condicion de que tenga al menos 1 nivel de baterua
              )
              :effect (and (not (at ?x ?y)) (at ?x ?z)
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b))) ; Se resta 1 de bateria
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action sample_soil
              :parameters (?x - rover ?s - store ?p - waypoint ?b - battery)
              :precondition (and (at ?x ?p) (on_board_battery ?b ?x) (at_soil_sample ?p) (equipped_for_soil_analysis ?x) (store_of ?s ?x) (empty ?s) (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (not (empty ?s)) (full ?s) (have_soil_analysis ?x ?p) (not (at_soil_sample ?p))
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action sample_rock
              :parameters (?x - rover ?s - store ?p - waypoint ?b - battery)
              :precondition (and (at ?x ?p) (on_board_battery ?b ?x) (at_rock_sample ?p) (equipped_for_rock_analysis ?x) (store_of ?s ?x)(empty ?s) (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (not (empty ?s)) (full ?s) (have_rock_analysis ?x ?p) (not (at_rock_sample ?p))
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action drop
              :parameters (?r - rover ?y - store ?b - battery)
              :precondition (and (store_of ?y ?r) (on_board_battery ?b ?r) (full ?y) (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (not (full ?y)) (empty ?y)
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action calibrate
              :parameters (?r - rover ?i - camera ?t - objective ?w - waypoint ?b - battery)
              :precondition (and (equipped_for_imaging ?r) (on_board_battery ?b ?r) (calibration_target ?i ?t) (at ?r ?w) (visible_from ?t ?w)(on_board ?i ?r) (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (calibrated ?i ?r)
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action take_image
              :parameters (?r - rover ?p - waypoint ?o - objective ?i - camera ?m - mode ?b - battery)
              :precondition (and (calibrated ?i ?r)
                     (on_board ?i ?r)(on_board_battery ?b ?r)
                     (equipped_for_imaging ?r)
                     (supports ?i ?m)
                     (visible_from ?o ?p)
                     (at ?r ?p)
                     (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (have_image ?r ?o ?m)
                     (not (calibrated ?i ?r))
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action communicate_soil_data
              :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint ?b - battery)
              :precondition (and (at ?r ?x)(on_board_battery ?b ?r)
                     (at_lander ?l ?y)(have_soil_analysis ?r ?p)
                     (visible ?x ?y)(available ?r)(channel_free ?l)
                     (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (not (available ?r))
                     (not (channel_free ?l))(channel_free ?l)
                     (communicated_soil_data ?p)(available ?r)
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action communicate_rock_data
              :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint ?b - battery)
              :precondition (and (at ?r ?x)(on_board_battery ?b ?r)
                     (at_lander ?l ?y)(have_rock_analysis ?r ?p)
                     (visible ?x ?y)(available ?r)(channel_free ?l)
                     (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (not (available ?r))
                     (not (channel_free ?l))(channel_free ?l)(communicated_rock_data ?p)(available ?r)
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action communicate_image_data
              :parameters (?r - rover ?l - lander ?o - objective ?m - mode ?x - waypoint ?y - waypoint ?b - battery)
              :precondition (and (at ?r ?x)(on_board_battery ?b ?r)
                     (at_lander ?l ?y)(have_image ?r ?o ?m)(visible ?x ?y)(available ?r)(channel_free ?l)
                     (or (battery_level_full ?b) (battery_level_high ?b) (battery_level_medium ?b) (battery_level_low ?b) (battery_level_critical ?b) (battery_level_very_low ?b) (battery_level_very_critical ?b))
              )
              :effect (and (not (available ?r))
                     (not (channel_free ?l))(channel_free ?l)(communicated_image_data ?o ?m)(available ?r)
                     (when
                            (battery_level_full ?b)
                            (and (not (battery_level_full ?b)) (battery_level_high ?b)))
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_medium ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_low ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_very_low ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_critical ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_empty ?b)))
              )
       )

       (:action charge ; Se incorpora la accion de carga de bateria
              :parameters (?r - rover ?l - lander ?x - waypoint ?b - battery)
              :precondition (and (at ?r ?x)
                     (at_lander ?l ?x)(available ?r)(on_board_battery ?b ?r)
              )
              :effect (and (not (available ?r))(available ?r)
                     (when
                            (battery_level_high ?b)
                            (and (not (battery_level_high ?b)) (battery_level_full ?b)))
                     (when
                            (battery_level_medium ?b)
                            (and (not (battery_level_medium ?b)) (battery_level_full ?b)))
                     (when
                            (battery_level_low ?b)
                            (and (not (battery_level_low ?b)) (battery_level_full ?b)))
                     (when
                            (battery_level_very_low ?b)
                            (and (not (battery_level_very_low ?b)) (battery_level_full ?b)))
                     (when
                            (battery_level_critical ?b)
                            (and (not (battery_level_critical ?b)) (battery_level_full ?b)))
                     (when
                            (battery_level_very_critical ?b)
                            (and (not (battery_level_very_critical ?b)) (battery_level_full ?b)))
                     (when
                            (battery_level_empty ?b)
                            (and (not (battery_level_empty ?b)) (battery_level_full ?b)))
              )
       )

)