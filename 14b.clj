; clj -M 14b.clj

(def X 101)
(def Y 103)
(def N (* X Y))

(defn parse [line]
  (def matcher (re-matcher #"p=(.+),(.+) v=(.+),(.+)" line))
  (re-find matcher)
  (vec (drop 1 (map read-string (re-groups matcher)))))

(defn in-the-middle [robot]
  (let [[x y] robot]
    (def hx (quot X 2))
    (def hy (quot Y 2))
    (or (= x hx) (= y hy))))

(defn strength [robots]
  (count (filter in-the-middle robots)))

(defn move-robot [robot]
  (let [[px py vx vy] robot]
    [(mod (+ px vx) X) (mod (+ py vy) Y) vx vy]))

(defn move-robots [robots]
  (map move-robot robots))

(def robots (map parse (take-while some? (repeatedly read-line))))

(def s (iterate move-robots robots))
(def m (reduce max (map strength (take N s))))
(println (first (first (filter (fn [x] (= (second x) m)) (map-indexed (fn [i value] [i (strength value)]) s)))))
