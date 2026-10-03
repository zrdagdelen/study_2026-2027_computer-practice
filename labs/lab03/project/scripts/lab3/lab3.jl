#!/usr/bin/env julia

using DrWatson
@quickactivate
using Random

function demo_while()
    n = 0
    while n < 10
        n += 1
        println(n)
    end
end

demo_while()

function demo_for_range()
    for k in 1:2:10
        println(k)
    end
end

demo_for_range()

function demo_for_array()
    myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
    for friend in myfriends
        println("Hi $friend, it's great to see you!")
    end
end

demo_for_array()

function demo_ternary()
    x = 5
    y = 10
    println("(x > y) ? x : y = ", (x > y) ? x : y)
end

demo_ternary()

function demo_functions()
    sayhi(name) = println("Hi $name, it's great to see you!")
    f2(x) = x^2

    sayhi3 = name -> println("Hi $name, it's great to see you!")
    f3 = x -> x^2

    sayhi("C-3PO")
    println("f2(42) = ", f2(42))
    sayhi3("BB-8")
    println("f3(42) = ", f3(42))
end

demo_functions()

function demo_sort()
    v = [3, 5, 2]
    println("Исходный массив: ", v)
    println("sort(v) = ", sort(v))
    println("v после sort(v): ", v)
    sort!(v)
    println("v после sort!(v): ", v)
end

demo_sort()

function demo_map_broadcast()
    f_sq(x) = x^2
    println("map(f_sq, [1,2,3]) = ", map(f_sq, [1, 2, 3]))
    println("map(x -> x^3, [1,2,3]) = ", map(x -> x^3, [1, 2, 3]))
    println("broadcast(f_sq, [1,2,3]) = ", broadcast(f_sq, [1, 2, 3]))
    println("f_sq.([1,2,3]) = ", f_sq.([1, 2, 3]))
end

demo_map_broadcast()

function demo_matrix_gen()
    f(x) = x^2
    A = [i + 3*j for j in 0:2, i in 1:3]
    display(A)
    println("\nf(A) = A*A:")
    display(f(A))
end

demo_matrix_gen()

function task1()
    squares = Dict{Int, Int}()
    i = 1
    while i <= 100
        squares[i] = i^2
        println("$i^2 = $(i^2)")
        i += 1
    end

    squares_arr = [k^2 for k in 1:100]
    println("\nsquares_arr (первые 10): ", squares_arr[1:10], " ...")
end

task1()

function task2()
    function check_parity_if(x)
        if x % 2 == 0
            println("$x — чётное")
        else
            println("$x — нечётное")
        end
    end

    check_parity_if(7)
    check_parity_if(10)

    check_parity_ternary(x) = println("$x — ", x % 2 == 0 ? "чётное" : "нечётное")
    check_parity_ternary(7)
    check_parity_ternary(10)
end

task2()

function task3()
    add_one(x) = x + 1
    println("add_one(41) = ", add_one(41))
end

task3()

function task4()
    add_one(x) = x + 1
    A4x4 = reshape(1:16, 4, 4)
    println("Исходная матрица A4x4:")
    display(A4x4)
    println("\nadd_one.(A4x4) — каждый элемент +1:")
    display(add_one.(A4x4))
end

task4()

function task5()
    A5x5 = [1 1 3; 5 2 6; -2 -1 -3]
    println("Матрица A:")
    display(A5x5)

    println("\nA^3:")
    display(A5x5^3)

    println("\nЗамена 3-го столбца на сумму 2-го и 3-го:")
    B5 = copy(A5x5)
    B5[:, 3] = A5x5[:, 2] + A5x5[:, 3]
    display(B5)
end

task5()

function task6()
    Bm = zeros(Int, 15, 2)
    for i in 1:15
        Bm[i, 1] = 10
        Bm[i, 2] = -10
    end
    println("Матрица B (первые 5 строк):")
    display(Bm[1:5, :])
    println("...")

    C = Bm' * Bm
    println("\nC = Bᵀ·B:")
    display(C)
end

task6()

