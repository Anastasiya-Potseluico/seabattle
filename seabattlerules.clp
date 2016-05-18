(reset)
;
; ������� ������
;

; ������, ����������� ���������� ������.
(deftemplate empty
    (slot x)
    (slot y)
)

; ������, ����������� ���������.
(deftemplate hit
    (slot x)
    (slot y)
)

; ������, ����������� ������.
(deftemplate miss
    (slot x)
    (slot y)
)

; ������, ����������� ��������� �������.
(deftemplate ship
    (slot x)
    (slot y)
)

; ������, ����������� ��������� �������.
(deftemplate hitted
    (slot x)
    (slot y)
)

;
; ������� ��������� �� �����
;
; ������� ��� ���� ������
;


; ������� �����: ���� ��� ��������� �� ��������� � ����� �� ����, ������� ���� �����.
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

; ������� �����: ���� ��� ��������� �� ��������� � ����� �� ����, ������� ���� ������.
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
; ������� �����: ���� ��� ��������� �� ����������� � ������ �� ����, ������� ���� ������.
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

; ������� �����: ���� ��� ��������� �� ����������� � ����� �� ����, ������� ���� �����.
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
; ������� ��� ����� ������
;

; ������� �����: ���� ���� ��������� �� ��������� � ����� �� ����, ������� ���� �����.
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

; ������� �����: ���� ���� ��������� �� ��������� � ����� �� ����, ������� ���� ������.
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
; ������� �����: ���� ���� ��������� �� ����������� � ������ �� ����, ������� ���� ������.
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

; ������� �����: ���� ���� ��������� �� ����������� � ����� �� ����, ������� ���� �����.
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
; ������� �����: ���� ��� ���������.
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
; ���� ������� ������� ������ �������.
;
; ������� ����������� ������� - �����.
(defrule shipleft
    ?ship <- (ship (x ?ex) (y ?y))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?ex (+ ?x 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)

; ������� ����������� ������� - �����.
(defrule shipright
    ?ship <- (ship (x ?ex) (y ?y))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?x (+ ?ex 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)
; ������� ����������� ������� - �����.
(defrule shipup
    ?ship <- (ship (x ?x) (y ?ey))
    ?hit  <- (hit (x ?x) (y ?y))
    (test  (= ?ey (+ ?y 1)))
    =>
    (retract ?hit)
    (assert (ship (x ?x) (y ?y)))
    (facts)
)

; ������� ����������� ������� - ����.
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
; ���� ������� ������� ��� ������ ������ ������� ���������.
;
; ���� �������: ������� ������ ������ ��������� �����.
(defrule shipleft
    (ship (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?x1 (+ ?ex 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?ex) (y ?y)))
    (facts)
)
; ���� �������: ������� ������ ������ ��������� ������.
(defrule shipright
    (ship (x ?x1) (y ?y))
    ?empty <- (empty (x ?ex) (y ?y))
    (test (= ?ex (+ ?x1 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?ex) (y ?y)))
    (facts)
)
; ���� �������: ������� ������ ������ ��������� �����.
(defrule shipdown
    (ship (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?ey (+ ?y 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x) (y ?ey)))
    (facts)
)
; ���� �������: ������� ������ ������ ��������� ������.
(defrule shipup
    (ship (x ?x) (y ?y))
    ?empty <- (empty (x ?x) (y ?ey))
    (test (= ?y (+ ?ey 1)))
    =>
    (retract ?empty)
    (assert (miss (x ?x) (y ?ey)))
    (facts)
)
; ���� �������: ������� ������ ������ ��������� �����-������.
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
; ���� �������: ������� ������ ������ ��������� ������-������.
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
; ���� �������: ������� ������ ������ ��������� �����-�����.
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
; ���� �������: ������� ������ ������ ��������� ������-�����.
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

; ��������� ����������� ��������� � ��������� ����� �� ���� 1x3.
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
