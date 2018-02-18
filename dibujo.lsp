(defun set_arc (center angi angf r)
  (setq arc (list (cons 0 "arc") (cons 10 center) (cons 50 angi) (cons 51 angf) (cons 40 r)))
  (setq line (list (cons 0 "line") (cons 10 center) (cons 11 (list (+ (nth 0 center) (* r (cos angi))) (+ (nth 1 center) (* r (sin angi))) (nth 2 center)))))

  (entmake arc)
)

(defun inc_ang (angi angf)
  (setq angi angf)
  (setq angf (+ angf (/ pi 4)))
  (if (= angi (* 2 pi))
    (setq angi 0.0)
  )
  (list angi angf)
)

(defun circle1 (center angi angf r)
  (setq ang (/ (+ angi angf) 2.0))
  (setq mid (list (* r (cos ang)) (* r (sin ang)) (nth 2 center)))
  (setq line (list (cons 0 "line") (cons 10 center) (cons 11 mid)))
  
  (entmake line)
  (entmake line)

  (setq ret mid)
)

(defun circle2 (center angi angf r1 r3)
  (setq ang (/ (+ angi angf) 2.0))
  (setq _r2 (/ (+ r1 r3) 2.0))
  (setq mid (list (* _r2 (cos ang)) (* _r2 (sin ang)) (nth 2 center)))
  (setq mid2 (list (* r3 (cos ang)) (* r3 (sin ang)) (nth 2 center)))
  (setq line1 (list (cons 0 "line") (cons 10 center) (cons 11 mid)))
  (setq line2 (list (cons 0 "line") (cons 10 mid) (cons 11 mid2)))

  (entmake line1)
  (entmake line1)
  (entmake line2)
  (entmake line2)

  (setq ret mid2)
)

(setq center (list 0.0 0.0 0.0)) ; CENTRO DEL CALEIDOSCOPIO
(setq angi 0.0)                  ; ANGULO INICIAL DEL ARCO
(setq angf (/ pi 4.0))             ; ANGULO FINAL DEL ARCO
(setq r 100.0)                   ; RADIO DEL CALEIDOSCOPIO
(setq r1 (/ 100.0 3.0))
(setq r2 (* r1 2.0))

(repeat 8
  (set_arc center angi angf r)
  (set_arc center angi angf r2)
  (set_arc center angi angf r1)
  
  (setq circMid1 (circle1 center angi angf r1))
  (setq circMid2 (circle2 circMid1 angi angf r1 r2))
  (circle1 circMid2 angi angf r)
  
  (setq angiAngf (inc_ang angi angf))
  (setq angi (nth 0 angiAngf) angf (nth 1 angiAngf))
)