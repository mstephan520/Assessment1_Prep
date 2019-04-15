def deep_dup(arr)

    return arr if !arr.is_a?(Array)

    duped = []

    arr.each do |ele|
        if !ele.is_a?(Array)
            duped << ele
        else
            duped += deep_dup(ele)
        end
    end

    duped
end