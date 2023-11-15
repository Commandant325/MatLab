% =================================================================================================================== %
%                                                                                                                     %
%                                            Digital Communication Project                                            %
%                                                                                                                     %
% =================================================================================================================== %

clc
close all
[signal, samplingFrequency] = audioread("audio2.wav");
subSamplingFactor = 4;
subSamplingFrequency = round(samplingFrequency / subSamplingFactor);
subSampledSignal = signal(1 : subSamplingFactor : end);
quantizationLevels = 4;
q = (max(subSampledSignal) - min(subSampledSignal)) / (quantizationLevels - 1);
quantizedSignal = round(subSampledSignal / q) * q;
source = unique(quantizedSignal);
probabilities = zeros(1, length(source));
for subSamplingFactor = 1 : length(source)
	probabilities(subSamplingFactor) = length(find(quantizedSignal == source(subSamplingFactor))) / length(quantizedSignal);
end
[dict, avglen] = huffmandict(source, probabilities);
compressedSignal = huffmanenco(quantizedSignal, dict);
codedBits = 7;
informationBits = 4;
hammingEncodedMessage = encode(compressedSignal, codedBits, informationBits, "hamming");
newBitRate = subSamplingFrequency * 16;
carrierSignalAmplitude = 1;
newBitPeriod = 1 / newBitRate;
split = 50;
highCarrierFrequency = subSamplingFrequency * 8;
lowCarrierFrequency = subSamplingFrequency * 2;
timeVector = newBitPeriod / split : newBitPeriod / split : newBitPeriod;
timeVectorLength = length(timeVector);
tic
FSKSignalHamming = [];
for i = 1 : 1 : length(hammingEncodedMessage)
	disp(i)
	if hammingEncodedMessage(i) == 1
		y = carrierSignalAmplitude * cos(2 * pi * highCarrierFrequency * timeVector);
	else
		y = carrierSignalAmplitude * cos(2 * pi * lowCarrierFrequency * timeVector);
	end
	FSKSignalHamming = [FSKSignalHamming y];
end
toc
tic
FSKSignalNoHamming = [];
for i = 1 : 1 : length(compressedSignal)
	disp(i)
	if compressedSignal(i) == 1
		y = carrierSignalAmplitude * cos(2 * pi * highCarrierFrequency * timeVector);
	else
		y = carrierSignalAmplitude * cos(2 * pi * lowCarrierFrequency * timeVector);
	end
	FSKSignalNoHamming = [FSKSignalNoHamming y];
end
toc


		%% Signal to Noise Ratio

%%
SNR_dB = linspace(0, 10, 11);
%%
SNR = 10.^(SNR_dB / 10);
SNRLength = length(SNR_dB);
BERHamming = zeros(size(SNR_dB));
BERNoHamming = zeros(size(SNR_dB));


		%% Received Signal

normalizedFSKSignalHamming = FSKSignalHamming / sqrt(var(FSKSignalHamming));
normalizedFSKSignalNoHamming = FSKSignalNoHamming / sqrt(var(FSKSignalNoHamming));
%%
hHamming = randn(size(normalizedFSKSignalHamming)) + 1i * randn(size(normalizedFSKSignalHamming));
hNoHamming = randn(size(normalizedFSKSignalNoHamming)) + 1i * randn(size(normalizedFSKSignalNoHamming));
noiseHamming = randn(size(normalizedFSKSignalHamming)) + 1i * randn(size(normalizedFSKSignalHamming));
noiseNoHamming = randn(size(normalizedFSKSignalNoHamming)) + 1i * randn(size(normalizedFSKSignalNoHamming));
%%
for k = 1 : SNRLength
%%
	receivedSignalHamming = hHamming .* normalizedFSKSignalHamming + noiseHamming / sqrt(SNR(k));
	receivedSignalNoHamming = hNoHamming .* normalizedFSKSignalNoHamming + noiseNoHamming / sqrt(SNR(k));
	complexSignalHamming = hHamming .\ receivedSignalHamming;
%%
	decodedMessageHamming = [];
	for timeVector3 = timeVectorLength : timeVectorLength : length(complexSignalHamming)
		timeVector = newBitPeriod / split : newBitPeriod / split : newBitPeriod;
		highCarrierSignal = cos(2 * pi * highCarrierFrequency * timeVector);
		lowCarrierSignal = cos(2 * pi * lowCarrierFrequency * timeVector);
		modulatedSignalHigh = highCarrierSignal .* complexSignalHamming((timeVector3 - (timeVectorLength - 1)) : timeVector3);
		modulatedSignalLow = lowCarrierSignal .* complexSignalHamming((timeVector3 - (timeVectorLength - 1)) : timeVector3);
		timeVector2 = newBitPeriod / split : newBitPeriod / split : newBitPeriod;
		integratedHighCarrierSignal = trapz(timeVector2, modulatedSignalHigh);
		integratedlowCarrierSignal = trapz(timeVector2, modulatedSignalLow);
		if round(2 * integratedHighCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
			decodedAmplitude = 1;
		elseif round(2 * integratedlowCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
			decodedAmplitude = 0;
		end
		decodedMessageHamming = [decodedMessageHamming decodedAmplitude];
	end
%%
	complexSignalNoHamming = hNoHamming .\ receivedSignalNoHamming;
%%
	decodedMessageNoHamming = [];
	for timeVector3 = timeVectorLength : timeVectorLength : length(complexSignalNoHamming)
		timeVector = newBitPeriod / split : newBitPeriod / split : newBitPeriod;
		highCarrierSignal = cos(2 * pi * highCarrierFrequency * timeVector);
		lowCarrierSignal = cos(2 * pi * lowCarrierFrequency * timeVector);
		modulatedSignalHigh = highCarrierSignal .* complexSignalNoHamming((timeVector3 - (timeVectorLength - 1)) : timeVector3);
		modulatedSignalLow = lowCarrierSignal .* complexSignalNoHamming((timeVector3 - (timeVectorLength - 1)) : timeVector3);
		timeVector2 = newBitPeriod / split : newBitPeriod / split : newBitPeriod;
		integratedHighCarrierSignal = trapz(timeVector2, modulatedSignalHigh);
		integratedlowCarrierSignal = trapz(timeVector2, modulatedSignalLow);
		if round(2 * integratedHighCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
			decodedAmplitude = 1;
		elseif round(2 * integratedlowCarrierSignal / newBitPeriod) > carrierSignalAmplitude / 2
			decodedAmplitude = 0;
		end
		decodedMessageNoHamming = [decodedMessageNoHamming decodedAmplitude];
	end
	decoded_msg = decode(decodedMessageHamming, codedBits, informationBits, "hamming");
	huffman_decoded_with_hamming = huffmandeco(decoded_msg, dict);
	huffman_decoded_no_hamming = huffmandeco(decodedMessageNoHamming, dict);
	BERHamming(k) = biterr(compressedSignal(1 : 1400), decoded_msg(1 : 1400)');
	BERNoHamming(k) = biterr(compressedSignal(1 : 1400), decodedMessageNoHamming(1 : 1400)');
end
figure(1)
bar(SNR_dB, BERHamming)
title("BER with Hamming")
xlabel("SNR (dB)")
ylabel("No of errors")
figure(2)
bar(SNR_dB, BERNoHamming)
title("BER without Hamming")
xlabel("SNR (dB)")
ylabel("No of errors")

% =================================================================================================================== %
%                                                                                                                     %
%                                            Digital Communication Project                                            %
%                                                                                                                     %
% =================================================================================================================== %