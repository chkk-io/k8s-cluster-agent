{{/*
Expand the name of the chart.
*/}}
{{- define "chkk-cluster-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "chkk-cluster-agent.fullname" -}}
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

{{/* Allow KubeVersion to be overridden. */}}
{{- define "chkk-cluster-agent.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Get CronJob API Version */}}
{{- define "chkk-cluster-agent.cronjob.apiVersion" -}}
  {{- if .Capabilities.APIVersions.Has "batch/v1beta1" -}}
      {{- print "batch/v1beta1" -}}
  {{- else if .Capabilities.APIVersions.Has "batch/v1" -}}
    {{- print "batch/v1" -}}
  {{- else -}}
    {{- print "batch/v1" -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chkk-cluster-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "chkk-cluster-agent.labels" -}}
chkk-io.helm.sh/chart: {{ include "chkk-cluster-agent.chart" . }}
{{ include "chkk-cluster-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
chkk-io.app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
chkk-io.app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "chkk-cluster-agent.annotations" -}}
chkk.io/name: chkk-cluster-agent
chkk.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "chkk-cluster-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "chkk-cluster-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "chkk-cluster-agent.serviceAccountName" -}}
{{ include "chkk-cluster-agent.fullname" . }}
{{- end }}

{{/*
Create the name of the secret account to use
*/}}
{{- define "chkk-cluster-agent.secretName" -}}
{{ include "chkk-cluster-agent.fullname" . }}
{{- end }}

{{/*
CronJob labels
*/}}
{{- define "chkk-cluster-agent.cronjobLabels" -}}
chkk.io/name: chkk-cluster-agent
{{- end }}
