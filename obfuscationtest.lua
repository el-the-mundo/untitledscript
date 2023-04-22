getgenv().yes = true

if yes then
    repeat
    task.wait(.5)
    print("ok")
    until not yes 
end