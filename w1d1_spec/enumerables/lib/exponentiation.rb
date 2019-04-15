def exp(b, n)
    return 1 if n == 0
    b * exp(b, n - 1)
end


def exp_2(b, n)
    return 1 if n == 0
    if n.even?
        b * exp_2(b, n / 2)
    else
        b * exp_2(b, b * (n / 2))
    end
end