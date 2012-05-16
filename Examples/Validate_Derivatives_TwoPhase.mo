within HelmholtzMedia.Examples;
model Validate_Derivatives_TwoPhase
  "compare analytical derivatives to numerical derivatives"

  package Medium = HelmholtzFluids.Butane;
  // choose d and T which will result in two-phase
  parameter Medium.Density d=228;
  parameter Medium.Temperature T=298.15;

  Medium.ThermodynamicState state;
  Medium.ThermodynamicState d_plus;
  Medium.ThermodynamicState d_minus;
  Medium.ThermodynamicState T_plus;
  Medium.ThermodynamicState T_minus;
  Medium.ThermodynamicState h_plus;
  Medium.ThermodynamicState h_minus;
  Medium.ThermodynamicState p_plus;
  Medium.ThermodynamicState p_minus;

  // Enthalpy derivatives
  Medium.Types.DerEnthalpyByDensity dhdT_analytical;
  Medium.Types.DerEnthalpyByDensity dhdT_numerical;
  Medium.Types.DerEnthalpyByTemperature dhTd_analytical;
  Medium.Types.DerEnthalpyByTemperature dhTd_numerical;
  // Energy derivatives
  // Medium.Types.DerEnergyByDensity dudT_analytical;
  // Medium.Types.DerEnergyByDensity dudT_numerical;
  Medium.Types.DerEnergyByTemperature duTd_analytical;
  Medium.Types.DerEnergyByTemperature duTd_numerical;
  // Entropy derivatives
  // Medium.Types.DerEntropyByDensity dsdT_analytical;
  // Medium.Types.DerEntropyByDensity dsdT_numerical;
  // Medium.Types.DerEntropyByTemperature dsTd_analytical;
  // Medium.Types.DerEntropyByTemperature dsTd_numerical;
  // Density derivatives
  Medium.DerDensityByEnthalpy ddhp_analytical;
  Medium.DerDensityByEnthalpy ddhp_numerical;
  Medium.DerDensityByPressure ddph_analytical;
  Medium.DerDensityByPressure ddph_numerical;

equation
  state=Medium.setState_dTX(d=d, T=T);
  d_plus=Medium.setState_dTX(d=d*1.001, T=T);
  d_minus=Medium.setState_dTX(d=d*0.999, T=T);
  T_plus=Medium.setState_dTX(d=d, T=T*1.001);
  T_minus=Medium.setState_dTX(d=d, T=T*0.999);
  p_plus=Medium.setState_phX(p=state.p*1.001, h=state.h);
  p_minus=Medium.setState_phX(p=state.p*0.999, h=state.h);
  h_plus=Medium.setState_phX(p=state.p, h=state.h+abs(0.001*state.h));
  h_minus=Medium.setState_phX(p=state.p, h=state.h-abs(0.001*state.h));

  Modelica.Utilities.Streams.print("====|====|====|====|====|====|====|====|====|====|====|====|====|====|====|====|");

  // check (dh/dd)@T=const
  dhdT_analytical = Medium.specificEnthalpy_derd_T(state=state);
  dhdT_numerical = (d_plus.h-d_minus.h)/(d_plus.d-d_minus.d);
  Modelica.Utilities.Streams.print("(dh/dd)@T=const analytical= " + String(dhdT_analytical));
  Modelica.Utilities.Streams.print("(dh/dd)@T=const  numerical= " + String(dhdT_numerical));
  // check (dh/dT)@d=const
  dhTd_analytical = Medium.specificHeatCapacityCv(state=state)+1/state.d*Medium.saturationPressure_derT(T=state.T);
  dhTd_numerical = (T_plus.h-T_minus.h)/(T_plus.T-T_minus.T);
  Modelica.Utilities.Streams.print("(dh/dT)@d=const analytical= " + String(dhTd_analytical));
  Modelica.Utilities.Streams.print("(dh/dT)@d=const  numerical= " + String(dhTd_numerical));

  // check (du/dd)@T=const
  // dudT_analytical = f.R*T/d*f.tau*f.delta*f.rtd;
  // dudT_numerical = (d_plus.u-d_minus.u)/(d_plus.d-d_minus.d);
  // Modelica.Utilities.Streams.print("(du/dd)@T=const analytical= " + String(dudT_analytical));
  // Modelica.Utilities.Streams.print("(du/dd)@T=const  numerical= " + String(dudT_numerical));
  // check (du/dT)@d=const
  duTd_analytical = Medium.specificHeatCapacityCv(state=state);
  duTd_numerical = (T_plus.u-T_minus.u)/(T_plus.T-T_minus.T);
  Modelica.Utilities.Streams.print("(du/dT)@d=const analytical= " + String(duTd_analytical));
  Modelica.Utilities.Streams.print("(du/dT)@d=const  numerical= " + String(duTd_numerical));

  // check (ds/dd)@T=const
  // dsdT_analytical = f.R/d*(-(1+f.delta*f.rd)+(0+f.tau*f.delta*f.rtd));
  // dsdT_numerical = (d_plus.s-d_minus.s)/(d_plus.d-d_minus.d);
  // Modelica.Utilities.Streams.print("(ds/dd)@T=const analytical= " + String(dsdT_analytical));
  // Modelica.Utilities.Streams.print("(ds/dd)@T=const  numerical= " + String(dsdT_numerical));
  // check (ds/dT)@d=const
  // dsTd_analytical = f.R/T*(-f.tau^2*(f.itt+f.rtt));
  // dsTd_numerical = (T_plus.s-T_minus.s)/(T_plus.T-T_minus.T);
  // Modelica.Utilities.Streams.print("(ds/dT)@d=const analytical= " + String(dsTd_analytical));
  // Modelica.Utilities.Streams.print("(ds/dT)@d=const  numerical= " + String(dsTd_numerical));

  // check (dd/dh)@p=const
  ddhp_analytical = Medium.density_derh_p(state=state);
  ddhp_numerical = (h_plus.d-h_minus.d)/(h_plus.h-h_minus.h);
  Modelica.Utilities.Streams.print("(dd/dh)@p=const analytical= " + String(ddhp_analytical));
  Modelica.Utilities.Streams.print("(dd/dh)@p=const  numerical= " + String(ddhp_numerical));
  // check (dd/dp)@h=const
  ddph_analytical = Medium.density_derp_h(state=state);
  ddph_numerical = (p_plus.d-p_minus.d)/(p_plus.p-p_minus.p);
  Modelica.Utilities.Streams.print("(dd/dp)@h=const analytical= " + String(ddph_analytical));
  Modelica.Utilities.Streams.print("(dd/dp)@h=const  numerical= " + String(ddph_numerical));

  annotation (experiment(NumberOfIntervals=2), __Dymola_experimentSetupOutput);
end Validate_Derivatives_TwoPhase;
