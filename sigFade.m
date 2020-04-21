function[input] = sigFade(input,fade_length)
        fade_in = (linspace(0,1,fade_length))';
        fade_out = (linspace(1,0,fade_length))';
        one = size(input)-2*fade_length;
        fade_one = ones(one(1),1);
        fade_vec = [fade_in fade_in;fade_one fade_one;fade_out fade_out];
        input = input.* fade_vec; %%applys filter to input and returns the faded input