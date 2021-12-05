function untitled3
f = figure;
c = uicontrol(f,'Style','popupmenu');
c.Position = [20 75 60 20];
c.String = {'visual','start'};
c.Callback = @selection;

    function selection(src,event)
        val = c.Value;
        str = c.String;
        str{val};
        disp(['Selection: ' str{val}]);
    end

end