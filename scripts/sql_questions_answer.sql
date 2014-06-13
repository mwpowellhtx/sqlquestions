
SELECT p.name, e.salary, a.zip FROM `address` a INNER JOIN `person` p ON a.id=p.address_id INNER JOIN `employment_info` e ON p.id=e.person_id ORDER BY a.zip, e.salary DESC
