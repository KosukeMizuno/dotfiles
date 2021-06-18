# qutip operators
try:
    import qutip as qt
except ImportError:
    pass
else:
    # two-level-system
    from qutip import sigmax, sigmay, sigmaz, sigmap, sigmam, qeye, tensor

    # three-level-system
    Sx, Sy, Sz = qt.spin_Jx(1), qt.spin_Jy(1), qt.spin_Jz(1)
    Ix, Iy, Iz = qt.spin_Jx(1), qt.spin_Jy(1), qt.spin_Jz(1)
    Sp, Sm = Sx + 1j * Sy, Sx - 1j * Sy
    Ip, Im = Ix + 1j * Iy, Ix - 1j * Iy
    Si, Ii = qeye(3), qeye(3)

    # composite system of two three-level-system
    for s in 'i x y z p m'.split(' '):
        for i in 'i x y z p m'.split(' '):
            exec('S%sI%s = tensor(S%s, I%s)' % (s, i, s, i))
