/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Adds Cpixel constant sin or cos

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfAddCpixelSinOrCosIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfAddCpixelSinOrCosIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 oldZ = z;
	REAL4 trigC = aux->const_c * fractal->transformCommon.constantMultiplierC111; // freq
	REAL4 trigC0 = trigC;

	if (!fractal->transformCommon.functionEnabledBxFalse)
	{
		// apply simple trig
		if (fractal->transformCommon.functionEnabledAx) trigC.x = native_sin(trigC0.x);
		if (fractal->transformCommon.functionEnabledAxFalse) trigC.x = native_cos(trigC0.x);
		if (fractal->transformCommon.functionEnabledAy) trigC.y = native_sin(trigC0.y);
		if (fractal->transformCommon.functionEnabledAyFalse) trigC.y = native_cos(trigC0.y);
		if (fractal->transformCommon.functionEnabledAz) trigC.z = native_sin(trigC0.z);
		if (fractal->transformCommon.functionEnabledAzFalse) trigC.z = native_cos(trigC0.z);
	}
	else
	{
		// mode2
		if (fractal->transformCommon.functionEnabledAx)
			trigC.x = (1.0f + native_sin(trigC0.x)) * native_divide(sign(trigC.x), 2.0f);
		if (fractal->transformCommon.functionEnabledAxFalse)
			trigC.x = (1.0f + native_cos(trigC0.x)) * native_divide(sign(trigC.x), 2.0f);
		if (fractal->transformCommon.functionEnabledAy)
			trigC.y = (1.0f + native_sin(trigC0.y)) * native_divide(sign(trigC.y), 2.0f);
		if (fractal->transformCommon.functionEnabledAyFalse)
			trigC.y = (1.0f + native_cos(trigC0.y)) * native_divide(sign(trigC.y), 2.0f);
		if (fractal->transformCommon.functionEnabledAz)
			trigC.z = (1.0f + native_sin(trigC0.z)) * native_divide(sign(trigC.z), 2.0f);
		if (fractal->transformCommon.functionEnabledAzFalse)
			trigC.z = (1.0f + native_cos(trigC0.z)) * native_divide(sign(trigC.z), 2.0f);
		// mode3
		if (fractal->transformCommon.functionEnabledByFalse) trigC *= trigC0;
	}
	trigC *= fractal->transformCommon.constantMultiplier111; // ampl

	// add cPixel
	if (!fractal->transformCommon.functionEnabledFalse)
	{
		z += trigC;
	}
	else
	{ // symmetical
		trigC = fabs(trigC);

		z.x += sign(z.x) * trigC.x;
		z.y += sign(z.y) * trigC.y;
		z.z += sign(z.z) * trigC.z;
	}

	// DE tweak (sometimes hepls)
	if (fractal->analyticDE.enabledFalse)
	{
		REAL tweakDE = native_divide(length(z), length(oldZ));
		aux->DE = mad(aux->DE * tweakDE, fractal->analyticDE.scale1, fractal->analyticDE.offset0);
	}
	return z;
}