select * from persona
inner join experiencia_laboral
on persona.idpersona  = experiencia_laboral.persona_idpersona
order by persona.nombre;