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

; ������� �����: ���� ��� ��������� �� ��������� � ����� �� ����, ������� ���� ������.
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
; ������� �����: ���� ��� ��������� �� ����������� � ������ �� ����, ������� ���� ������.
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

; ������� �����: ���� ��� ��������� �� ����������� � ����� �� ����, ������� ���� �����.
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
; ������� ��� ����� ������
;

; ������� �����: ���� ���� ��������� �� ��������� � ����� �� ����, ������� ���� �����.
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

; ������� �����: ���� ���� ��������� �� ��������� � ����� �� ����, ������� ���� ������.
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
; ������� �����: ���� ���� ��������� �� ����������� � ������ �� ����, ������� ���� ������.
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

; ������� �����: ���� ���� ��������� �� ����������� � ����� �� ����, ������� ���� �����.
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
; ������� �����: ���� ��� ���������.
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
