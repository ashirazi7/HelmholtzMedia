within HelmholtzMedia.Examples;
model setSat_parameter
  package Medium = HelmholtzFluids.R134a;

  Medium.SaturationProperties satProps;

  parameter Medium.Temperature T_input = 273.15;
  parameter Medium.AbsolutePressure p_input = 101325;

equation
  satProps = Medium.setSat_T(T=T_input);
//satProps = Medium.setSat_p(p=p_input);

  annotation (experiment(Tolerance=1e-012), __Dymola_experimentSetupOutput);
end setSat_parameter;
