#  Pitch Correction (auto-tune) in Matlab
## By DSP People 
### John Gearig, Derek LaFaive, Marlon Greene, Randall Schliebe
----------------------------------------------------------------
### Introduction:

Hello! We are the DSP people. We are a group of Michigan electrical engineers who were tasked with developing software to display our knowledge of digital signal processing. 

As you know, singing is an incredibly difficult task, but singing the correct pitch at all times is even harder. Our groups’ goal was to develop an algorithm that would make this task much simpler. 

At a high level, our algorithm takes in an audio signal as the argument along with several customizable parameters, and outputs a pitch corrected version of the input signal. 



### Algorithm:

RANDALL ADD SHIT HERE

![Thumbnail of Slate](bins_image.png)


##  Functions:
### Now I will give a brief description of each Matlab file that we developed!

### Dashboard.m

The dashboard file is the only file that a user should ever interface with during most situations. This file allows the user to select the values for various filter parameters without having to dive into the lower levels of our code. After inputting the filter parameters, the liveProcessing function is called which performs signal modifications described by the user’s parameters and returns the original signal and modified signal. At the bottom of this file there are options to playback the input and output audio and to graphically compare the main pitch of each signal over time. 

### liveProcessing.m

The liveProcessing function takes in the user’s parameters selected in the dashboard and outputs the original input vector and the modified output vector. First, this function creates musical “bins”. A bin is essentially a range of frequencies that correspond to a specific note.for example, an A3 is supposed to be 220 Hz, so if we create a bin that ranges from 213-226Hz , we know that  all frequencies in that range should really be an A3. After developing the musical bins, this function iterates through the input file frame-by-frame and passes windows of samples to the other functions so that they can perform the necessary modifications. 

### Tune.m

The Tune function takes in the user’s defined parameters along with a new frame of audio from liveProcessing. This function is called every time that the liveProcessing function receives a new frame, and after receiving enough frames to make the desired window length, this function will begin to modify the audio in the following way: 

### mainFreqIdent.m 

This function is responsible for identifying how far off the audio’s frequency is from the desired frequency of the nearest musical note. This function will take in the fundamental frequency of the input audio and return what the necessary frequency shift is to reach the desired frequency. 


### sigFade.m

The sigFade function takes in the new audio signal and a fade length (chosen by the user in dashboard.m) and performs a fade-in and fade-out manipulation. Essentially this function just attenuates the beginning and end of each window so that the final output signal doesn’t have any audio clicking. This function returns the new audio signal with the necessary attenuation. 

### plotFreq.m

The plotFreq function takes in the input and output vectors along with a few other user defined parameters to graph our filter’s functionality. This function plots the fundamental pitch of the input and the output vs. time. This function can be called at the end of dashboard.m by uncommenting a few lines of code. 

# Results 

![Thumbnail of Slate](image1derek.png)
In order to evaluate the effectiveness of our algorithm, we analyzed our output signal using both graphical and auditory methods. Our first graphical assessment required the waterfall plots (Irvine, 2006) of the input and output FFTs. For those unfamiliar with the waterfall plot, it provides similar information compared to a spectogram.

As you can see, our pitch correction clearly shifts the frequency spectra of the original signal, concentrating at two major frequencies.

![Thumbnail of Slate](image2derek.png)

However, we require more information about the frequencies present within the signal. This leads to our plot of the original signal with high frequency resolution (meaning a small delta f).

However, we require more information about the frequencies present within the signal. This leads to our plot of the original signal with high frequency resolution (meaning a small delta f).

![Thumbnail of Slate](image3derek.png)

Based on our higher resolution, it is apparent that our original signal consists of a few frequency bands, most of which having a bandwidth between 5 and 10 Hz.

![Thumbnail of Slate](image4derek.png)

After correcting the signal, we can observe that the bandwidths have been altered drastically. The effective bandwidths for each band are smaller overall, and more emphasis is placed on the desired frequency (or musical note) from the frequency bins.

![Thumbnail of Slate](image5derek.png)

In addition, we plotted the pitch of the input signal (which is linearly increasing and decreasing over time) and compared it to the output signal pitch. It is evident that the algorithm generally shifts frequencies to their correct notes based on the frequency bin.

Based on the graphs shown previously, our algorithm is shifting with relatively high precision and accuracy. However in practice, this difference isn’t the most effective to the listener. In fact our group discovered a bit of a paradox, where our data looked promising (A.K.A shifted correctly) but sounded a bit lackluster in comparison to the ineffective shifts with drastically different sound. Some of these issues may lie within our code; however much of these issues show that audio analysis can be subjective. 

```markdown
%%Stereo file to be modified. Ex: 'dsp_SONG.wav'
input_file = 'drone.wav'; 

%%Size of the window in frames. Each frame has 1024 samples 
window_size = 10; 

%%Overlap percentage in decimal form (20% overlap = .2)
overlap = .2;

%%fade length in number of samples per fade-in and fade-out
fade_length = 128;

%%Call processing function and saving the input and output
[input,output] = liveProcessing(input_file,window_size,overlap,fade_length);
```





------------------------------------
everything below here will be deleted before submission



You can use the [editor on GitHub](https://github.com/johngear/DSP/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.


### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link]("https://johngear.github.io/DSP/") and ![Image](src)
```
[Image](bins_image.png)

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/johngear/DSP/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
