# NMR list
# gyromagnetic ratio 'gamma' [1e7 rad/Hz/T], spin quantum number 'I', natural abundance
nuclei_dict = {'e': (1.760e4, 1 / 2, 1.00),
               '1H': (26.752, 1 / 2, 0.99985),
               '2H': (4.107, 1, 0.00015),
               '3He': (-20.380, 1 / 2, 1.4e-6),
               '7Li': (10.398, 3 / 2, 0.9258),
               '12C': (0, 0, 0.9893),
               '13C': (6.728, 1 / 2, 0.01108),
               '14N': (1.934, 1, 0.99630),
               '15N': (-2.712, 1 / 2, 0.00370),
               '19F': (25.181, 1 / 2, 1),
               '31P': (10.841, 1 / 2, 1)}
# 'gamma_XX's denote the gyromagnetic ratio of XX spin in [Hz/T] unit.
for k, (gamma, I, na) in nuclei_dict.items():
    globals()['gamma_%s' % k] = gamma * 1e7 / 2 / np.pi


def calc_NMR_frequencies(B0):
    """B0: static magnetic field [T]"""
    for k, (gamma, I, na) in nuclei_dict.items():
        gy = eval('gamma_%s' % k)
        print('%s: %.6f [MHz]' % (k, gy * B0 / 1e6))


# DIAMOND CRYSTAL
def convert_qubiccm_to_ppm(rho_cm3):
    return rho_cm3 / 1.763e17


def convert_ppm_to_qubiccm(rho_ppm):
    return rho_ppm * 1.763e17


# PHYSICAL CONSTANTS
c0 = 299792458  # [m s^-1], speed of light
mu0 = 1.25663706212e-6  # [N A^-2], permeability in vacuum, magnetic constant
eps0 = 8.8541878128e-12  # [F m^-1], permittivity in vacuum, electric constant
G_Newton = 6.67430e-11  # [m^3 kg^-1 s^-2], Newtonian constant of gravitation
h_planck = 6.62607015e-34  # [J s] = [J Hz^-1], Planck constant
hbar = h_planck / (2 * np.pi)  # [m^2 kg s^-1] = [J Hz^-1 rad^-1], Dirac constant

q0 = e0 = 1.602176634e-19  # [C], elementary charge
K_Josephson = 483597.8484e9  # [Hz V^-1], Josephson constant
K_Josephson90 = 483597.9e9   # [Hz V^-1]
K_Klitzing = 25812.80745  # [Ohm]
mu_B = 9.2740100783e-24  # [J T^-1], Bohr magneton

kB = 1.380649e-23  # [J K^-1], Boltzmann constant
N_A = 6.02214076e23  # [mol^-1], Avogadro constant
mass_12C = 11.9999999958e-3  # [kg mol^-1], molar mass of carbon 12

T0 = 273.15  # [K], Temperature offset of 0 degC


# unit conversion
def Joule_to_eV(J):
    return J / q0


# Photons
def unit_conv_photon(la):
    """wavelength in nm ==> calc other features
    """
    _la = la * 1e-9  # in [m]
    print('Wavelength: {:.2f} [nm]'.format(la))
    print('Wavenumber: {:.2f} [1/cm]'.format(1 / _la / 100))
    print('Frequency : {:.4e} [Hz]'.format(c0 / _la))
    print('Energy    : {:.4f} [eV] = {:.4e} [J]'.format(h_planck * c0 / _la / q0, h_planck * c0 / _la))
    print('Momentum  : {:.4e} [N s]'.format(h_planck / _la))
