---
   - name: "Create configurations for 'pe1' and 'pe2'"
     hosts:
       - pe1
       - pe2
     roles:
       - Juniper.junos
     connection: local
     gather_facts: no

     tasks:

     - name: Render interface configuration for junos devices
       template: 
         src: "{{ playbook_dir }}/PE_Template.j2" 
         dest: "{{ playbook_dir }}/{{ inventory_hostname }}.conf"