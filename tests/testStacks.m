function tests = testStacks
    tests = functiontests(localfunctions);
end

function stackPropertiesTest(testCase)
    W=testCase.TestData.W;
    H=testCase.TestData.H;
    SPP=testCase.TestData.SPP;
    S1=testCase.TestData.S1;
    S2=testCase.TestData.S2;
    S3=testCase.TestData.S3;

    stack1D = uint8(zeros(H,W, 4, S1));
    stack1DNoAlpha = uint8(zeros(H, W, 3, S1));
    stack2D = uint8(zeros(H,W, 4, S1, S2));
    stack3D = uint8(zeros(H,W, 4, S1, S2, S3));
    stack1DGrayscale = uint8(zeros(H,W,S1));
    
    theProperties = stackProperties(stack1D);
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack1D')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack1D')
    verifyEqual(testCase, theProperties.samplesPerPixel, 4,'samplesPerPixel is incorrect for stack1D')
    verifyEqual(testCase, theProperties.hasAlpha, true,'hasAlpha is incorrect for stack1D')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for stack1D')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for stack1D')
    verifyEqual(testCase, theProperties.stackArraySizes, [S1],'stackArraySizes is incorrect for stack1D')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack1D')
    
    theProperties = stackProperties(stack1DNoAlpha);
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for stack1DNoAlpha')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for stack1DNoAlpha')
    

    theProperties = stackProperties(stack2D);
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack2D')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack2D')
    verifyEqual(testCase, theProperties.samplesPerPixel, 4,'samplesPerPixel is incorrect for stack2D')
    verifyEqual(testCase, theProperties.hasAlpha, true,'hasAlpha is incorrect for stack2D')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for stack2D')
    verifyEqual(testCase, theProperties.stackArrayDimension, 2,'stackArrayDimension is incorrect for stack2D')
    verifyEqual(testCase, theProperties.stackArraySizes, [S1, S2],'stackArraySizes is incorrect for stack2D')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack2D')

    theProperties = stackProperties(stack3D);
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack3D')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack3D')
    verifyEqual(testCase, theProperties.samplesPerPixel, 4,'samplesPerPixel is incorrect for stack3D')
    verifyEqual(testCase, theProperties.hasAlpha, true,'hasAlpha is incorrect for stack3D')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for stack3D')
    verifyEqual(testCase, theProperties.stackArrayDimension, 3,'stackArrayDimension is incorrect for stack3D')
    verifyEqual(testCase, theProperties.stackArraySizes, [S1, S2, S3],'stackArraySizes is incorrect for stack3D')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack3D')

    theProperties = stackProperties(stack1DGrayscale);
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.samplesPerPixel, 1,'samplesPerPixel is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.imageArrayDimension, 2,'imageArrayDimension is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.stackArraySizes, S1,'stackArraySizes is incorrect for stack1DGrayscale')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack1DGrayscale')

    theProperties = stackProperties('stack1D-rgb-multi.tif');
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.stackArraySizes, [S1],'stackArraySizes is incorrect for stack1D-multi')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack1D-multi')

    theProperties = stackProperties('stack2D-rgb-multi-\d\d\d.tif');
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.stackArrayDimension, 2,'stackArrayDimension is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.stackArraySizes, [S1 S2],'stackArraySizes is incorrect for stack2D-multi')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack2D-multi')

    theProperties = stackProperties('stack3D-rgb-multi-\d\d\d-\d\d\d.tif');
    verifyEqual(testCase, theProperties.height, H,'Height is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.width,  W,'Width is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.stackArrayDimension, 3,'stackArrayDimension is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.stackArraySizes, [S1 S2 S3],'stackArraySizes is incorrect for stack3D-multi')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for stack3D-multi')

end

