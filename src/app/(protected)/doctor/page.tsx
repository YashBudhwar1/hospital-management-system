import React from 'react'
import { checkRole, getRole } from '@/utils/roles'
import { redirect } from 'next/navigation'

const DoctorDashboard = async() => {
    
    const isDoctor = await checkRole('DOCTOR');
    const role = await getRole();

    if (!isDoctor) {
        redirect('/${role}');
    }
  return (
    <div>Doctor Dashboard</div>
  )
}

export default DoctorDashboard;