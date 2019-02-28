---
  - name: Create configurations for 'pe1' and 'pe2'"
    hosts:
      - {{ inventory_hostname }}
    roles:
      - Juniper.junos
    connection: local
    gather_facts: no

    tasks:

    - name: Get ISIS neighbor information for "{{ target }}"
      uri:
        url: "http://utilities01.corepipe.co.uk:8080/search?neighbor={{ target }}"
        method: GET
        return_contents: yes
        status_code: 200,201,202
        headers:
          Content-Type: "application/json"
      register: isis_neighbors

    - name: Create ISIS interface metric map for neighbors facing "{{ target }}"
      set_fact:
        neighbormap: "{{ neighbormap }} + [ 'set protocols isis interface {{ item.iface.name }} level 2 metric 16777214' ]"
      with_items: "{{ isis_neighbors.json | list }}"
      when: item.iface.parent == inventory_hostname
    
    - name: ISIS neighbor commands for peer "{{ target }}"
      debug:
        var: neighbormap

    - name: Push ISIS interface metrics for peers facing "{{ target }}"
      juniper_junos_config:
         provider: "{{ provider_info }}"
         config_mode: "private"
         load: "set"
         lines: "{{ item }}"
      with_items: "{{ neighbormap }}"
      register: response