function loadStackTest(testCase)

    s=loadStack('stack1D-rgba-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 4,'samplesPerPixel is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, true,'hasAlpha is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D rgba stack loaded from directory')

    s=loadStack('stack1D-rgb-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D rgb stack loaded from directory')

    s=loadStack('stack1D-grayscale-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 1,'samplesPerPixel is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D grayscale stack loaded from directory')

    s=loadStack('stack2D-rgb-\d\d\d-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 2,'stackArrayDimension is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, [testCase.TestData.S1 testCase.TestData.S2] ,'stackArraySizes is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 2D rgba stack loaded from directory')

    s=loadStack('stack3D-rgb-\d\d\d-\d\d\d-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 3,'stackArrayDimension is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, [testCase.TestData.S1 testCase.TestData.S2 testCase.TestData.S3],'stackArraySizes is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 3D rgba stack loaded from directory')

    s=loadStack('stack1D-rgba-%03d.tif', testCase.TestData.S1 );
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 4,'samplesPerPixel is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, true,'hasAlpha is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D rgba stack loaded from directory')

    s=loadStack('stack1D-rgb-%03d.tif', testCase.TestData.S1 );
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgb stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D rgb stack loaded from directory')


    s=loadStack('stack1D-grayscale-%03d.tif', testCase.TestData.S1 );
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 1,'samplesPerPixel is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D grayscale stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D grayscale stack loaded from directory')

    s=loadStack('stack2D-rgb-%03d-%03d.tif', [testCase.TestData.S1 testCase.TestData.S2]);
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 2,'stackArrayDimension is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, [testCase.TestData.S1 testCase.TestData.S2] ,'stackArraySizes is incorrect for 2D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 2D rgba stack loaded from directory')

    s=loadStack('stack3D-rgb-%03d-%03d-%03d.tif', [testCase.TestData.S1 testCase.TestData.S2 testCase.TestData.S3 ]);
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArrayDimension, 3,'stackArrayDimension is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.stackArraySizes, [testCase.TestData.S1 testCase.TestData.S2 testCase.TestData.S3],'stackArraySizes is incorrect for 3D rgba stack loaded from directory')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 3D rgba stack loaded from directory')

    s1=loadStack('stack3D-rgb-\d\d\d-\d\d\d-\d\d\d.tif');
    s2=Stack('stack3D-rgb-\d\d\d-\d\d\d-\d\d\d.tif');
    
    for i=1:testCase.TestData.S1
        for j=1:testCase.TestData.S2
            for k=1:testCase.TestData.S3
                verifyEqual(testCase, s1(:,:,:,i,j,k), s2(:,:,:,i,j,k), 'Stack object does not behave like an equivalent stack');
            end
        end
    end
    

end

function loadStackMultiTIFFTest(testCase)

    s=loadStack('stack1D-grayscale-multi.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 1,'samplesPerPixel is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D grasycale stack loaded from multi-page TIFF')

    s=loadStack('stack1D-rgb-multi.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D grasycale stack loaded from multi-page TIFF')

    s=loadStack('stack2D-rgb-multi-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 2,'stackArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArraySizes, [testCase.TestData.S1, testCase.TestData.S2],'stackArraySizes is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D grasycale stack loaded from multi-page TIFF')

    s=loadStack('stack3D-rgb-multi-\d\d\d-\d\d\d.tif');
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, testCase.TestData.H,'Height is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  testCase.TestData.W,'Width is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 3,'stackArrayDimension is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArraySizes, [testCase.TestData.S1, testCase.TestData.S2, testCase.TestData.S3],'stackArraySizes is incorrect for 1D grasycale stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D grasycale stack loaded from multi-page TIFF')

end

function loadStackRawTest(testCase)
    s=loadStack([testCase.TestData.TESTROOT  '/test.raw']);
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, 200,'Height is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  100,'Width is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgb stack loaded from multi-page TIFF')
%    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D rgb stack loaded from multi-page TIFF')    

    theProperties = stackProperties([testCase.TestData.TESTROOT  '/test.raw']);
    verifyEqual(testCase, theProperties.height, 200,'Height is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  100,'Width is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 3,'samplesPerPixel is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgb stack loaded from multi-page TIFF')
%    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 8,'bitsPerSample is incorrect for 1D rgb stack loaded from multi-page TIFF')    
end


function loadStackDotStackTest(testCase)
    s=loadStack([testCase.TestData.TESTROOT  '/test.stack']);
    theProperties = stackProperties(s);
    verifyEqual(testCase, theProperties.height, 200,'Height is incorrect for 1D rgb stack loaded from dotStack format')
    verifyEqual(testCase, theProperties.width,  50,'Width is incorrect for 1D rgb stack loaded from dotStack format')
    verifyEqual(testCase, theProperties.samplesPerPixel, 1,'samplesPerPixel is incorrect for 1D rgb stack loaded from dotStack format')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D rgb stack loaded from dotStack format')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgb stack loaded from dotStack format')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgb stack loaded from dotStack format')
