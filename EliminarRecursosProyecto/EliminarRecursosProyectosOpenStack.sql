-- Ids de proyectos de alumnos

SELECT id
FROM keystone.project
WHERE name IN ('alm067', 'jrm123');

-- Imágenes de cada proyecto

SELECT I.id, I.name, P.name
FROM glance.images I JOIN keystone.project P ON I.owner = P.id;

-- Imágenes de proyectos concretos

SELECT I.id, I.name, P.name
FROM glance.images I JOIN keystone.project P ON I.owner = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy')
) ORDER BY I.id;

-- Eliminar imágenes de proyectos concretos

SELECT CONCAT ('openstack image delete ', I.id)
FROM glance.images I JOIN keystone.project P ON I.owner = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy')
) ORDER BY I.id;

-- Instances de proyectos concretos

SELECT I.uuid, I.hostname, P.name
FROM nova.instances I JOIN keystone.project P ON I.project_id = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy') 
) ORDER BY I.uuid
;

--  Eliminar instancias de proyectos concretos

SELECT CONCAT ('openstack delete server ', I.uuid)
FROM nova.instances I JOIN keystone.project P ON I.project_id = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy')
) ORDER BY I.uuid
;


-- Attachements de volúmenes de instancias proyectos concretos

SELECT A.instance_uuid, A.id, A.mountpoint, I.hostname
FROM cinder.volume_attachment A JOIN nova.instances I ON A.instance_uuid = I.uuid
WHERE A.instance_uuid IN (
SELECT I.uuid
FROM nova.instances I JOIN keystone.project P ON I.project_id = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy'))
) ORDER BY A.instance_uuid, A.id;

-- Dettach los volúmenes de las instancias de proyectos concretos

SELECT CONCAT ('openstack server remove volume ', A.instance_uuid, ' ', A.id)
FROM cinder.volume_attachment A JOIN nova.instances I ON A.instance_uuid = I.uuid
WHERE A.instance_uuid IN (
SELECT I.uuid
FROM nova.instances I JOIN keystone.project P ON I.project_id = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy'))
) ORDER BY A.instance_uuid, A.id;

-- Volúmenes de proyetos concretos

SELECT V.id, V.host, V.size, V.display_name
FROM cinder.volumes V JOIN keystone.project P ON V.project_id = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy')
) ORDER BY V.id;

-- Eliminar volúmenes de proyectos concretos

SELECT CONCAT ('openstack volume delete ', V.id)
FROM cinder.volumes V JOIN keystone.project P ON V.project_id = P.id
WHERE P.id IN (
SELECT id
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy')
) ORDER BY V.id;

-- Proyectos concretos

SELECT id, name
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy');

-- Eliminar proyectos concretos

SELECT CONCAT ('openstack project delete ' , id)
FROM keystone.project
WHERE name IN ('xxxx', 'yyyy');
