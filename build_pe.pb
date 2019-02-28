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


      - name: Load override from a file.
        juniper_junos_config:
          provider: "{{ provider_info }}"
          load: 'merge'
          src: "{{playbook_dir}}/{{ inventory_hostname }}.conf"
        register: response
      - name: Print the complete response.
        debug:
          var: response