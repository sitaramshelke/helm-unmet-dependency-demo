{{- /*
    common-lib.unmet_dependencies reads a structure of the following form
K8s namespace:
    K8s resource kind:
    - K8s resource name
K8s namespace:
.....

    and returns a string of the resources which aren't available in the K8s cluster
*/}}
{{- define "common-lib.unmet_dependencies" -}}
    {{- range $namespace, $kinds := . -}}
        {{- range $kind, $resources := $kinds -}}
            {{- range $name := $resources -}}
                {{- if not ((lookup "v1" $kind $namespace $name)) -}}
                hello
                    {{- printf "%s: %s," $kind $name -}}
                {{ end -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
{{- end -}}



{{- /*
    common-lib.unmet_dependencies_warning reads a structure of the following form
K8s namespace:
    K8s resource kind:
    - K8s resource name
K8s namespace:
.....
.....

    and returns a warning message if any of the required resource isn't present in the K8s cluster
*/}}
{{ define "common-lib.unmet_dependencies_warning" }}
{{ $unmet_dependencies_resources := (( include "common-lib.unmet_dependencies" . | trimAll "," |  splitList "," | compact )) }}
{{ if gt ((len $unmet_dependencies_resources)) 0  }}
!!!!! WARNING !!!!!
This Chart depends on the following resources to be present. This chart is deployed for you but it might not be fully functional unless the following resources are present.

  {{ $unmet_dependencies_resources | join ", " }}
  Total unmet dependencies: {{ len $unmet_dependencies_resources }}
{{ end }}
{{ end }}
