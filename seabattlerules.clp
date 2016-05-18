(reset)
;
; Шаблоны клеток
;

; Шаблон, описывающий нетронутую ячейку.
(deftemplate empty
    (slot x)
    (slot y)
)

; Шаблон, описывающий попадание.
(deftemplate hit
    (slot x)
    (slot y)
)

; Шаблон, описывающий промах.
(deftemplate miss
    (slot x)
    (slot y)
)

; Шаблон, описывающий утонувший корабль.
(deftemplate ship
    (slot x)
    (slot y)
)

; Шаблон, описывающий утонувший корабль.
(deftemplate hitted
    (slot x)
    (slot y)
)

;
; Правила выстрелов во врага
;
; Правила для двух клеток
;


; Правило удара: если два попадания по вертикали и снизу не били, сделать удар снизу.
(defrule newhit2dowm
    (hit (x ?x) (y ?y1))
    (hit (x ?x) (y ?y2))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?ey (+ ?y2 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?x) (y ?ey)))
    (facts)
)

; Правило удара: если два попадания по вертикали и снизу не били, сделать удар сверху.
(defrule newhit2up
    (hit (x ?x) (y ?y1))
    (hit (x ?x) (y ?y2))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y1 (+ ?ey 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?x) (y ?ey)))
    (facts)
)
; Правило удара: если два попадания по горизонтали и справа не били, сделать удар справа.
(defrule newhit2right
    (hit (x ?x1) (y ?y))
    (hit (x ?x2) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?ex (+ ?x2 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?ex) (y ?y)))
    (facts)
)

; Правило удара: если два попадания по горизонтали и слева не били, сделать удар слева.
(defrule newhit2left
    (hit (x ?x1) (y ?y))
    (hit (x ?x2) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x1 (+ ?ex 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?ex) (y ?y)))
    (facts)
)
; --------------------------------------------------
;
; Правила для одной клетки
;

; Правило удара: если одно попадание по вертикали и снизу не били, сделать удар снизу.
(defrule newhit1dowm
    (hit (x ?x) (y ?y1))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?ey (+ ?y1 1)))
    (nothitted)
    =>
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?x) (y ?ey)))
    (facts)
)

; Правило удара: если одно попадание по вертикали и снизу не били, сделать удар сверху.
(defrule newhit1up
    (hit (x ?x) (y ?y1))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y1 (+ ?ey 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?x) (y ?ey)))
    (facts)
)
; Правило удара: если одно попадание по горизонтали и справа не били, сделать удар справа.
(defrule newhit1right
    (hit (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?ex (+ ?x1 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?ex) (y ?y)))
    (facts)
)

; Правило удара: если одно попадание по горизонтали и слева не били, сделать удар слева.
(defrule newhit1left
    (hit (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x1 (+ ?ex 1)))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?ex) (y ?y)))
    (facts)
)
; Правило удара: если нет попаданий.
(defrule newhit1left
    ?empty <- (empty (x ?ex) (y ?y))
    ?nothitted <- (nothitted)
    =>
    (retract ?nothitted)
    (retract ?empty)
    (assert (hitted (x ?x) (y ?ey)))
    (assert (hit (x ?ex) (y ?y)))
    (facts)
)
; --------------------------------------------------

;
; Убит корабль пометим клетки корабля.
;
; Правило уничтожения корабля - влево.
(defrule shipleft
    ?ship <- (ship (x ?ex) (y ?y))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?ex (+ ?x 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)

; Правило уничтожения корабля - право.
(defrule shipright
    ?ship <- (ship (x ?ex) (y ?y))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?x (+ ?ex 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)
; Правило уничтожения корабля - вверх.
(defrule shipup
    ?ship <- (ship (x ?x) (y ?ey))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?ey (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)

; Правило уничтожения корабля - вниз.
(defrule shipdown
    ?ship <- (ship (x ?x) (y ?ey))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?y (+ ?ey 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)

; --------------------------------------------------
;
; Убит корабль сделаем все клетки вокруг корабля промахами.
;
; Убит корабль: сделать пустые клетки промахами слева.
(defrule shipleft
    (ship (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x1 (+ ?ex 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?ex) (y ?y)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами справа.
(defrule shipright
    (ship (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?ex (+ ?x1 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?ex) (y ?y)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами снизу.
(defrule shipdown
    (ship (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?ey (+ ?y 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x) (y ?ey)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами сверху.
(defrule shipup
    (ship (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y (+ ?ey 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x) (y ?ey)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами слева-сверху.
(defrule shipupleft
    (ship (x ?x1) (y ?y1))
    ?empty <- (empty (x ?x2) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y1 (+ ?y2 1)))
    =>
    (retract ?empty)
    (assert
        (miss (x ?x2) (y ?y2))
    )
    (facts)
)
; Убит корабль: сделать пустые клетки промахами справа-сверху.
(defrule shipupright
    (ship (x ?x1) (y ?y1))
    ?empty <- (empty (x ?x2) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y2 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x2) (y ?y2)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами слева-снизу.
(defrule shipupleft
    (ship (x ?x1) (y ?y1))
    ?empty <- (empty (x ?x2) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y1 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x2) (y ?y2)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами справа-снизу.
(defrule shipupleft
    (ship (x ?x1) (y ?y1))
    ?empty <- (empty (x ?x2) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y1 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x2) (y ?y2)))
    (facts)
)
; --------------------------------------------------

; Начальная расстановка попаданий и свободных ячеек на поле 1x3.
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
