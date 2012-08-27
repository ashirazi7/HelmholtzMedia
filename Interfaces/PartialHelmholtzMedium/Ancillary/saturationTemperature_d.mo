within HelmholtzMedia.Interfaces.PartialHelmholtzMedium.Ancillary;
function saturationTemperature_d
  "ancillary iterative function: calculate saturation temperature for a given density by iterating the ancillary function"

  input Modelica.SIunits.Density d;
  output Modelica.SIunits.Temperature T;

protected
  constant MolarMass MM = fluidConstants[1].molarMass;
  constant SpecificHeatCapacity R=Modelica.Constants.R/MM
    "specific gas constant";
  constant Density d_crit=MM/fluidConstants[1].criticalMolarVolume;

  constant Temperature T_trip=fluidConstants[1].triplePointTemperature;
  constant Temperature T_crit=fluidConstants[1].criticalTemperature;

  Temperature T1=T_trip;
  Temperature T2=T_crit;
  Temperature T3;
  Temperature T4;

  Density R1 "residual of T1";
  Density R2 "residual of T2";
  Density R3 "residual of T3";
  Density R4= Modelica.Constants.inf "residual of T4";

  Real tolerance=1e-6 "tolerance for RES_d (in kg/m3)";
  Integer iter=0;
  constant Integer iter_max = 200;

algorithm
  // Modelica.Utilities.Streams.print("Ancillary.saturationTemperature_d, d=" + String(d), "printlog.txt");

  if (d<d_crit-tolerance) then
    // Modelica.Utilities.Streams.print("d<d_crit: vapour side", "printlog.txt");
    R1 := Ancillary.dewDensity_T(T1)-d;
    R2 := d_crit-d;
    while (abs(R4)>tolerance) and (iter<iter_max) loop
      iter:=iter+1;
      T3 := (T1+T2)/2;
      R3 := Ancillary.dewDensity_T(T3)-d;
      // caclutate better T from Ridder's method
      T4  := T3 + (T3 - T1)*sign(R1-R2)*R3/sqrt(R3*R3 - R1*R2);
      R4 := Ancillary.dewDensity_T(T4)-d;
      if (R4*R3<=0) then
        T1 := T3;
        R1 := R3;
        T2 := T4;
        R2 := R4;
      else
        if (R4*R1<0) then
          T2 := T4;
          R2 := R4;
        elseif (R4*R2<0) then
          T1 := T4;
          R1 := R4;
        else
          assert(false, "never get here");
        end if;
      end if;
      // Modelica.Utilities.Streams.print("Ridders' method: current residual R4=" + String(R4), "printlog.txt");
      // Modelica.Utilities.Streams.print("Ridders' method: new brackets T1=" + String(T1) + " and T2=" + String(T2), "printlog.txt");
    end while;
    // Modelica.Utilities.Streams.print("saturationTemperature_d_vap total iteration steps " + String(iter) + " for d_vap=" + String(d), "printlog.txt");
    // Modelica.Utilities.Streams.print(" ", "printlog.txt");
    assert(iter<iter_max, "saturationTemperature_d_vap did not converge, input was d_vap=" + String(d));
    T := T4;

  elseif (d>d_crit+tolerance) then
    // Modelica.Utilities.Streams.print("d>d_crit: liquid side", "printlog.txt");
    R1 := Ancillary.bubbleDensity_T(T1)-d;
    R2 := d_crit-d;
    while (abs(R4)>tolerance) and (iter<iter_max) loop
      iter:=iter+1;
      T3 := (T1+T2)/2;
      R3 := Ancillary.bubbleDensity_T(T3)-d;
      // caclutate better T from Ridder's method
      T4  := T3 + (T3 - T1)*sign(R1-R2)*R3/sqrt(R3*R3 - R1*R2);
      R4 := Ancillary.bubbleDensity_T(T4)-d;
      if (R4*R3<=0) then
        // opposite sign, T4 and T3 bracket the root
        T1 := T3;
        R1 := R3;
        T2 := T4;
        R2 := R4;
      else
        if (R4*R1<0) then
          T2 := T4;
          R2 := R4;
        elseif (R4*R2<0) then
          T1 := T4;
          R1 := R4;
        else
          assert(false, "never get here");
        end if;
      end if;
      // Modelica.Utilities.Streams.print("Ridders' method: current residual R4=" + String(R4), "printlog.txt");
      // Modelica.Utilities.Streams.print("Ridders' method: new brackets T1=" + String(T1) + " and T2=" + String(T2), "printlog.txt");
    end while;
    // Modelica.Utilities.Streams.print("saturationTemperature_d_liq total iteration steps " + String(iter) + " for d_liq=" + String(d), "printlog.txt");
    // Modelica.Utilities.Streams.print(" ", "printlog.txt");
    assert(iter<iter_max, "saturationTemperature_d_liq did not converge, input was d_liq=" + String(d));
    T := T4;

  else
    // Modelica.Utilities.Streams.print("d=d_crit: return critical Temperature", "printlog.txt");
    T := fluidConstants[1].criticalTemperature;
  end if;

end saturationTemperature_d;
