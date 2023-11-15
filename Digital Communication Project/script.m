% =================================================================================================================== %
%                                                                                                                     %
%                                            Digital Communication Project                                            %
%                                                                                                                     %
% =================================================================================================================== %

clc
close all


		%% Signal importation and reading

[signal, samplingFrequency] = audioread("audio1.wav");
audioinfo("audio1.wav")
% sound(signal, samplingFrequency)
samplingPeriod = 1 / samplingFrequency;
signalLength = length(signal);
signalDuration = signalLength * samplingPeriod;


		%% Time domain analysis

t = 0 : samplingPeriod : (signalLength - 1) * samplingPeriod;
figure(1)
plot(t(1 : 100), signal(1 : 100))
	% (1 : 100) returns the first 100 values of any vector
xlabel("Time (s) (100 first values)")
ylabel("Signal amplitude (V)")
grid on


		%% Frequency domain analysis

	%% 1st frequency domain analysis

frequencyRange = 0 : samplingFrequency / signalLength : samplingFrequency - samplingFrequency / signalLength;
signalFourierTransform = fft(signal) / samplingFrequency;
figure(2)
plot(frequencyRange, abs(signalFourierTransform))
	% we only need to plot the positive values
xlabel("Frequency (Hz)")
ylabel("Spectrum (V)")
grid on


	%% 2nd frequency domain analysis

frequencyRange2 = - samplingFrequency / 2 : samplingFrequency / signalLength : samplingFrequency / 2 - samplingFrequency / signalLength;
normalizedSignalFourierTransform = fftshift(fft(signal)) / samplingFrequency;
figure(3)
plot(frequencyRange2, abs(normalizedSignalFourierTransform))
	% we only need to plot the positive values
xlabel("Frequency (Hz)")
ylabel("Normalized spectrum (Vs)")
grid on


		%% Subsampling

subSamplingFactor = 4;
subSamplingFrequency = round(samplingFrequency / subSamplingFactor);
subSampledSignal = signal(1 : subSamplingFactor : end);
% sound(subSampledSignal, subSamplingFrequency)


		%% Quantization

quantizationLevels = 8;
q = (max(subSampledSignal) - min(subSampledSignal)) / (quantizationLevels - 1);
quantizedSignal = round(subSampledSignal / q);
reconstructedQuantizedSignal = quantizedSignal * q;
% sound(reconstructedQuantizedSignal, subSamplingFrequency)


		%% Signal to Quantization error Ratio

quantizationError = subSampledSignal - quantizedSignal;
squaredError = mean(quantizationError.^2 / length(subSampledSignal));
squaredSignal = mean(subSampledSignal.^2 / length(subSampledSignal));
SQR = squaredSignal / squaredError;


		%% Huffman compression

source = unique(quantizedSignal);
probabilities = zeros(1, length(source));
for subSamplingFactor = 1 : length(source)
	probabilities(subSamplingFactor) = length(find(quantizedSignal == source(subSamplingFactor))) / length(quantizedSignal);
end
figure(4)
bar(source, probabilities)
xlabel("Quantization level")
ylabel("Probabilty Distribution")
[dict, avglen] = huffmandict(source, probabilities);
compressedSignal = huffmanenco(quantizedSignal, dict);


		%% Error detection and correction using Hamming scheme

codedBits = 7;
informationBits = 4;
hammingEncodedMessage = encode(compressedSignal, codedBits, informationBits, "hamming");


		%% FSK modulation

newBitRate = subSamplingFrequency * 16;
carrierSignalAmplitude = 1;
newBitPeriod = 1 / newBitRate;
highCarrierFrequency = subSamplingFrequency * 8;
lowCarrierFrequency = subSamplingFrequency * 2;
timeVector = newBitPeriod / 99 : newBitPeriod / 99 : newBitPeriod;
timeVectorLength = length(timeVector);


	%% With error correction

FSKSignalHamming = [];
hammingEncodedMessageUsed = hammingEncodedMessage;
tic
for i = 1 : 1 : length(hammingEncodedMessageUsed)
	disp(i)
	if hammingEncodedMessageUsed(i) == 1
		y = carrierSignalAmplitude * cos(2 * pi * highCarrierFrequency * timeVector);
	else
		y = carrierSignalAmplitude * cos(2 * pi * lowCarrierFrequency * timeVector);
	end
	FSKSignalHamming = [FSKSignalHamming y];
end
toc


	%% Without error correction

FSKSignalNoHamming = [];
compressedSignalUsed = compressedSignal;
tic
for i = 1 : 1 : length(compressedSignalUsed)
	disp(i)
	if compressedSignalUsed(i) == 1
		y = carrierSignalAmplitude * cos(2 * pi * highCarrierFrequency * timeVector);
	else
		y = carrierSignalAmplitude * cos(2 * pi * lowCarrierFrequency * timeVector);
	end
	FSKSignalNoHamming = [FSKSignalNoHamming y];
