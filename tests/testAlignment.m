function tests = testAlignment
    tests = functiontests(localfunctions);
end

function affineTransformTest(testCase)
    a=zeros(500,600);
    b=a;
    center = [ size(a,1)/2 size(a,2)/2 ];
    offset = [10 20]; 
    
    a=circularMaskAtOffset(a, 0.1, center(1), center(2));
    b=circularMaskAtOffset(b, 0.1, offset(1)+center(1), offset(2)+center(2));
    
    c = affineTransformToRegisterImage(a,b)
   
    theTransformMatrix = c.T;
    
    verifyEqual(testCase, theTransformMatrix(3,1), offset(1),'Calculated component is wrong');
    verifyEqual(testCase, theTransformMatrix(3,2), offset(2),'Calculated component is wrong');
 
end

function setupOnce(testCase)

testCase.TestData.origPath = pwd;
testCase.TestData.TESTROOT = pwd;
testCase.TestData.tmpFolder = tempname;
mkdir(testCase.TestData.tmpFolder)
cd(testCase.TestData.tmpFolder)

end

function teardownOnce(testCase)
% delete(testCase.TestData.figName);
cd(testCase.TestData.origPath);
rmdir(testCase.TestData.tmpFolder,'s');
end
