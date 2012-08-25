within HelmholtzMedia.Examples.Parameter;
model setSat_parameter
  package medium = HelmholtzFluids.Butane;

  medium.SaturationProperties sat;
  medium.Temperature T_test;

  parameter medium.Temperature T_input = 423.15;
  parameter medium.AbsolutePressure p_input = 101325;
  parameter medium.Density d_input = 229;

equation
// sat = medium.setSat_T(T=T_input);
// sat = medium.setSat_p(p=p_input);
sat = medium.setSat_d(d=d_input);
T_test = medium.Ancillary.saturationTemperature_d(sat.vap.d);

  annotation (experiment(Tolerance=1e-012), __Dymola_experimentSetupOutput);
end setSat_parameter;