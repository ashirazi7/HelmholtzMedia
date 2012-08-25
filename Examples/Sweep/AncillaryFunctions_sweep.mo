within HelmholtzMedia.Examples.Sweep;
model AncillaryFunctions_sweep
  package medium = HelmholtzFluids.Butane;
  medium.Temperature Tsat;
  medium.AbsolutePressure psat;
  medium.Density dliq;
  medium.Density dvap;

  medium.Temperature T_p;
  medium.Temperature T_dl;
  medium.Temperature T_dv;

  Modelica.Blocks.Sources.Ramp T_ramp(
    duration=5,
    startTime=2,
    height=T_crit - T_trip,
    offset=T_trip)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

protected
  constant medium.Temperature T_trip=medium.fluidConstants[1].triplePointTemperature;
  constant medium.Temperature T_crit=medium.fluidConstants[1].criticalTemperature;

algorithm
  // forward
  Tsat := T_ramp.y;
  psat := medium.Ancillary.saturationPressure_T(T=Tsat);
  dliq := medium.Ancillary.bubbleDensity_T(T=Tsat);
  dvap := medium.Ancillary.dewDensity_T(T=Tsat);

  // inverse
  T_p  := medium.Ancillary.saturationTemperature_p(p=psat);
  T_dl := medium.Ancillary.saturationTemperature_d(d=dliq);
  T_dv := medium.Ancillary.saturationTemperature_d(d=dvap);

annotation (experiment(StopTime=11,NumberOfIntervals=600));
end AncillaryFunctions_sweep;
