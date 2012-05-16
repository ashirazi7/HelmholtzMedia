within HelmholtzMedia.Examples;
model Test_inverse
  package Medium = HelmholtzFluids.Butane;
  Medium.Temperature Tsat;
  Medium.AbsolutePressure psat;

  Modelica.Blocks.Sources.Ramp T_ramp(
    height=250,
    duration=6,
    offset=135)
    annotation (Placement(transformation(extent={{-60,22},{-40,42}})));
  Modelica.Blocks.Sources.Ramp p_ramp(
    height=3.7e6,
    duration=7,
    offset=1) annotation (Placement(transformation(extent={{-58,-20},{-38,0}})));

equation
    psat =  p_ramp.y;
    Tsat =  Medium.saturationTemperature(p=psat);
    // Tsat = T_ramp.y;
    // psat = Medium.saturationPressure(T=Tsat);

  annotation (experiment(StopTime=10), __Dymola_experimentSetupOutput);
end Test_inverse;
