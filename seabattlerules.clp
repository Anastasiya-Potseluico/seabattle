(reset)
;
; Ўаблоны клеток
;

; Ўаблон, описывающий нетронутую €чейку.
(deftemplate empty
    (slot x)
    (slot y)
)

; Ўаблон, описывающий попадание.
(deftemplate hit
    (slot x)
    (slot y)
)

; Ўаблон, описывающий промах.
(deftemplate miss
    (slot x)
    (slot y)
)

; Ўаблон, описывающий утонувший корабль.
(deftemplate ship
    (slot x)
    (slot y)
)

;
; ѕравила выстрелов во врага
;
; ѕравила дл€ двух клеток
;


; ѕравило удара: если два попадани€ по вертикали и снизу не били, сделать удар снизу.
(defrule newhit2dowm
    (hit (x ?x) (y ?y1))
    (hit (x ?x) (y ?y2))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?ey (+ ?y2 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?x)
            (y ?ey)
        )
    )
    (facts)
)

; ѕравило удара: если два попадани€ по вертикали и снизу не били, сделать удар сверху.
(defrule newhit2up
    (hit (x ?x) (y ?y1))
    (hit (x ?x) (y ?y2))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y1 (+ ?ey 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?x)
            (y ?ey)
        )
    )
    (facts)
)
; ѕравило удара: если два попадани€ по горизонтали и справа не били, сделать удар справа.
(defrule newhit2right
    (hit (x ?x1) (y ?y))
    (hit (x ?x2) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?ex (+ ?x2 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)

; ѕравило удара: если два попадани€ по горизонтали и слева не били, сделать удар слева.
(defrule newhit2left
    (hit (x ?x1) (y ?y))
    (hit (x ?x2) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x1 (+ ?ex 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)
; --------------------------------------------------
;
; ѕравила дл€ одной клетки
;

; ѕравило удара: если одно попадание по вертикали и снизу не били, сделать удар снизу.
(defrule newhit1dowm
    (hit (x ?x) (y ?y1))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?ey (+ ?y1 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?x)
            (y ?ey)
        )
    )
    (facts)
)

; ѕравило удара: если одно попадание по вертикали и снизу не били, сделать удар сверху.
(defrule newhit1up
    (hit (x ?x) (y ?y1))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y1 (+ ?ey 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?x)
            (y ?ey)
        )
    )
    (facts)
)
; ѕравило удара: если одно попадание по горизонтали и справа не били, сделать удар справа.
(defrule newhit1right
    (hit (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?ex (+ ?x1 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)

; ѕравило удара: если одно попадание по горизонтали и слева не били, сделать удар слева.
(defrule newhit1left
    (hit (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x1 (+ ?ex 1)))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)
; ѕравило удара: если нет попаданий.
(defrule newhit1left
    ?empty <- (empty (x ?ex) (y ?y))
    (test hitted)
    =>
    (retract ?empty)
    (assert hitted)
    (assert
        (hit
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)
; --------------------------------------------------
; Ќачальна€ расстановка попаданий и свободных €чеек на поле 1x3.
(assert
    (hit
        (x 1)
        (y 1)
    )
)

(assert
    (hit
        (x 1)
        (y 2)
    )
)

(assert
    (empty
        (x 1)
        (y 3)
    )
)


(facts)
(run)
