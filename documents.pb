---
   - name: "Create documentation for engineers and customer"
     hosts:
       - "{{ target }}"
     connection: local
     gather_facts: no

     tasks:
      - name: Render customer information
        template: 
          src: "{{ playbook_dir }}/Customer_Template.j2" 
          dest: "{{ playbook_dir }}/Customer_Information_For_Service_{{ service }}.md"

      - name: Render engineer information
        template: 
          src: "{{ playbook_dir }}/Engineer_Template.j2" 
          dest: "{{ playbook_dir }}/Engineer_Install_For_{{ target }}.md"
