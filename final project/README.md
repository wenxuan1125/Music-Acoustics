# Final Project - Gayageum Modal Synthesis

This final project is an extension from assignment 2. In this project, we synthesized the sounds of an Eastern instrument, gayageum, and uses the synthesized sounds to play a Chinese pop song, “Love Mourning”.

The sampled sound file were downloaded from Freesound.  

Through analyzing the sound files of a few notes of gayageum by observing the magnitude spectrums at two 
different time points, we can know the partials which have the larger energies. We then estimated these partial frequencies and the parameters of the exponential amplitude envelope fit to each one. Then we simulated each note by synthesizing each partial separately using the estimated parameters. At first, we only synthesized the pentatonic  scale, the five notes, C, D, E, G and A, per octave. We then extended to other notes by interpolating these five notes. In totoal, our scale range covers 32 notes from C2 to G4. 

In order to express the diversity of the instrument, we tried to play out the songs with some new parameters, tempo, staccato and volume. Tempo is the 
speed at which a melody is played; Staccato is a form of musical articulation, which signifies a note of shortened  duration, separated from the note that may follow by silence; Volume represents how loud a note is.

The synthesized sounds and melody can be found in folder "/synthesized_sounds" 
