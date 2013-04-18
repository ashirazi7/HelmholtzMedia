## HelmholtzMedia
This library is written in Modelica.
The purpose of this library is to calculate fluid properties from an equation of state (EoS), directly within Modelica and not from an external dll.
It supports EoS of the form f=f(T,d) meaning Helmholtz energy as a funtion of temperature and density.
In addition to all state properties, this library calculates viscosity, thermal conductivity and surface tension.  

### Related publications
* Thorade, M. and Saadat, A. (2012). "[HelmholtzMedia - A fluid properties library][1]"  
In: _Proceedings of the 9th International Modelica Conference_  
DOI: 10.3384/ecp1207663
* Thorade, M. "[Poster HelmholtzMedia][2]"  
VDI Thermodynamik-Kolloquium 2012  
* Thorade, M. and Saadat, A. (2013). "[Partial derivatives of thermodynamic state properties for dynamic simulation][3]"  
In: _Environmental Earth Sciences_  
DOI: 10.1007/s12665-013-2394-z




### Implemented Fluids
* Butane
* Ethanol
* Isobutane
* Isopentane
* Pentane (hyperbolic terms by Martin Ryhl K�rn)
* Propane
* R134a

### Fluids that might be included in future versions
* Butane (short technical EoS)
* HFC-125 (should be easy)
* HFC-1234yf (ECS viscosity model not yet implemented)
* CO2 (non-analytical terms not yet implemented)
* water according to IAPWS-95 (non-analytical terms not yet implemented)
* nitrogen
* methane
* ammonia
* helium
* working fluids for Organic-Rankine-Cycles.

[1]: http://goo.gl/Ynuky "Conference Paper: HelmholtzMedia implementation"
[2]: http://goo.gl/HeUzM "Conference Poster: HelmholtzMedia implementation"
[3]: http://goo.gl/HsDXN "ISI Journal Paper: Partial derivatives"