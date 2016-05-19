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
; Шаблон, описывающий утонувший корабль.
(deftemplate drowned (slot x) (slot y) )
; Шаблон, описывающий выстрел.
(deftemplate hitted (slot x) (slot y) )

(deftemplate nothitted (slot x))

(deftemplate drownedship (slot k))

(deftemplate notgameover)

(deftemplate gameover)

; Правила описывающее выстрел по нам
; Промах
(defrule hittedempty
    ?hitted <- (hitted (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?y))
    =>
    (retract ?empty)
    (retract ?hitted)
    (assert (miss (x ?x) (y ?y)))
    (facts)
)
; Попадание
(defrule hittedship
    ?hitted <- (hitted (x ?x) (y ?y))
    ?ship <- (ship (x ?x) (y ?y))
    =>
    (retract ?ship)
    (retract ?hitted)
    (assert (hit (x ?x) (y ?y)))
    (facts)
)

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
; пустая клетка и стена сверху
(defrule ship4vertical1emptytopwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty2 <- (empty (x ?x) (y ?y5))
    (test (= ?y1 0))
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
; промах и стена сверху
(defrule ship4vertical1misstopwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty2 <- (miss (x ?x) (y ?y5))
    (test (= ?y1 0))
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
; пустая клетка и стена снизу
(defrule ship4vertical1emptydownwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty1 <- (empty (x ?x) (y ?y0))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y4 9))
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
; промах и стена снизу
(defrule ship4vertical1missdownwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?hit4 <- (hit (x ?x) (y ?y4))
    ?empty1 <- (empty (x ?x) (y ?y0))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y4 9))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
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
; промах и стена слева
(defrule ship4horizontal1missleftwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
    ?empty2 <- (miss (x ?x5) (y ?y))
    (test (= ?x1 0))
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
; пустая клетка и стена слева
(defrule ship4horizontal1emptyleftwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
    ?empty2 <- (empty (x ?x5) (y ?y))
    (test (= ?x1 0))
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
; промах и стена справа
(defrule ship4horizontal1missrightwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x4 9))
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
; пустая клетка и стена справа
(defrule ship4horizontal1emptyrightwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?hit4 <- (hit (x ?x4) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x4 9))
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
; пустая клетка и стена сверху
(defrule ship3vertical1emptytopwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty2 <- (empty (x ?x) (y ?y4))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (facts)
)
; промах и стена сверху
(defrule ship3vertical1misstopwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty2 <- (miss (x ?x) (y ?y4))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y4 (+ ?y3 1)))
    (test (= ?y1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (facts)
)
; пустая клетка и стена снизу
(defrule ship3vertical1emptydownwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty1 <- (empty (x ?x) (y ?y0))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y3 9))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (retract ?hit3)
    (assert (drowned (x ?x) (y ?y3)))
    (facts)
)
; промах и стена снизу
(defrule ship3vertical1missdownwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?hit3 <- (hit (x ?x) (y ?y3))
    ?empty1 <- (miss (x ?x) (y ?y0))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y3 9))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
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
; промах и стена слева
(defrule ship3horizontal1missleftwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?empty1 <- (miss (x ?x4) (y ?y))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; пустая клетка и стена слева
(defrule ship3horizontal1emptyleftwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?empty1 <- (empty (x ?x4) (y ?y))
    (test (= ?x4 (+ ?x3 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; промах и стена справа
(defrule ship3horizontal1missrightwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?empty1 <- (miss (x ?x0) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x3 9))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (retract ?hit3)
    (assert (drowned (x ?x3) (y ?y)))
    (facts)
)
; пустая клетка и стена справа
(defrule ship3horizontal1emptyrightwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?hit3 <- (hit (x ?x3) (y ?y))
    ?empty1 <- (empty (x ?x0) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x3 9))
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
; пустая клетка и стена сверху
(defrule ship2vertical1emptytopwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty2 <- (empty (x ?x) (y ?y3))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; промах и стена сверху
(defrule ship2vertical1misstopwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty2 <- (miss (x ?x) (y ?y3))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y3 (+ ?y2 1)))
    (test (= ?y1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; пустая клетка и стена снизу
(defrule ship2vertical1emptydownwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty2 <- (empty (x ?x) (y ?y0))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 9))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x) (y ?y1)))
    (retract ?hit2)
    (assert (drowned (x ?x) (y ?y2)))
    (facts)
)
; промах и стена снизу
(defrule ship2vertical1missdownwall
    ?hit1 <- (hit (x ?x) (y ?y1))
    ?hit2 <- (hit (x ?x) (y ?y2))
    ?empty2 <- (miss (x ?x) (y ?y0))
    (test (= ?y2 (+ ?y1 1)))
    (test (= ?y1 (+ ?y0 1)))
    (test (= ?y2 9))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
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
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
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
; промах и стена слева
(defrule ship2horizontal1missleftwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?empty2 <- (miss (x ?x3) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; пустая клетка и стена слева
(defrule ship2horizontal1emptyleftwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?empty2 <- (empty (x ?x3) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x3 (+ ?x2 1)))
    (test (= ?x1 0))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; промах и стена справа
(defrule ship2horizontal1missrightwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?empty2 <- (miss (x ?x0) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 9))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; пустая клетка и стена справа
(defrule ship2horizontal1emptyrightwall
    ?hit1 <- (hit (x ?x1) (y ?y))
    ?hit2 <- (hit (x ?x2) (y ?y))
    ?empty2 <- (empty (x ?x0) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 9))
    =>
    (retract ?hit1)
    (assert (drowned (x ?x1) (y ?y)))
    (retract ?hit2)
    (assert (drowned (x ?x2) (y ?y)))
    (facts)
)
; --------------------------------------------------
;
; Определим что корабль уничтожен
; Утопим 1 палубник

; 4 пустые
(defrule ship14empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)

; 4 промаха
(defrule ship14miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; 3 пустые 1 промах вверх
(defrule ship13empty1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (empty(x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 3 пустые 1 промах вниз
(defrule ship13empty1missdown
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (empty(x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 3 пустые 1 промах влево
(defrule ship13empty1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (empty(x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 3 пустые 1 промах вправо
(defrule ship13empty1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (miss(x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; 2 пустые 2 промаха вертикаль
(defrule ship12empty2missvert
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 2 пустые 2 промаха горизонталь
(defrule ship12empty2misshoris
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (empty(x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 2 пустые 2 промаха верх-лево
(defrule ship12empty2missupleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (empty(x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 2 пустые 2 промаха верх-право
(defrule ship12empty2missupright
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (miss(x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 2 пустые 2 промаха низ-право
(defrule ship12empty2missdownright
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (miss(x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 2 пустые 2 промаха низ-лево
(defrule ship12empty2missdownleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; 1 пустой 3 промаха низ
(defrule ship1empty1missdown
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 1 пустой 3 промаха верх
(defrule ship1empty1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 1 пустой 3 промаха лево
(defrule ship1empty1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; 1 пустой 3 промаха право
(defrule ship1empty1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= ?y2 (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; Углы
; угл вверх-лево 2 пустые
(defrule ship1angletopleft2empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 0 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл вверх-лево 2 промаха
(defrule ship1angletopleft2miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 0 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл вверх-лево 1 пустая 1 промах лево
(defrule ship1angletopleft1empty1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 0 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл вверх-лево 1 пустая 1 промах низ
(defrule ship1angletopleft1empty1missdowm
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 0 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; угл низ-лево 2 пустые
(defrule ship1angledownleft2empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 0 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл низ-лево 2 промаха
(defrule ship1angledownleft2miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 0 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл низ-лево 1 пустая 1 промах право
(defrule ship1angledownleft1empty1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 0 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл низ-лево 1 пустая 1 промах вверх
(defrule ship1angledownleft1empty1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 0 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; угл низ-право 2 пустые
(defrule ship1angledownright2empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 9 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл низ-право 2 промаха
(defrule ship1angledownright2miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 9 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл низ-право 1 пустая 1 промах право
(defrule ship1angledownright1empty1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 9 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл низ-право 1 пустая 1 промах вверх
(defrule ship1angledownright1empty1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y (+ ?y2 1)))
    (test (= 9 ?x1))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; угл верх-право 2 пустые
(defrule ship1angleupright2empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 9 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл верх-право 2 промаха
(defrule ship1angleupright2miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 9 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл верх-право 1 пустая 1 промах лево
(defrule ship1angleupright1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x2) (y ?y))
    (empty (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 9 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; угл верх-право 1 пустая 1 промах верх
(defrule ship1angleupright1empty1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x2) (y ?y))
    (miss (x ?x1) (y ?y2))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= 9 ?x1))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)

; --------------------------------------------------
; стена сверху 3 клетки побокам пустые
(defrule ship1wallup3empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 3 клетки побокам промахи
(defrule ship1wallup3miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 1 клетка побокам промах лево
(defrule ship1wallup1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 1 клетка побокам промах низ
(defrule ship1wallup1missdown
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 1 клетка побокам промах право
(defrule ship1wallup1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 2 клетки побокам промахи право
(defrule ship1wallup1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 2 клетки побокам промахи лево
(defrule ship1wallup1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена сверху 2 клетки побокам промахи верх
(defrule ship1wallup1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y1 (+ ?y 1)))
    (test (= 0 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; стена снизу 3 клетки побокам пустые
(defrule ship1walldown3empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 3 клетки побокам промахи
(defrule ship1walldown3miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 1 клетка побокам промах лево
(defrule ship1walldown1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 1 клетка побокам промах низ
(defrule ship1walldown1missdown
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 1 клетка побокам промах право
(defrule ship1walldown1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 2 клетки побокам промахи право
(defrule ship1walldown1missright
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 2 клетки побокам промахи лево
(defrule ship1walldown1missleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена снизу 2 клетки побокам промахи верх
(defrule ship1walldown1missup
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x0) (y ?y))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x0 1)))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?y))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; стена слева 3 клетки побокам пустые
(defrule ship1wallleft3empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 3 клетки побокам промахи
(defrule ship1wallleft3miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 2 клетки побокам пустые верх
(defrule ship1wallleft2emptytop
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 2 клетки побокам пустые лево
(defrule ship1wallleft2emptyleft
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 2 клетки побокам пустые низ
(defrule ship1wallleft2emptydown
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 1 клетка побокам пустая верх
(defrule ship1wallleft1emptytop
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 1 клетка побокам пустая лево
(defrule ship1wallleft1emptyleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена слева 1 клетка побокам пустая низ
(defrule ship1wallleft1emptydown
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x2 (+ ?x1 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 0 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; --------------------------------------------------
; стена справа 3 клетки побокам пустые
(defrule ship1wallright3empty
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 3 клетки побокам промахи
(defrule ship1wallright3miss
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 2 клетки побокам пустые верх
(defrule ship1wallright2emptytop
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 2 клетки побокам пустые лево
(defrule ship1wallright2emptyleft
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 2 клетки побокам пустые низ
(defrule ship1wallright2emptydown
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 1 клетка побокам пустая верх
(defrule ship1wallright1emptytop
    ?hit <- (hit (x ?x1) (y ?y))
    (empty (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 1 клетка побокам пустая лево
(defrule ship1wallrightmpty1emptyleft
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (miss (x ?x1) (y ?y2))
    (empty (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)
; стена справа 1 клетка побокам пустая низ
(defrule ship1wallrightempty1emptydown
    ?hit <- (hit (x ?x1) (y ?y))
    (miss (x ?x1) (y ?y1))
    (empty (x ?x1) (y ?y2))
    (miss (x ?x2) (y ?y))
    (test (= ?x1 (+ ?x2 1)))
    (test (= ?y2 (+ ?y 1)))
    (test (= ?y (+ ?y1 1)))
    (test (= 9 ?x1))
    =>
    (retract ?hit)
    (assert (drowned (x ?x1) (y ?y)))
    (facts)
)