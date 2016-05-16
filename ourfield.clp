(reset)
;
; Шаблоны клеток
;

; Шаблон, описывающий нетронутую ячейку.
(deftemplate empty (slot x) (slot y) )
; Шаблон, описывающий попадание.
(deftemplate hit (slot x) (slot y) )
; Шаблон, описывающий промах.
(deftemplate miss (slot x) (slot y) )
; Шаблон, описывающий корабль.
(deftemplate ship (slot x) (slot y) )
; Шаблон, описывающий утонвший корабль.
(deftemplate drowned (slot x) (slot y) )

; Определим что корабль уничтожен
; Утопим 4 палубник
; ВЕРТИКАЛЬНЫЙ

; две клетки пустые
(defrule ship4vertical2empty
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
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (retract ?hit4)
    (assert (drowned (x ?x) (y ?y4)))
    (facts)
)
; две клетки промахи
(defrule ship4vertical2miss
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
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (retract ?hit4)
    (assert (drowned (x ?x) (y ?y4)))
    (facts)
)
; пустая клетка и промах
(defrule ship4vertical1empty1miss
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
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (retract ?hit4)
    (assert (drowned (x ?x) (y ?y4)))
    (facts)
)
; промах и пустая клетка
(defrule ship4vertical1miss1empty
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
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (retract ?hit4)
    (assert (drowned (x ?x) (y ?y4)))
    (facts)
)
; --------------------------------------------------

; ГОРИЗОНТАЛЬНЫЙ
; две клетки пустые
(defrule ship4horizontal2empty
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?hit4 <- (hit (x4 ?x) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    ?empty2 <- (empty (x ?x5) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x5 (+ ?x4 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (retract ?hit4)
    (assert (drowned (x ?x4) (y ?y)))
    (facts)
)
; две клетки промахи
(defrule ship4horizontal2miss
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?hit4 <- (hit (x4 ?x) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    ?empty2 <- (miss (x ?x5) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x5 (+ ?x4 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (retract ?hit4)
    (assert (drowned (x ?x4) (y ?y)))
    (facts)
)
; пустая клетка и промах
(defrule ship4horizontal1empty1miss
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?hit4 <- (hit (x4 ?x) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    ?empty2 <- (miss (x ?x5) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x5 (+ ?x4 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (retract ?hit4)
    (assert (drowned (x ?x4) (y ?y)))
    (facts)
)
; промах и пустая клетка
(defrule ship4horizontal1miss1empty
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?hit4 <- (hit (x4 ?x) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    ?empty2 <- (empty (x ?x5) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x5 (+ ?x4 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (retract ?hit4)
    (assert (drowned (x ?x4) (y ?y)))
    (facts)
)
; --------------------------------------------------

; Определим что корабль уничтожен
; Утопим 3 палубник
; ВЕРТИКАЛЬНЫЙ

; две клетки пустые
(defrule ship3vertical2empty
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty1 <- (empty (x ?x) (y ?y0))
    ?empty2 <- (empty (x ?x) (y ?y4))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y1)))
    (facts)
)
; две клетки промахи
(defrule ship3vertical2miss
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty1 <- (miss (x ?x) (y ?y0))
    ?empty2 <- (miss (x ?x) (y ?y4))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y1)))
    (facts)
)
; пустая клетка и промах
(defrule ship3vertical1empty1miss
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty1 <- (empty (x ?x) (y ?y0))
    ?empty2 <- (miss (x ?x) (y ?y3))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (facts)
)
; промах и пустая клетка
(defrule ship3vertical1miss1empty
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty1 <- (miss (x ?x) (y ?y0))
    ?empty2 <- (empty (x ?x) (y ?y4))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (facts)
)
; --------------------------------------------------

; ГОРИЗОНТАЛЬНЫЙ
; две клетки пустые
(defrule ship3horizontal2empty
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    ?empty2 <- (empty (x ?x4) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; две клетки промахи
(defrule ship3horizontal2miss
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    ?empty2 <- (miss (x ?x4) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; пустая клетка и промах
(defrule ship3horizontal1empty1miss
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    ?empty2 <- (miss (x ?x4) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; промах и пустая клетка
(defrule ship3horizontal1miss1empty
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?hit3 <- (hit (x3 ?x) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    ?empty2 <- (empty (x ?x4) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; --------------------------------------------------

; Определим что корабль уничтожен
; Утопим 2 палубник
; ВЕРТИКАЛЬНЫЙ

; две клетки пустые
(defrule ship2vertical2empty
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty1 <- (empty (x ?x) (y ?y0))
    ?empty2 <- (empty (x ?x) (y ?y3))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; две клетки промахи
(defrule ship2vertical2miss
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty1 <- (miss (x ?x) (y ?y0))
    ?empty2 <- (miss (x ?x) (y ?y3))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; пустая клетка и промах
(defrule ship2vertical1empty1miss
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty1 <- (empty (x ?x) (y ?y0))
    ?empty2 <- (miss (x ?x) (y ?y3))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; промах и пустая клетка
(defrule ship2vertical1miss1empty
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty1 <- (miss (x ?x) (y ?y0))
    ?empty2 <- (empty (x ?x) (y ?y3))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; --------------------------------------------------

; ГОРИЗОНТАЛЬНЫЙ
; две клетки пустые
(defrule ship2horizontal2empty
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    ?empty2 <- (empty (x ?x3) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; две клетки промахи
(defrule ship2horizontal2miss
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    ?empty2 <- (miss (x ?x3) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; пустая клетка и промах
(defrule ship2horizontal1empty1miss
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    ?empty2 <- (miss (x ?x3) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; промах и пустая клетка
(defrule ship2horizontal1miss1empty
    ?hit1 <- (hit (x1 ?x) (y ?y))
    ?hit2 <- (hit (x2 ?x) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    ?empty2 <- (empty (x ?x3) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; --------------------------------------------------

;
; Убит корабль сделаем все клетки вокруг корабля промахами.
;
; Убит корабль: сделать пустые клетки промахами слева.
(defrule shipleft
    (drowned (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x1 (+ ?ex 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?ex) (y ?y)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами справа.
(defrule shipright
    (drowned (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?ex (+ ?x1 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?ex) (y ?y)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами снизу.
(defrule shipdown
    (drowned (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?ey (+ ?y 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x) (y ?ey)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами сверху.
(defrule shipup
    (drowned (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y (+ ?ey 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x) (y ?ey)))
    (facts)
)
; Убит корабль: сделать пустые клетки промахами слева-сверху.
(defrule shipupleft
    (drowned (x ?x1) (y ?y1))
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
    (drowned (x ?x1) (y ?y1))
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
    (drowned (x ?x1) (y ?y1))
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
    (drowned (x ?x1) (y ?y1))
    ?empty <- (empty (x ?x2) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y1 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x2) (y ?y2)))
    (facts)
)
; --------------------------------------------------