function task7()
    function make_Z(pattern::Function, n::Int)
        Z = zeros(Int, n, n)
        for i in 1:n
            for j in 1:n
                Z[i, j] = pattern(i, j) ? 1 : 0
            end
        end
        return Z
    end

    Z1 = make_Z((i, j) -> abs(i - j) == 1, 6)
    Z2 = make_Z((i, j) -> (i + j) % 2 == 0 && abs(i - j) <= 2, 6)
    Z3 = make_Z((i, j) -> (i + j) % 2 == 1 && 5 <= i + j <= 10, 6)
    Z4 = make_Z((i, j) -> (i + j) % 2 == 0, 6)

    println("Z1 (единицы на диагоналях):");  display(Z1)
    println("\nZ2 (шахматный, i+j чётное):");  display(Z2)
    println("\nZ3 (симметричная):");            display(Z3)
    println("\nZ4 (шахматный, i+j чётное):");  display(Z4)
end

task7()

function task8()
    """
        outer(x, y, operation)

    Аналог функции outer() языка R.
    Возвращает матрицу C, где C[i, j] = operation(x[i], y[j]).
    """
    function outer(x, y, operation)
        m = length(x)
        n_ = length(y)
        C_ = Matrix{Any}(undef, m, n_)
        for i in 1:m
            for j in 1:n_
                C_[i, j] = operation(x[i], y[j])
            end
        end
        return C_
    end

    println("Проверка outer:")
    display(outer([1, 2, 3], [10, 20, 30], *))
    println()
    display(outer([1, 2, 3], [10, 20, 30], +))

    println("\nA1 = outer(0:4, 0:4, +):")
    display(outer(0:4, 0:4, +))

    println("\nA2 = outer(0:4, 0:4, i^j), 0^0=0:")
    display(outer(0:4, 0:4, (a, b) -> (a == 0 && b == 0) ? 0 : a^b))

    println("\nA3 = outer(0:4, 0:4, (i+j)%5):")
    display(outer(0:4, 0:4, (a, b) -> (a + b) % 5))

    println("\nA4 = outer(0:9, 0:9, (i+j)%10):")
    display(outer(0:9, 0:9, (a, b) -> (a + b) % 10))

    println("\nA5 = outer(0:8, 0:8, (j-i)%9):")
    display(outer(0:8, 0:8, (a, b) -> mod(b - a, 9)))
end

task8()

function task9()
    function build_A(n)
        A_ = zeros(Float64, n, n)
        for i in 1:n
            for j in 1:n
                A_[i, j] = abs(i - j) + 1
            end
        end
        return A_
    end

    y9 = [7.0, -1.0, -3.0, 5.0, 17.0]
    A9 = build_A(5)
    println("Матрица A (5x5):")
    display(A9)
    println("\nВектор y:")
    display(y9)

    x9 = A9 \ y9
    println("\nРешение x = A \\ y:")
    display(x9)
    println("\nПроверка A*x:")
    display(A9 * x9)

    A10 = build_A(10)
    y10 = ones(Float64, 10)
    x10 = A10 \ y10
    println("\nОтклонение A10*x10 - y10 для n=10: ", maximum(abs.(A10 * x10 - y10)))
end

task9()

function task10()
    Random.seed!(1234)
    M = rand(1:10, 6, 10)
    println("Матрица M:")
    display(M)

    N = 4
    counts = [count(>(N), M[i, :]) for i in 1:size(M, 1)]
    println("\nЧисло элементов > $N по строкам:")
    for i in 1:size(M, 1)
        println("Строка $i: ", counts[i])
    end

    Mtarget = 7
    rows_with_two = [i for i in 1:size(M, 1) if count(==(Mtarget), M[i, :]) == 2]
    println("\nСтроки, где $Mtarget встречается ровно 2 раза: ", rows_with_two)

    K = 75
    col_sums = [sum(M[:, j]) for j in 1:size(M, 2)]
    println("\nСуммы по столбцам: ", col_sums)

    pairs = Tuple{Int, Int}[]
    for j1 in 1:size(M, 2)
        for j2 in (j1+1):size(M, 2)
            if col_sums[j1] + col_sums[j2] > K
                push!(pairs, (j1, j2))
            end
        end
    end
    println("Пары столбцов с суммой > $K: ", pairs)
end

task10()

function task11()
    S1 = -sum(i^4 / (3 + j) for i in 1:20, j in 1:5)
    println("S1 = ", S1)

    S2 = -sum(i^4 / (3 + i*j) for i in 1:20, j in 1:5)
    println("S2 = ", S2)
end

task11()
