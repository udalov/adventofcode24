// scala 19b.scala

import scala.io.Source
import scala.collection.mutable.ArrayBuffer

object Solution {
    def check(a: Array[String], s: String) = {
        val n = s.length
        val f = Array.fill(n + 1) { 0L }
        f(0) = 1L
        for (i <- 1 to n) {
            for (t <- a) {
                if (t.length <= i && s.substring(i - t.length, i).equals(t)) {
                    f(i) += f(i - t.length)
                }
            }
        }
        f(n)
    }

    def solve(lines: ArrayBuffer[String]) = {
        val a = lines(0).split(", ")
        var ans = 0L
        var i = 2
        while (i < lines.size) {
            ans += check(a, lines(i))
            i += 1
        }
        ans
    }

    def main(args: Array[String]) = {
        println(solve(Source.stdin.getLines.to(ArrayBuffer)))
    }
}