%    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 16,'bitsPerSample is incorrect for 1D rgb stack loaded from multi-page TIFF')    

    theProperties = stackProperties([testCase.TestData.TESTROOT  '/test.stack']);
    verifyEqual(testCase, theProperties.height, 200,'Height is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.width,  50,'Width is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.samplesPerPixel, 1,'samplesPerPixel is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.hasAlpha, false,'hasAlpha is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.imageArrayDimension, 3,'imageArrayDimension is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.stackArrayDimension, 1,'stackArrayDimension is incorrect for 1D rgb stack loaded from multi-page TIFF')
%    verifyEqual(testCase, theProperties.stackArraySizes, testCase.TestData.S1,'stackArraySizes is incorrect for 1D rgb stack loaded from multi-page TIFF')
    verifyEqual(testCase, theProperties.bitsPerSample, 16,'bitsPerSample is incorrect for 1D rgb stack loaded from multi-page TIFF')    
end

function saveStackTest(testCase)

    saveStack(testCase.TestData.stack1D, 'saved-stack1D-rgba-%03d.tif');
    for i=1:testCase.TestData.S1
        filename = sprintf('stack1D-rgba-%03d.tif',i-1);
        saved = imread(['saved-' filename]);
        actual = imread(filename);
        verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
    end
    s=loadStack('saved-stack1D-rgba-\d\d\d.tif');    
    verifyEqual(testCase, testCase.TestData.stack1D, s, 'saved-stack1D-rgba-xxx.tif saved not recovered');
    
    saveStack(testCase.TestData.stack1DNoAlpha, 'saved-stack1D-rgb-%03d.tif');
    for i=1:testCase.TestData.S1
        filename = sprintf('stack1D-rgb-%03d.tif',i-1);
        saved = imread(['saved-' filename]);
        actual = imread(filename);
        verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
    end

    s=loadStack('saved-stack1D-rgb-\d\d\d.tif');
    verifyEqual(testCase, testCase.TestData.stack1DNoAlpha, s, 'saved-stack1D-rgb-xxx.tif saved not recovered');

    saveStack(testCase.TestData.stack1DGrayscale, 'saved-stack1D-grayscale-%03d.tif');
    for i=1:testCase.TestData.S1
        filename = sprintf('stack1D-grayscale-%03d.tif',i-1);
        saved = imread(['saved-' filename]);
        actual = imread(filename);
        verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
    end
    
    s=loadStack('saved-stack1D-grayscale-\d\d\d.tif');
    verifyEqual(testCase, testCase.TestData.stack1DGrayscale, s, 'saved-stack1D-grayscale-xxx.tif saved not recovered');

    saveStack(testCase.TestData.stack2D, 'saved-stack2D-rgb-%03d-%03d.tif');
    for i=1:testCase.TestData.S1
        for j=1:testCase.TestData.S2
            filename = sprintf('stack2D-rgb-%03d-%03d.tif',i-1,j-1);
            saved = imread(['saved-' filename]);
            actual = imread(filename);
            verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
        end
    end
    s=loadStack('saved-stack2D-rgb-\d\d\d-\d\d\d.tif');
    verifyEqual(testCase, testCase.TestData.stack2D, s, 'saved-stack2D-rgb-xxx-xxx.tif saved not recovered');

    saveStack(testCase.TestData.stack3D, 'saved-stack3D-rgb-%03d-%03d-%03d.tif');
    for i=1:testCase.TestData.S1
        for j=1:testCase.TestData.S2
            for k=1:testCase.TestData.S3
                filename = sprintf('stack3D-rgb-%03d-%03d-%03d.tif',i-1,j-1,k-1);
                saved = imread(['saved-' filename]);
                actual = imread(filename);
                verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
            end
        end
    end
    s=loadStack('saved-stack3D-rgb-\d\d\d-\d\d\d-\d\d\d.tif');
    verifyEqual(testCase, testCase.TestData.stack3D, s, 'saved-stack3D-rgb-xxx-xxx-xxx.tif saved not recovered');
end

function saveMultiTIFFStackTest(testCase)

    saveStack(testCase.TestData.stack1DNoAlpha, 'saved-stack1D-rgb-multi.tif');
    filename = sprintf('stack1D-rgb-multi.tif');
    saved = imread(['saved-' filename]);
    actual = imread(filename);
    verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
    
    saveStack(testCase.TestData.stack2D, 'saved-stack2D-rgb-multi-%03d.tif');
    for i=1:testCase.TestData.S1
        filename = sprintf('stack2D-rgb-multi-%03d.tif',i-1);
        saved = imread(['saved-' filename]);
        actual = imread(filename);
        verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
    end
    
    saveStack(testCase.TestData.stack3D, 'saved-stack3D-rgb-multi-%03d-%03d.tif');
    for i=1:testCase.TestData.S1
        for j=1:testCase.TestData.S2
            filename = sprintf('stack3D-rgb-multi-%03d-%03d.tif',i-1,j-1);
            saved = imread(['saved-' filename]);
            actual = imread(filename);
            verifyEqual(testCase, saved, actual, ['saved-' filename ' and ' filename ' do not match']);
        end
    end
    
end

function performanceLoadStackTest(testCase)

filename = 'stack1D-performance-multi.tif';
largeStack1D = uint8(rand(500,500,3,300));
numberOfBytes =  prod(size(largeStack1D));

value1 = cputime;
saveStack(largeStack1D, 'stack-1D-performance.tif');
value2 = cputime;
s=loadStack('stack-1D-performance.tif');
value3 = cputime;

saveRate = numberOfBytes/double(value2-value1)/1e6;
loadRate = numberOfBytes/double(value3-value2)/1e6;
assert(saveRate > 50 , 'Save rate lower than 50 Mbytes/seconds for multi-tiff (%.1f MBytes)', saveRate);
assert(loadRate > 50 , 'Load rate lower than 50 Mbytes/seconds for multi-tiff (%.1f MBytes)', loadRate);

verifyEqual(testCase, largeStack1D, s, 'During performance evaluation, stacks not recovered');

end


function setupOnce(testCase)

if length(which('stackProperties')) == 0
    errordlg('Most test will fail because the library ''dcclab'' is not in your MATLAB path. Run installLibrary.m from the dcclab folder, or add the dcclab folder and subfolders to your path');
end


testCase.TestData.origPath = pwd;
testCase.TestData.TESTROOT = pwd;
testCase.TestData.tmpFolder = tempname;
mkdir(testCase.TestData.tmpFolder)
copyfile('test.raw',testCase.TestData.tmpFolder)
copyfile('test.stack',testCase.TestData.tmpFolder)
copyfile('info.json',testCase.TestData.tmpFolder)
cd(testCase.TestData.tmpFolder)

W=6;
H=5;
SPP=4;
S1=5;
S2=6;
S3=7;

testCase.TestData.W=W;
testCase.TestData.H=H;
testCase.TestData.SPP=SPP;
testCase.TestData.S1=S1;
testCase.TestData.S2=S2;
testCase.TestData.S3=S3;

testCase.TestData.stack1D = uint8(rand(H,W, 4, S1));
testCase.TestData.stack1DNoAlpha = uint8(rand(H, W, 3, S1));
testCase.TestData.stack1DGrayscale = uint8(rand(H,W,1,S1));
testCase.TestData.stack2D = uint8(rand(H,W, 3, S1, S2));
testCase.TestData.stack3D = uint8(rand(H,W, 3, S1, S2, S3));

for i=1:testCase.TestData.S1
   filename = sprintf('stack1D-rgba-%03d.tif', i-1);
   imwrite(testCase.TestData.stack1D(:,:,:,i),filename);
   filename = sprintf('stack1D-rgb-%03d.tif', i-1);
   imwrite(testCase.TestData.stack1DNoAlpha(:,:,:,i),filename);
   filename = sprintf('stack1D-grayscale-%03d.tif', i-1);
   imwrite(testCase.TestData.stack1DGrayscale(:,:,:,i),filename);

    for j=1:testCase.TestData.S2
       filename = sprintf('stack2D-rgb-%03d-%03d.tif', i-1, j-1);
       imwrite(testCase.TestData.stack2D(:,:,:,i,j),filename);
        for k=1:testCase.TestData.S3
           filename = sprintf('stack3D-rgb-%03d-%03d-%03d.tif', i-1, j-1, k-1);
           imwrite(testCase.TestData.stack3D(:,:,:,i,j,k),filename);
        end        
    end
end

for i=1:testCase.TestData.S1
    filename = 'stack1D-rgb-multi.tif';
    if i == 0
       imwrite(testCase.TestData.stack1DNoAlpha(:,:,:,i),filename);
    else
       imwrite(testCase.TestData.stack1DNoAlpha(:,:,:,i),filename, 'WriteMode','append');
    end
    filename = 'stack1D-grayscale-multi.tif';
    if i == 0
       imwrite(testCase.TestData.stack1DGrayscale(:,:,1,i),filename);
    else
       imwrite(testCase.TestData.stack1DGrayscale(:,:,1,i),filename, 'WriteMode','append');
    end
    for j=1:testCase.TestData.S2
        filename = sprintf('stack2D-rgb-multi-%03d.tif', i-1);
        if j == 1
           imwrite(testCase.TestData.stack2D(:,:,:,i,j),filename);
        else
           imwrite(testCase.TestData.stack2D(:,:,:,i,j),filename, 'WriteMode','append');
        end
        for k=1:testCase.TestData.S3
           filename = sprintf('stack3D-rgb-multi-%03d-%03d.tif', i-1, j-1);
           if k == 1
              imwrite(testCase.TestData.stack3D(:,:,:,i,j,k),filename);
           else
              imwrite(testCase.TestData.stack3D(:,:,:,i,j,k),filename, 'WriteMode','append');
           end
        end        
    end
end

% create and save a figure
%     testCase.TestData.figName = 'tmpFig.fig';
%     aFig = createFigure;
%     saveas(aFig,testCase.TestData.figName,'fig')
%     close(aFig)

end

function teardownOnce(testCase)
cd(testCase.TestData.origPath);
rmdir(testCase.TestData.tmpFolder,'s');
end
