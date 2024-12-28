// kotlinc 25a.kt

fun main() {
    val keys = mutableListOf<List<Int>>()
    val locks = mutableListOf<List<Int>>()
    do {
        val lock = readLine()!![0] == '#'
        val a = Array(5) { readLine()!! }
        val heights = List(5) { j ->
            var i = 0
            while (i < 5 && (lock && a[i][j] == '#' || !lock && a[4 - i][j] == '#')) i++
            i
        }
        readLine()
        (if (lock) locks else keys).add(heights)
    } while (readLine() != null)

    var ans = 0
    for (key in keys) for (lock in locks) {
        if ((0..<5).all { i -> key[i] + lock[i] <= 5 }) ans++
    }
    println(ans)
}
