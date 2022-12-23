{{/*
Expand the name of the chart.
*/}}
{{- define "hellowworld.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hellowworld.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hellowworld.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hellowworld.labels" -}}
helm.sh/chart: {{ include "hellowworld.chart" . }}
{{ include "hellowworld.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hellowworld.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hellowworld.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hellowworld.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hellowworld.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mycharts.labels" }}
    labels:
        creator: weiping
        datd: {{ now | htmlDate}}
{{- end }}

{{- define "random.secret" }}
{{- if and .Values.secret1.secret2.secret3.bloackkey.fromstring.active .Values.secret1.secret2.secret3.haskey.fromstring.active }}
{{- range $index, $key := .Values.secret.creds.secretid}}
cookie.block.key.{{$index}} : {{$key | b64enc | quote }}
{{- end}}

{{- range $index, $key := .Values.secret.creds.secretid }}
cookie.hash.key.{{index}} : {{ $key | b64enc | quote}}
{{- end}}
{{- else if and .Values.secret1.secret2.secret3.bloackkey.fromstring.active.secretName .Values.secret1.secret2.secret3.haskey.fromstring.active.secretName   }}
{{- else }}
cookie.block.key.random: {{ randAlphaNum 32 | b64enc | quote}}
cookie.hash.key.random: {{ randAlphaNum 16 | b64enc | quote}}
{{- end}}
{{- end}}

{{- define "secret.defaultlabels" }}
name: secrets
namespace: {{.Release.Namespace}}
release: {{.Release.Name}}
chart: secret
createdby: Yang
{{- end}}