; clj -M 14a.clj

(def X 101)
(def Y 103)
(def N 100)

(defn parse [line]
  (def matcher (re-matcher #"p=(.+),(.+) v=(.+),(.+)" line))
  (re-find matcher)
  (map read-string (re-groups matcher)))

(defn add-result [result q]
  (let [[head & tail] result]
    (if (= q 0)
      (cons (+ head 1) tail)
      (cons head (add-result tail (- q 1))))))

(defn quadrant [x y]
  (def hx (quot X 2))
  (def hy (quot Y 2))
  (if (or (= x hx) (= y hy)) 4
    (+ (if (< x hx) 0 1) (if (< y hy) 0 2))))

(defn solve [px py vx vy]
  (def x (mod (+ px (* vx N)) X))
  (def y (mod (+ py (* vy N)) Y))
  (quadrant x y))

(defn solve-all [result]
  (def line (read-line))
  (if (nil? line) result
    (let [[_ px py vx vy] (parse line)]
      (def cur (solve px py vx vy))
      (solve-all (add-result result cur)))))

(defn main []
  (println (reduce * (drop-last (solve-all '(0 0 0 0 0))))))

(main)
