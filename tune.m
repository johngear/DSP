function[x,output] = tune(newFrame,N,bins,x,output,overlap,fade_length)
    fs = 44100;
    if length(x)~=N
        x = [x;newFrame];
    end
    if length(x) == N
        f = [];
        %Let's correct pitch now!
        overlapStart = N-N*overlap; %length of signal without overlap
        pit = pitch(x,fs,'WindowLength',overlapStart);
        f = pit(1,1);
        [~,diff] = mainFreqIdent(f,bins); %call John's function to receive f0
        dL = 0;
            if f~=0 
                dL = fix(overlapStart*diff./f); %length change to original signal without overlap
            end
        
        final = [];
        if dL < 0 %when pitch down
            dL = -1 * dL;
            y=x(1:overlapStart-dL)';
            spacing = fix(overlapStart/dL);
            for k = 1:dL
                final = [final;y((spacing-1)*(k-1)+1:(spacing-1)*k)];
                final = [final;y((spacing-1)*k)];
            end
            
            if mod(overlapStart,dL)~=0 %if there is remaining data in y
                
                final = [final;y((spacing-1)*dL+1:end)];
            end
            
        elseif dL>0
            y=x(1:overlapStart+dL)';
            spacing = fix((overlapStart+dL)/dL);
            for k = 1:dL
                final = [final;y(spacing*(k-1)+1:spacing*k-1)];
            end
            
            if mod(overlapStart+dL,dL)~=0
                final = [final;y(spacing*dL+1:end)];
            end
        else
            
            final = x(1:overlapStart)';
        end
        %end of Randall's pitch correction attempts
        newsig = [final final];
        newsig = sigFade(newsig,fade_length);%applying fade filter
        output = [output;newsig];
        h = N-N*overlap+1;
        x = x(h:end,:);
    end