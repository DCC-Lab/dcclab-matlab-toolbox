function tests = testRegisterStack
    tests = functiontests(localfunctions);
end

function stackRegistrationTest(testCase)
a=imread('test.png');
T=100;

translationMatrix= affine2d([1 0 0; 0 1 0;T T 1]);
c = imwarp(a, imref2d(size(a)), translationMatrix, 'FillValues', 0);

% verifyTrue(testCase, similarity(c(T:M-T,T:N-T), a(T:M-T,T:N-T))<0.01,'not simil');

a=dftregistration(c,a)

end

function percent = similarity(a, b)

percent = sum(sum((b-a).*(b-a)./((b+a).*(b+a))))/prod(size(a));

end

function setupOnce(testCase)
testCase.TestData.origPath = pwd;
testCase.TestData.tmpFolder = ['tmpFolder' datestr(now,30)];
mkdir(testCase.TestData.tmpFolder)
cd(testCase.TestData.tmpFolder)

end

function teardownOnce(testCase)
cd(testCase.TestData.origPath);
rmdir(testCase.TestData.tmpFolder,'s');
end