end
toc


		%% Wireless transmission

	%% With error correction

normalizedFSKSignalHamming = FSKSignalHamming / sqrt(var(FSKSignalHamming));
hHamming = sqrt(1 / 2) * (randn(size(normalizedFSKSignalHamming)) + 1i * randn(size(normalizedFSKSignalHamming)));
noiseHamming = sqrt(2) * randn(size(normalizedFSKSignalHamming));
receivedSignalHamming = hHamming .* normalizedFSKSignalHamming + noiseHamming;

	%% Without error correction

normalizedFSKSignalNoHamming = FSKSignalNoHamming / sqrt(var(FSKSignalNoHamming));
hNoHamming = sqrt(1 / 2) * (randn(size(normalizedFSKSignalNoHamming)) + 1i * randn(size(normalizedFSKSignalNoHamming)));
noiseNoHamming = sqrt(2) * randn(size(normalizedFSKSignalNoHamming));
receivedSignalNoHamming = hNoHamming .* normalizedFSKSignalNoHamming + noiseNoHamming;


		%% FSK demodulation

	%% With error correction

complexSignalHamming = receivedSignalHamming ./ hHamming;
decodedMessageHamming = [];
for n = timeVectorLength : timeVectorLength : length(complexSignalHamming)
	t = newBitPeriod / 99 : newBitPeriod / 99 : newBitPeriod;
	highCarrierSignal = cos(2 * pi * highCarrierFrequency * t);
	lowCarrierSignal = cos(2 * pi * lowCarrierFrequency * t);
	modulatedSignal1 = highCarrierSignal .* complexSignalHamming((n - (timeVectorLength - 1)) : n);
	modulatedSignal2 = lowCarrierSignal .* complexSignalHamming((n - (timeVectorLength - 1)) : n);
	timeVector2 = newBitPeriod / 99 : newBitPeriod / 99 : newBitPeriod;
	integratedHighCarrierSignal = trapz(timeVector2, modulatedSignal1);
	integratedlowCarrierSignal = trapz(timeVector2, modulatedSignal2);
	if round(2 * integratedHighCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
		a = 1;
	elseif round(2 * integratedlowCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
		a = 0;
	end
	decodedMessageHamming = [decodedMessageHamming a];
end


	%% Without error correction

complexSignalNoHamming = receivedSignalNoHamming ./ hNoHamming;
decodedMessageNoHamming = [];
for n = timeVectorLength : timeVectorLength : length(complexSignalNoHamming)
	t = newBitPeriod / 99 : newBitPeriod / 99 : newBitPeriod;
	highCarrierSignal = cos(2 * pi * highCarrierFrequency * t);
	lowCarrierSignal = cos(2 * pi * lowCarrierFrequency * t);
	modulatedSignal1 = highCarrierSignal .* complexSignalNoHamming((n - (timeVectorLength - 1)) : n);
	modulatedSignal2 = lowCarrierSignal .* complexSignalNoHamming((n - (timeVectorLength - 1)) : n);
	timeVector2 = newBitPeriod / 99 : newBitPeriod / 99 : newBitPeriod;
	integratedHighCarrierSignal = trapz(timeVector2, modulatedSignal1);
	integratedlowCarrierSignal = trapz(timeVector2, modulatedSignal2);
	if round(2 * integratedHighCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
		a = 1;
	elseif round(2 * integratedlowCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
		a = 0;
	end
	decodedMessageNoHamming = [decodedMessageNoHamming a];
end


		%% Decoding

	%% Hamming decoding

decodedMessageHamming = decode(decodedMessageHamming, codedBits, informationBits, "hamming");


	%% Huffman decoding

huffmanDecodedMessageHamming = huffmandeco(decodedMessageHamming, dict);
huffmanDecodedMessageNoHamming = huffmandeco(decodedMessageNoHamming, dict);


	%% Bit Error Rate

BERHamming = biterr(compressedSignal, decodedMessageHamming')
BERNoHamming = biterr(compressedSignal, decodedMessageNoHamming')


		%% Received signal

receivedSignalHamming = huffmanDecodedMessageHamming * q;
figure(5)
plot(receivedSignalHamming(1 : 100))
xlabel("time (s) (100 first values)")
ylabel("Signal received with Hamming")

receivedSignalHammingNoHamming = huffmanDecodedMessageNoHamming * q;
figure(6)
plot(receivedSignalHammingNoHamming(1 : 100))
xlabel("time (s) (100 first values)")
ylabel("Signal received without Hamming")

% =================================================================================================================== %
%                                                                                                                     %
%                                            Digital Communication Project                                            %
%                                                                                                                     %
% =================================================================================================================== %