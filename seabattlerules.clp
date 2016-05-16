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

; Шаблон, описывающий промах.
(deftemplate ship
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

; Правило удара: если два попадания по вертикали и снизу не били, сделать удар сверху.
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
; Правило удара: если два попадания по горизонтали и справа не били, сделать удар справа.
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

; Правило удара: если два попадания по горизонтали и слева не били, сделать удар слева.
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
; Правила для одной клетки
;

; Правило удара: если одно попадание по вертикали и снизу не били, сделать удар снизу.
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

; Правило удара: если одно попадание по вертикали и снизу не били, сделать удар сверху.
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
; Правило удара: если одно попадание по горизонтали и справа не били, сделать удар справа.
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

; Правило удара: если одно попадание по горизонтали и слева не били, сделать удар слева.
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
; Правило удара: если нет попаданий.
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
;
; Определим что корабль уничтожен
;
; Убит 4х палубиник вертикально расположенный: сделать его утонувшим.
; две клетки пустые
(defrule ship4vertical
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty1 <- (empty (x ?x) (y ?y0))
    ?empty2 <- (empty (x ?x) (y ?y5))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y5 (+ ?y4 1)))
    =>
    (retract ?hit1)
    (assert
        (ship
            (x ?x)
            (y ?y1)
        )
    )
    (retract ?hit2)
    (assert
        (ship
            (x ?x)
            (y ?y2)
        )
    )
    (retract ?hit3)
    (assert
        (ship
            (x ?x)
            (y ?y3)
        )
    )
    (retract ?hit4)
    (assert
        (ship
            (x ?x)
            (y ?y4)
        )
    )
    (facts)
)

; Убит 4х палубиник вертикально расположенный: сделать его утонувшим.
; две клетки промахи
(defrule ship4vertical
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty1 <- (miss (x ?x) (y ?y0))
    ?empty2 <- (miss (x ?x) (y ?y5))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y5 (+ ?y4 1)))
    =>
    (retract ?hit1)
    (assert
        (ship
            (x ?x)
            (y ?y1)
        )
    )
    (retract ?hit2)
    (assert
        (ship
            (x ?x)
            (y ?y2)
        )
    )
    (retract ?hit3)
    (assert
        (ship
            (x ?x)
            (y ?y3)
        )
    )
    (retract ?hit4)
    (assert
        (ship
            (x ?x)
            (y ?y4)
        )
    )
    (facts)
)
; Убит 4х палубиник вертикально расположенный: сделать его утонувшим.
; пустая клетка и промах
(defrule ship4vertical
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty1 <- (empty (x ?x) (y ?y0))
    ?empty2 <- (miss (x ?x) (y ?y5))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y5 (+ ?y4 1)))
    =>
    (retract ?hit1)
    (assert
        (ship
            (x ?x)
            (y ?y1)
        )
    )
    (retract ?hit2)
    (assert
        (ship
            (x ?x)
            (y ?y2)
        )
    )
    (retract ?hit3)
    (assert
        (ship
            (x ?x)
            (y ?y3)
        )
    )
    (retract ?hit4)
    (assert
        (ship
            (x ?x)
            (y ?y4)
        )
    )
    (facts)
)
; Убит 4х палубиник вертикально расположенный: сделать его утонувшим.
; промах и пустая клетка
(defrule ship4vertical
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty1 <- (miss (x ?x) (y ?y0))
    ?empty2 <- (empty (x ?x) (y ?y5))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y5 (+ ?y4 1)))
    =>
    (retract ?hit1)
    (assert
        (ship
            (x ?x)
            (y ?y1)
        )
    )
    (retract ?hit2)
    (assert
        (ship
            (x ?x)
            (y ?y2)
        )
    )
    (retract ?hit3)
    (assert
        (ship
            (x ?x)
            (y ?y3)
        )
    )
    (retract ?hit4)
    (assert
        (ship
            (x ?x)
            (y ?y4)
        )
    )
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
    (assert
        (miss
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)
; Убит корабль: сделать пустые клетки промахами справа.
(defrule shipright
    (ship (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?ex (+ ?x1 1)))
    =>
    (retract ?empty)
    (assert
        (miss
            (x ?ex)
            (y ?y)
        )
    )
    (facts)
)
; Убит корабль: сделать пустые клетки промахами снизу.
(defrule shipdown
    (ship (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?ey (+ ?y 1)))
    =>
    (retract ?empty)
    (assert
        (miss
            (x ?x)
            (y ?ey)
        )
    )
    (facts)
)
; Убит корабль: сделать пустые клетки промахами сверху.
(defrule shipup
    (ship (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y (+ ?ey 1)))
    =>
    (retract ?empty)
    (assert
        (miss
            (x ?x)
            (y ?ey)
        )
    )
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
        (miss
            (x ?x2)
            (y ?y2)
        )
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
    (assert
        (miss
            (x ?x2)
            (y ?y2)
        )
    )
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
    (assert
        (miss
            (x ?x2)
            (y ?y2)
        )
    )
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
    (assert
        (miss
            (x ?x2)
            (y ?y2)
        )
    )
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
